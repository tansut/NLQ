using JDash.InMemoryAnalytics.Engine;
using JDash.InMemoryAnalytics.Modeling;
using JDash.WebForms;
using JDash.WebForms.Demo.JDash.Dashlets.DataAnalysis;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Kalitte.Kalkinma.Dashboard.jdash.Dashlets.Dataanalysis
{
    public class MapSettings{
        public string Title { get; set; }
        public bool HasPivot { get; set; }

    }
    public partial class geographyview : System.Web.UI.UserControl
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
                var mapSettings = context.Model.config.GetObject<MapSettings>("map", null);
                if (query != null)
                {
                    cubes = DemoAnalysisProvider.GetCubes();
                    var activeCube = cubes.SingleOrDefault(p => p.Name == query.CubeName);
                    if (activeCube != null)
                    {
                        query.SourceData = DemoAnalysisProvider.GetSourceData(query.CubeName);
                        var engine = new DataEngine(activeCube);
                        var geoData = engine.Execute(query);
                        var clientInfo = new { map=mapSettings, data = geoData };
                        this.context.CallClient("drawMap", clientInfo,true);
                    }
                }
               
                context.RenderDashlet();
            }
            catch
            {
                throw;
            }

            base.DataBind();
        }
    }
}