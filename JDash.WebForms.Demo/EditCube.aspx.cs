using JDash.InMemoryAnalytics.Engine;
using JDash.InMemoryAnalytics.Modeling;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JDash.WebForms.Demo
{
    public partial class EditCube : System.Web.UI.Page
    {
        [Serializable]
        class ModelItemView
        {
            public string Name { get; set; }
            public string Caption { get; set; }
            public string Type { get; set; }
            public string Format { get; set; }
            public bool IsMeasure { get; set; }
            public string AggregationType { get; set; }
        }



        protected void Page_Load(object sender, EventArgs e)
        {
            var cube = HttpContext.Current.Items["cube"] as CubeModel;
            if (!Page.IsPostBack)
            {
                ViewState["generatedSQL"] = cube.DataSourceID;
                BindModel(cube);
            }

        }

        protected void cubeModelRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                var list = ViewState["CurrentCube"] as List<ModelItemView>;
                list.RemoveAll(p => p.Name == e.CommandArgument.ToString());
                cubeModelRepeater.DataSource = list;
                cubeModelRepeater.DataBind();
                ViewState["CurrentCube"] = list;
            }
        }

        protected void cubeModelRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var model = e.Item.DataItem as ModelItemView;
                var ctlDataType = e.Item.FindControl("ctlDataType") as DropDownList;
                var ctlDimType = e.Item.FindControl("ctlDimType") as DropDownList;
                var ctlMeasurePanel = e.Item.FindControl("ctlMeasurePanel") as Panel;
                foreach (var type in Enum.GetNames(typeof(DataType)))
                {
                    ctlDataType.Items.Add(new ListItem(type, type));
                }
                ctlDataType.SelectedValue = model.Type;




                var ctlAgg = e.Item.FindControl("ctlAgg") as DropDownList;
                ctlAgg.SelectedValue = model.AggregationType;

                var ctlType = e.Item.FindControl("ctlType") as DropDownList;
                ctlType.SelectedValue = model.IsMeasure ? "Measure" : "Dimension";
                ctlMeasurePanel.Visible = model.IsMeasure;
                
            }
        }

        private void BindModel(CubeModel cube)
        {
            ctlCubeCaption.Text = cube.Caption;
            ctlDesc.Text = cube.Description;
            var items = new List<ModelItemView>();
            foreach (var item in cube.Dimensions)
            {
                items.Add(new ModelItemView()
                {
                    Name = item.Name,
                    Caption = item.Caption,
                    AggregationType = "",
                    Format = "",
                    IsMeasure = false,
                    Type = item.Type.ToString()
                });
            }
            foreach (var item in cube.Measures)
            {
                items.Add(new ModelItemView()
                {
                    Name = item.Name,
                    Caption = item.Caption,
                    AggregationType = item.Aggregation.ToString(),
                    Format = item.DefaultFormat == null ? "" : item.DefaultFormat.FormatString,
                    IsMeasure = true,
                    Type = item.Type.ToString()
                });
            }
            ViewState["CurrentCube"] = items;
            cubeModelRepeater.DataSource = items;
            cubeModelRepeater.DataBind();
            //if (Page.IsPostBack)
            //    ScriptManager.RegisterClientScriptBlock(Page, GetType(), "toogleMeasures", "toogleMeasures()", true);
            //else Page.ClientScript.RegisterStartupScript(GetType(), "toogleMeasures", "toogleMeasures()", true);

            if (Page.IsPostBack)
                ScriptManager.RegisterClientScriptBlock(Page, GetType(), "", "", true);
            else Page.ClientScript.RegisterStartupScript(GetType(), "", "", true);

        }

        private CubeModel GetModel(CubeModel model = null)
        {
            model = model == null ? new CubeModel() : model;
            model.Caption = ctlCubeCaption.Text;

            model.Description = ctlDesc.Text;
            model.Dimensions.Clear();
            model.Measures.Clear();
            foreach (RepeaterItem item in cubeModelRepeater.Items)
            {
                var ctlName = item.FindControl("ctlName") as Label;
                var ctlCaption = item.FindControl("ctlCaption") as TextBox;
                var ctlDataType = item.FindControl("ctlDataType") as DropDownList;
                var ctlType = item.FindControl("ctlType") as DropDownList;
                var ctlFormat = item.FindControl("ctlFormat") as TextBox;
                var ctlAgg = item.FindControl("ctlAgg") as DropDownList;
                if (ctlType.SelectedValue == "Measure")
                {
                    model.Measures.Add(new MeasureModel(ctlName.Text, (DataType)Enum.Parse(typeof(DataType), ctlDataType.SelectedValue))
                    {
                        Aggregation = (AggregationType)Enum.Parse(typeof(AggregationType), ctlAgg.SelectedValue),
                        Caption = ctlCaption.Text,
                        DefaultFormat = string.IsNullOrEmpty(ctlFormat.Text) ? null : new global::JDash.InMemoryAnalytics.View.DataFormat()
                        {
                            FormatString = ctlFormat.Text
                        }
                    });
                }
                else
                {
                    model.Dimensions.Add(new DimensionModel(ctlName.Text, (DataType)Enum.Parse(typeof(DataType), ctlDataType.SelectedValue))
                    {
                        Caption = ctlCaption.Text,
                        DefaultFormat = string.IsNullOrEmpty(ctlFormat.Text) ? null : new global::JDash.InMemoryAnalytics.View.DataFormat()
                        {

                            FormatString = ctlFormat.Text
                        }
                    });
                }
            }
            return model;
        }

        protected void ctlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            var parent = ((sender as WebControl).Parent as RepeaterItem);
            var ctlMeasurePanel = parent.FindControl("ctlMeasurePanel") as Panel;
            ctlMeasurePanel.Visible = (sender as DropDownList).SelectedValue == "Measure";
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            var cube = GetModel();
            MdQuery query = new MdQuery();
            query.CubeName = cube.Name;
            query.CatalogName = (string)ViewState["generatedSQL"];
            query.Measures.Add(cube.Measures.First().Name);
            query.Dimensions.Add(cube.Dimensions.First().Name);
            if (cube.Dimensions.Count > 1)
                query.Dimensions.Add(cube.Dimensions[1].Name);   
            HttpContext.Current.Items["cube"] = cube;
            HttpContext.Current.Items["query"] = query;
                        
            //Server.Transfer("demo.aspx");
            Server.Transfer("SelectDashboard.aspx");
        }


    }
}