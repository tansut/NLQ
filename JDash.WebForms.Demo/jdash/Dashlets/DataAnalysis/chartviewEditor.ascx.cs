using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JDash.InMemoryAnalytics.Modeling;
using JDash.InMemoryAnalytics.Engine;
using JDash.Helpers;
using System.Data;
using Helpers;
using System.IO;
using System.Threading;

namespace JDash.WebForms.Demo.JDash.Dashlets.DataAnalysis
{
    public partial class chartviewEditor : System.Web.UI.UserControl
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

        DashletContext context = null;
        List<CubeModel> cubes = new List<CubeModel>();
        const int stepCount = 2;
        public int Step
        {
            get
            {
                return ViewState["step"] != null ? (int)ViewState["step"] : 0;
            }
            set
            {
                ViewState["step"] = value;
            }
        }


        [JEventHandler(JEvent.InitContext)]
        public void InitContext(object sender, JEventArgs args)
        {
            this.context = args.Event.Parameters.Get<DashletContext>("context");

        }

        [JEventHandler(JEvent.OpenDashletEditor)]
        public void DashletOpen(object sender, JEventArgs args)
        {
            this.context = args.Event.Parameters.Get<DashletContext>("context");

        }



        protected void ctlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            var parent = ((sender as WebControl).Parent as RepeaterItem);
            var ctlMeasurePanel = parent.FindControl("ctlMeasurePanel") as Panel;
            ctlMeasurePanel.Visible = (sender as DropDownList).SelectedValue == "Measure";
        }


        [JEventHandler(JEvent.ValidateDashletEditor)]
        public void ValidateDashletEditor(object sender, JEventArgs args)
        {
            MdQuery query = context.Model.config.GetObject<MdQuery>("query", null);
            if (query == null)
                query = new MdQuery();
            query.Dimensions.Clear();
            query.Measures.Clear();
            var chart = new ChartSettings();

            query.CubeName = "default";

            DataTable table;
            var cube = GetCubeModelFromInput(out table);
            List<string> headers = new List<string>();
            foreach (var col in table.Columns)
            {
                var dataCol = (DataColumn)col;
                headers.Add(dataCol.ColumnName);
            }
            Analytics.NLP.NLPEngine engine = new Analytics.NLP.NLPEngine();
            var engineResult = engine.GetMDQuery(headers.ToArray(), ctl_Txt_QueryText.Text.Replace(Environment.NewLine, " ").Trim());

            foreach (var item in engineResult.Dimensions)
            {
                query.Dimensions.Add(DataEngine.Identifier(item.Trim()));
            }


            foreach (var item in engineResult.Measures)
            {
                cube.Measures.Add(new MeasureModel()
                {
                    Aggregation = (AggregationType)Enum.Parse(typeof(AggregationType), item.Aggregation.ToString()),
                    Caption = item.Name.Trim(),
                    Type = DataType.Decimal,
                    Name = DataEngine.Identifier(item.Name.Trim()),
                    Source = DataEngine.Identifier(item.Name.Trim())
                });
                query.Measures.Add(DataEngine.Identifier(item.Name.Trim()));
            }


            chart.Header = "";
            chart.Footer = "";
            chart.Height = "400";
            chart.ChartType = (ChartType)Enum.Parse(typeof(ChartType), engineResult.GraphType.ToString());

            if (engineResult.Pivots.Any())
            {

                foreach (var item in engineResult.Pivots)
                {
                    query.Dimensions.Add(DataEngine.Identifier(item.Trim()));
                }
                chart.HasPivotDimension = true;
            }

            //if (!string.IsNullOrEmpty(ctlPivotDimension.SelectedValue))
            //    query.Dimensions.Add(ctlPivotDimension.SelectedValue);

            //query.Dimensions.Add(ctlFirstDimension.SelectedValue);

            //if (!string.IsNullOrEmpty(ctlSecondDimension.SelectedValue))
            //    query.Dimensions.Add(ctlSecondDimension.SelectedValue);


            //query.Measures.Add(ctlFirstMetric.SelectedValue);

            //query.Sort.Clear();
            //if (!string.IsNullOrEmpty(ctlSort.SelectedValue))
            //    query.Sort.Add(new Sort(ctlSort.SelectedValue, InMemoryAnalytics.Engine.SortDirection.Ascending));

            //chart.ChartType = (ChartType)Enum.Parse(typeof(ChartType), ctlChartTypes.SelectedValue);
            //chart.Header = ctlHeader.Text;
            //chart.Footer = ctlFooter.Text;
            //chart.Height = ctlHeight.Text;
            //chart.HasPivotDimension = !string.IsNullOrEmpty(ctlPivotDimension.SelectedValue);

            //chart.Theme = ctlTheme.SelectedValue;

            ////query.CatalogName = (string)ViewState["generatedSQL"];
            context.Model.config["txtQuery"] = ctl_Txt_QueryText.Text;
            context.Model.config["data"] = ctlSQL.Value;
            context.Model.config.SetObject("query", query);
            context.Model.config.SetObject("chart", chart);
            context.Model.config.SetObject("cube", Serialization.JsonParse<CubeModel>(Serialization.JsonStringify(cube)));
            context.SaveModel();
            context.DashletControl.DataBind();
        }

        protected void Page_Load(object sender, EventArgs e)
        {




        }

        protected void Button2_Click(object sender, EventArgs e)
        {



            //HttpContext.Current.Items["query"] = query;

            //Server.Transfer("demo.aspx");
            //Server.Transfer("SelectDashboard.aspx");
        }

        public double GetRandomNumber(double minimum, double maximum)
        {
            Random random = new Random();
            return random.NextDouble() * (maximum - minimum) + minimum;
        }

        public override void DataBind()
        {
            var tableScript = @"
        var rowCount = 300;
        var columnCount = 40;
        var myData = Handsontable.helper.createEmptySpreadsheetData(rowCount, columnCount),
          container = document.querySelector('.ctlSQLContainer');
        if(!container.hot){
            var colWidths = [];
            for (var i = 0; i < rowCount ; i++)
                colWidths.push(87);
            container.hot = new Handsontable(container, {
                data: myData,
                colWidths: colWidths,
                rowHeaders: true,
                width:810,
                height:450,
                colHeaders: false,
                fixedRowsTop: 1,
                fixedColumnsLeft: 0,
                afterChange : function() { 
                                debugger;  
                                if(container.hot) {
                                var inputId = '" + ctlSQL.ClientID + @"'; 
                                document.getElementById(inputId).value = JSON.stringify(container.hot.getData()); 
                             }
                        }
            });          
            setTimeout(function() { container.click(); },210);    
        }";

            ScriptManager.RegisterClientScriptBlock(this, GetType(), "handsontable", tableScript, true);

            List<List<object>> data = new List<List<object>>(300);

            if (!string.IsNullOrEmpty(ctlSQL.Value))
            {
                data = Serialization.JsonParse<List<List<object>>>(ctlSQL.Value);
            }
            else
            {
                dynamic dbData;
                context.Model.config.TryGetValue("data", out dbData);
                var dbDataString = dbData as string;
                if (!string.IsNullOrEmpty(dbDataString))
                {
                    ctlSQL.Value = dbDataString;
                    data = Serialization.JsonParse<List<List<object>>>(dbDataString);
                }
                else
                {
                    var headers = new List<object>(30);

                    var someData = new List<object>(40);
                    data.Add(headers);

                    headers.Add("Success Rate");
                    headers.Add("Student Count");
                    headers.Add("Educator Count");
                    headers.Add("Year");

                    for (int i = 4; i < 30; i++)
                    {
                        headers.Add(null);
                    }


                    //someData.Add(11.5);
                    //someData.Add(20);
                    //someData.Add(5);
                    //someData.Add(2010);
                    //data.Add(someData);

                    //someData = new List<object>();
                    Random rn = new Random();
                    for (int i = 0; i < 12; i++)
                    {
                        rn = new Random();
                        Thread.Sleep(10);
                        someData = new List<object>();
                        someData.Add(Math.Round(this.GetRandomNumber(20, 85),2));
                        someData.Add(rn.Next(40, 80));
                        someData.Add(rn.Next(5, 15));
                        someData.Add( i + 2005);
                        data.Add(someData);
                    }
                    //someData.Add(21.5);
                    //someData.Add(25);
                    //someData.Add(7);
                    //someData.Add(2011);
                    //data.Add(someData);

                    //someData.Add(21.5);
                    //someData.Add(25);
                    //someData.Add(7);
                    //someData.Add(2012);
                    //data.Add(someData);

                    //someData.Add(21.5);
                    //someData.Add(25);
                    //someData.Add(7);
                    //someData.Add(2013);
                    //data.Add(someData);

                    //someData.Add(21.5);
                    //someData.Add(25);
                    //someData.Add(7);
                    //someData.Add(2014);
                    //data.Add(someData);

                    //someData.Add(21.5);
                    //someData.Add(25);
                    //someData.Add(7);
                    //someData.Add(2015);
                    //data.Add(someData);

                    //someData.Add(21.5);
                    //someData.Add(25);
                    //someData.Add(7);
                    //someData.Add(2016);
                    //data.Add(someData);


                    for (int i = 2; i < 300; i++)
                    {
                        someData = new List<object>();
                        someData.Add(null);
                        someData.Add(null);
                        someData.Add(null);
                        someData.Add(null);
                        data.Add(someData);
                    }


                    var str = Serialization.JsonStringify(data);
                    ctl_Txt_QueryText.Text = "Show me Student Count Average by Year pivot by Success Rate using Bar";
                    ctlSQL.Value = str;
                }


            }
            var dataString = Serialization.JsonStringify(data);

            string script = @"
                var container = document.querySelector('.ctlSQLContainer');
                if(container.hot){
                    container.hot.loadData(" + dataString + @")
                }
            ";


            if (Page.IsPostBack)
                ScriptManager.RegisterClientScriptBlock(Page, GetType(), "loadingData", script, true);
            else Page.ClientScript.RegisterStartupScript(GetType(), "", "", true);


            dynamic val;
            if (context.Model.config.TryGetValue("txtQuery", out val))
                ctl_Txt_QueryText.Text = val as string;

            //MdQuery query = context.Model.config.GetObject<MdQuery>("query", null);
            //ChartSettings settings = context.Model.config.GetObject<ChartSettings>("chart", null);
            //var cube = context.Model.config.GetObject<CubeModel>("cube", null);
            //var data = context.Model.config.Get<string>("data", null);
            //if (cube != null && query != null && data != null)
            //{
            //    cubes.Clear();
            //    //ctlCube.DataSource = cubes;
            //    //ctlCube.DataBind();

                //    ctlTheme.DataSource = ChartSettings.Themes;
                //    ctlTheme.DataBind();
                //    ctlTheme.SelectedIndex = 0;

                //    if (query != null)
                //    {
                //        //ctlCube.SelectedIndex = cubes.FindIndex(p => p.Name == query.CubeName);
                //        LoadUI(cube, data, query, settings);
                //    }
                //    else LoadUI(cube);
                //}
                //base.DataBind();

                // }
        }



        private void LoadUI(CubeModel cube, string data = null, MdQuery query = null, ChartSettings chart = null)
        {

            //ctlHeader.Text = cube.Caption;
            //ctlFirstDimension.DataSource = cube.Dimensions;
            //ctlFirstDimension.DataBind();

            //var dimensionList = new List<DimensionModel>(cube.Dimensions);
            //dimensionList.Insert(0, new DimensionModel("", DataType.Text));

            //ctlSecondDimension.DataSource = dimensionList;
            //ctlSecondDimension.DataBind();

            //ctlPivotDimension.DataSource = dimensionList;
            //ctlPivotDimension.DataBind();

            //ctlFirstMetric.DataSource = cube.Measures;
            //ctlFirstMetric.DataBind();

            //var measureList = new List<MeasureModel>(cube.Measures);
            //measureList.Insert(0, new MeasureModel("", DataType.Text));



            //var sortDirectionList = new List<string>(Enum.GetNames(typeof(global::JDash.InMemoryAnalytics.Engine.SortDirection)));


            //if (query != null)
            //{
            //    if (chart != null && chart.HasPivotDimension)
            //    {
            //        ctlPivotDimension.SelectedIndex = cube.Dimensions.FindIndex(p => p.Name == query.Dimensions[0]) + 1;
            //        ctlFirstDimension.SelectedIndex = cube.Dimensions.FindIndex(p => p.Name == query.Dimensions[1]);
            //        if (query.Dimensions.Count > 2)
            //            ctlSecondDimension.SelectedIndex = cube.Dimensions.FindIndex(p => p.Name == query.Dimensions[2]) + 1;
            //    }
            //    else
            //    {
            //        ctlFirstDimension.SelectedIndex = cube.Dimensions.FindIndex(p => p.Name == query.Dimensions[0]);
            //        if (query.Dimensions.Count > 1)
            //            ctlSecondDimension.SelectedIndex = cube.Dimensions.FindIndex(p => p.Name == query.Dimensions[1]) + 1;
            //    }

            //    ctlFirstMetric.SelectedIndex = cube.Measures.FindIndex(p => p.Name == query.Measures[0]);

            //    var sortList = FillSortColumns();


            //    if (query.Sort.Count == 1)
            //    {
            //        ctlSort.SelectedIndex = sortList.FindIndex(p => p.Key == query.Sort[0].Column);
            //    }
            //}
            //if (chart != null)
            //{
            //    ctlChartTypes.SelectedValue = chart.ChartType.ToString();
            //    ctlHeader.Text = chart.Header;
            //    ctlFooter.Text = chart.Footer;
            //    ctlHeight.Text = chart.Height;
            //    ctlTheme.SelectedIndex = ChartSettings.Themes.FindIndex(p => p.Key == chart.Theme);
            //}

            //if (query != null)
            //{
            //    ctlSQL.Text = data;
            //}
        }

        protected List<KeyValuePair<string, string>> FillSortColumns()
        {
            //var allList = new List<KeyValuePair<string, string>>();
            //allList.Add(new KeyValuePair<string, string>("", ""));

            //if (!string.IsNullOrEmpty(ctlFirstDimension.SelectedValue) && ctlFirstDimension.SelectedItem != null)
            //    allList.Add(new KeyValuePair<string, string>(ctlFirstDimension.SelectedItem.Value, ctlFirstDimension.SelectedItem.Text));

            //if (!string.IsNullOrEmpty(ctlSecondDimension.SelectedValue) && ctlSecondDimension.SelectedItem != null)
            //    allList.Add(new KeyValuePair<string, string>(ctlSecondDimension.SelectedItem.Value, ctlSecondDimension.SelectedItem.Text));


            //if (!string.IsNullOrEmpty(ctlFirstMetric.SelectedValue) && ctlFirstMetric.SelectedItem != null)
            //    allList.Add(new KeyValuePair<string, string>(ctlFirstMetric.SelectedItem.Value, ctlFirstMetric.SelectedItem.Text));

            //if (!string.IsNullOrEmpty(ctlPivotDimension.SelectedValue) && ctlPivotDimension.SelectedItem != null)
            //    allList.Add(new KeyValuePair<string, string>(ctlPivotDimension.SelectedItem.Value, ctlPivotDimension.SelectedItem.Text));

            //var sort1 = ctlSort.SelectedValue;

            //ctlSort.DataSource = allList;
            //ctlSort.DataBind();

            //ctlSort.SelectedIndex = allList.FindIndex(p => p.Key == sort1);

            //return allList;

            return null;
        }

        protected void RebuildSortColumns(object sender, EventArgs e)
        {
            FillSortColumns();
        }

        protected void ctlNextButton_Click(object sender, EventArgs e)
        {
            handleStep(1);
            DataBind();

        }

        protected void ctlPrevButton_Click(object sender, EventArgs e)
        {
            handleStep(-1);
            DataBind();
        }

        private void handleStep(int stepDiff)
        {
            var newStep = Step + stepDiff;
            if (newStep >= 0 && newStep <= stepCount)
            {

                Step = newStep;
                ctlPrevButton.Attributes["style"] = Step == 0 ? "visibility:hidden" : "visibility:visible";
                ctlNextButton.Attributes["style"] = Step == stepCount - 1 ? "visibility:hidden" : "visibility:visible";
                ctlStepCounter.Text = string.Format("{0} / {1}", Step + 1, stepCount);
                ctlStep0.Visible = ctlStep1.Visible = false; //= ctlStep2.Visible = ctlStep3.Visible = ctlStep4.Visible = ctlStep5.Visible = false;
                ctlStepCaption.Text = (String)GetGlobalResourceObject("Global", "ChartDataDashletStep" + Step);
                switch (Step)
                {
                    case 0:
                        {
                            ctlStep0.Visible = true;
                            break;
                        }
                    case 1:
                        {
                            ctlStep1.Visible = true;
                            break;
                        }
                }
            }
        }

        private CubeModel GetCubeModelFromInput(out DataTable table)
        {
            var model = Serialization.JsonParse<List<List<object>>>(ctlSQL.Value);
            model = model.TakeWhile(d => d != null).ToList();

            table = new DataTable();

            var headers = model.First().TakeWhile(d => d != null);
            foreach (var item in headers)
            {
                table.Columns.Add(new DataColumn(item.ToString()));
            }

            foreach (List<object> row in model.Skip(1))
            {
                table.Rows.Add(row.Take(headers.Count()).ToArray());
            }

            //StringReader reader = new StringReader(ctlSQL.Value);
            //GenericParserAdapter adapter = new GenericParserAdapter(reader);
            //adapter.FirstRowHasHeader = true;

            //var ds = adapter.GetDataSet();
            //table = ds.Tables[0];
            var cubeModel = CubeModel.GenerateFromDataTable(table);
            return cubeModel;
        }


    }
}