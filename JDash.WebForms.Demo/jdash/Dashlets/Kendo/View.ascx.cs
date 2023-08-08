using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JDash.Models;

using JDash.WebForms.Utils;

namespace JDash.WebForms.Demo.JDash.Dashlets.Kendo
{
    public class ViewBase : System.Web.UI.UserControl
    {
        protected DashletContext context = null;

        [JEventHandler(JEvent.InitContext)]
        public void InitContext(object sender, JEventArgs args)
        {
            this.context = args.Event.Parameters.Get<DashletContext>("context");
        }

    }


    public partial class View : ViewBase
    {


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public override void DataBind()
        {
            //
            //var themex = context.Model.config.Get<string>("theme", null);
            //if (preset != null)
            //{
            //    var templates = getTemplates();
            //    string datax = null;
            //    if (templates.TryGetValue(preset, out datax))
            //        context.CallClient("setOptions", new { data = datax, theme = themex});
            //}


            var myData = new
            {
                totalVisits = new int[] { 12, 34, 43, 55, 66, 44 },
                uniqueVisitors = new int[] { 1, 3, 4, 5, 6, 6 }
            };

            var preset = context.Model.config.Get<string>("preset", null);

            var options = new
            {
                type = preset,
                data = myData
            };


            context.CallClient("setOptions", options);

            base.DataBind();
        }

        [JEventHandler("layoutChanged")]
        public void RecieveMessage(object sender, JEventArgs args)
        {
            this.context.CallClient("publishEvent", args.Event.Parameters["layoutType"]);
        }



        [JEventHandler(JEvent.Refresh)]
        public void Refresh(object sender, JEventArgs args)
        {
            DataBind();
        }


        private IEnumerable<dynamic> GetPresetsDictionary()
        {
            var presets = File.ReadAllText(Server.MapPath("~/jdash/Dashlets/JqPlot/resources/presets.json"));
            return SerializationUtils.Deserialize<IEnumerable<dynamic>>(presets).Select(s => s.chartConfig.config); ;
        }


        private Dictionary<string, string> getTemplates()
        {
            var filePath = Server.MapPath(this.ResolveUrl("./resources/templates.txt"));
            var templates = File.ReadAllText(filePath).Split(new string[] { "#template#" }, StringSplitOptions.RemoveEmptyEntries);
            var res = new Dictionary<string, string>();
            foreach (var item in templates)
            {
                var data = item.Split(new string[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
                res.Add(data[0], data[1]);
            }


            return res;

        }


    }
}