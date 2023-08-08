using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JDash.InMemoryAnalytics.Modeling;
using IMA= JDash.InMemoryAnalytics.Engine;
using JDash.Helpers;
using JDash.WebForms;
using JDash.WebForms.Demo.JDash.Dashlets.DataAnalysis;


namespace Kalitte.Kalkinma.Dashboard.jdash.Dashlets.Dataanalysis
{
    public partial class georaphyviewEditor : System.Web.UI.UserControl
    {

        DashletContext context = null;
        List<CubeModel> cubes = DemoAnalysisProvider.GetCubes();
        const int stepCount = 4;
        public int Step
        {
            get
            {
                return ViewState["step"] != null ? (int)ViewState["step"] : 1;
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

        [JEventHandler(JEvent.ValidateDashletEditor)]
        public void ValidateDashletEditor(object sender, JEventArgs args)
        {
            var query = new IMA.MdQuery();
            var chart = new MapSettings();

            query.CubeName = ctlCube.SelectedValue;

            if (!string.IsNullOrEmpty(ctlPivotDimension.SelectedValue))
                query.Dimensions.Add(ctlPivotDimension.SelectedValue);

            query.Dimensions.Add(ctlFirstDimension.SelectedValue);

            query.Measures.Add(ctlFirstMetric.SelectedValue);

            query.Sort.Clear();


            chart.HasPivot = !string.IsNullOrEmpty(ctlPivotDimension.SelectedValue);
            if (chart.HasPivot)
            {

                query.Sort.Add(new IMA.Sort(ctlPivotDimension.SelectedValue, IMA.SortDirection.Ascending));
            }
            
            chart.Title = ctlHeader.Text;
            
            context.Model.config.SetObject("query", query);
            context.Model.config.SetObject("map", chart);
            context.SaveModel();
            context.DashletControl.DataBind();
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public override void DataBind()
        {
            ctlCube.DataSource = cubes;
            ctlCube.DataBind();

            IMA.MdQuery query = context.Model.config.GetObject<IMA.MdQuery>("query", null);
            MapSettings settings = context.Model.config.GetObject<MapSettings>("map", null);

            if (query != null)
            {
                ctlCube.SelectedIndex = cubes.FindIndex(p => p.Name == query.CubeName);
                LoadUI(query.CubeName, query, settings);
            }
            else LoadUI(cubes[0].Name);
            base.DataBind();
        }

        protected void ctlCube_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadUI(ctlCube.SelectedValue);
        }

        private void LoadUI(string cubeName, IMA.MdQuery query = null, MapSettings chart = null)
        {

            var cube = cubes.SingleOrDefault(p => p.Name == cubeName);
            if (cube == null)
                return;
            ctlHeader.Text = cube.Caption;
            ctlFirstDimension.DataSource = cube.Dimensions.Where(d => d.DimensionType == ("IL").ToString());
            ctlFirstDimension.DataBind();

            var dimensionList = new List<DimensionModel>(cube.Dimensions);
            dimensionList.Insert(0, new DimensionModel("", DataType.Text));


            ctlPivotDimension.DataSource = dimensionList;
            ctlPivotDimension.DataBind();

            ctlFirstMetric.DataSource = cube.Measures;
            ctlFirstMetric.DataBind();

            var measureList = new List<MeasureModel>(cube.Measures);
            measureList.Insert(0, new MeasureModel("", DataType.Text));



            var sortDirectionList = new List<string>(Enum.GetNames(typeof(global::JDash.InMemoryAnalytics.Engine.SortDirection)));


            if (query != null)
            {
                if (chart.HasPivot)
                {
                    ctlPivotDimension.SelectedIndex = cube.Dimensions.FindIndex(p => p.Name == query.Dimensions[0]) + 1;
                    ctlFirstDimension.SelectedIndex = cube.Dimensions.FindIndex(p => p.Name == query.Dimensions[1]);
                }
                else
                {
                    ctlFirstDimension.SelectedIndex = cube.Dimensions.FindIndex(p => p.Name == query.Dimensions[0]);
                }


                ctlFirstDimension.SelectedIndex = cube.Dimensions.FindIndex(p => p.Name == query.Dimensions[0]);



                ctlFirstMetric.SelectedIndex = cube.Measures.FindIndex(p => p.Name == query.Measures[0]);

                var sortList = FillSortColumns();


            }
            if (chart != null)
            {

                ctlHeader.Text = chart.Title;
            }
        }

        protected List<KeyValuePair<string, string>> FillSortColumns()
        {
            var allList = new List<KeyValuePair<string, string>>();
            allList.Add(new KeyValuePair<string, string>("", ""));

            if (!string.IsNullOrEmpty(ctlFirstDimension.SelectedValue) && ctlFirstDimension.SelectedItem != null)
                allList.Add(new KeyValuePair<string, string>(ctlFirstDimension.SelectedItem.Value, ctlFirstDimension.SelectedItem.Text));




            if (!string.IsNullOrEmpty(ctlFirstMetric.SelectedValue) && ctlFirstMetric.SelectedItem != null)
                allList.Add(new KeyValuePair<string, string>(ctlFirstMetric.SelectedItem.Value, ctlFirstMetric.SelectedItem.Text));

            if (!string.IsNullOrEmpty(ctlPivotDimension.SelectedValue) && ctlPivotDimension.SelectedItem != null)
                allList.Add(new KeyValuePair<string, string>(ctlPivotDimension.SelectedItem.Value, ctlPivotDimension.SelectedItem.Text));


            return allList;
        }

        protected void RebuildSortColumns(object sender, EventArgs e)
        {
            FillSortColumns();
        }

        protected void ctlNextButton_Click(object sender, EventArgs e)
        {
            handleStep(1);

        }

        protected void ctlPrevButton_Click(object sender, EventArgs e)
        {
            handleStep(-1);
        }

        private void handleStep(int stepDiff)
        {
            var newStep = Step + stepDiff;
            if (newStep >= 1 && newStep <= stepCount)
            {

                Step = newStep;
                ctlPrevButton.Attributes["style"] = Step == 1 ? "visibility:hidden" : "visibility:visible";
                ctlNextButton.Attributes["style"] = Step == stepCount ? "visibility:hidden" : "visibility:visible";
                ctlStepCounter.Text = string.Format("{0} / {1}", Step, stepCount);
                ctlStep1.Visible = ctlStep2.Visible = ctlStep3.Visible = ctlStep4.Visible = false;
                ctlStepCaption.Text = (String)GetGlobalResourceObject("Global", "ChartDataDashletStep" + Step);
                switch (Step)
                {
                    case 1:
                        ctlStep1.Visible = true;
                        break;
                    case 2:
                        ctlStep2.Visible = true;
                        break;
                    case 3:
                        ctlStep3.Visible = true;
                        break;
                    case 4:
                        ctlStep4.Visible = true;
                        break;
                }
            }
        }


    }
}