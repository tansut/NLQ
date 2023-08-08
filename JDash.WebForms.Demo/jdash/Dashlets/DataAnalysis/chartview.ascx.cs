using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using JDash.InMemoryAnalytics.Engine;
using JDash.InMemoryAnalytics.Modeling;
using Helpers;
using System.Data;
using System.IO;
using JDash.Helpers;

namespace JDash.WebForms.Demo.JDash.Dashlets.DataAnalysis
{
    public enum ChartType
    {
        Bar,
        Column,
        Line,
        Area,
        Pie
    }



    public class ChartSettings
    {
        public ChartType ChartType { get; set; }
        public string Header { get; set; }
        public string Footer { get; set; }
        public string Height { get; set; }
        public bool HasPivotDimension { get; set; }
        public string Theme { get; set; }

        public readonly static List<KeyValuePair<string, string>> Themes;

        static ChartSettings()
        {
            Themes = new List<KeyValuePair<string, string>>(3);
            Themes.Add(new KeyValuePair<string, string>("default", Resources.Global.ChartThemeDefault));
            Themes.Add(new KeyValuePair<string, string>("gray", Resources.Global.ChartThemeGray));
            Themes.Add(new KeyValuePair<string, string>("green", Resources.Global.ChartThemeGreen));
            Themes.Add(new KeyValuePair<string, string>("blue", Resources.Global.ChartThemeBlue));
        }
    }

    public partial class chartview : System.Web.UI.UserControl
    {
        DashletContext context = null;
        List<CubeModel> cubes = null;

        [JEventHandler(JEvent.InitContext)]
        public void InitContext(object sender, JEventArgs args)
        {
            this.context = args.Event.Parameters.Get<DashletContext>("context");
        }

        [JEventHandler(JEvent.Refresh)]
        public void Refresh(object sender, JEventArgs args)
        {
            this.DataBind();
        }

        public override void DataBind()
        {

            try
            {
                var query = context.Model.config.GetObject<MdQuery>("query", null);
                var chartSettings = context.Model.config.GetObject<ChartSettings>("chart", null);
                var cube = context.Model.config.GetObject<CubeModel>("cube", null);
                var data = context.Model.config.Get<string>("data", null);

                if (query != null)
                {
                    cubes = new List<CubeModel>();
                    cubes.Add(cube);

                    var model = Serialization.JsonParse<List<List<object>>>(data);
                    model = model.TakeWhile(d => d != null).ToList();
                    var table = new DataTable();

                    var headers = model.First().TakeWhile(d => d != null);
                    foreach (var item in headers)
                    {
                        table.Columns.Add(new DataColumn(item.ToString()));
                    }

                    foreach (List<object> row in model.Skip(1))
                    {
                        table.Rows.Add(row.Take(headers.Count()).ToArray());
                    }

                    var newTable = new DataTable();
                    newTable.TableName = "";
                    foreach (DataColumn col in table.Columns)
                    {
                        var t = typeof(string);
                        if (cube.Measures.Any(p => p.Name == DataEngine.Identifier(col.ColumnName)))
                            t = typeof(decimal);
                        newTable.Columns.Add(col.ColumnName, t);
                    }

                    foreach (DataRow row in table.Rows)
                    {
                        newTable.Rows.Add(row.ItemArray);
                    }

                    query.SourceData = DynamicObject.ListFromDataTable(newTable);
                    var engine = new DataEngine(cube);
                    var chartData = engine.Execute(query);
                    var clientInfo = new { chart = chartSettings, data = chartData };
                    this.context.CallClient("setChartData", clientInfo);
                }
                else this.context.CallClient("createChart");
                context.RenderDashlet();
            }
            catch (Exception exc)
            {
                //throw;
                Console.Write(exc.Message);
            }

            base.DataBind();
        }
    }
}