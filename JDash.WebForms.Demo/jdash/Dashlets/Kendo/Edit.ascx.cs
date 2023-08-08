using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JDash;

using JDash.WebForms.Utils;
using JDash.Models;

namespace JDash.WebForms.Demo.JDash.Dashlets.Kendo
{
    public partial class Edit : System.Web.UI.UserControl
    {
        public readonly static List<KeyValuePair<string, string>> Themes;

        static Edit()
        {
            Themes = new List<KeyValuePair<string, string>>(3);
            Themes.Add(new KeyValuePair<string, string>("default", Resources.Global.ChartThemeDefault));
            Themes.Add(new KeyValuePair<string, string>("gray", Resources.Global.ChartThemeGray));
            Themes.Add(new KeyValuePair<string, string>("green", Resources.Global.ChartThemeGreen));
            Themes.Add(new KeyValuePair<string, string>("blue", Resources.Global.ChartThemeBlue));
        }

        DashletContext context = null;

        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [JEventHandler(JEvent.InitContext)]
        public void InitContext(object sender, JEventArgs args)
        {
            this.context = args.Event.Parameters.Get<DashletContext>("context");
        }

        [JEventHandler(JEvent.ValidateDashletEditor)]
        public void ValidateDashletEditor(object sender, JEventArgs args)
        {
            context.Model.config["preset"] = ctlPresets.SelectedValue;
            context.Model.config["theme"] = ctlTheme.SelectedValue;
            context.SaveModel();
            context.DashletControl.DataBind();
        }

        public override void DataBind()
        {
            //var peresets = getTemplates();
            //ctlPresets.DataSource = getTemplates().Select(x => x.Key).ToList();
            ctlTheme.DataSource = Edit.Themes;
            var selected = context.Model.config.Get<string>("preset", null);
            var theme = context.Model.config.Get<string>("theme", null);
            if (selected != null)
                ctlPresets.SelectedValue = selected;
            else ctlPresets.SelectedIndex = 0;
            if (theme != null)
                ctlTheme.SelectedValue = theme;
            else ctlTheme.SelectedIndex = 0;
            
            //ctlPresets.DataBind();
            ctlTheme.DataBind();
        }

        private void setDynamicValue(Dictionary<string, object> config, string key, object value, bool validate = true)
        {
            if (validate && value.GetType() == typeof(string) && value.ToString().Trim().Length == 0) return;
            if (!config.ContainsKey(key)) config.Add(key, value); else config[key] = value;
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



        protected void ctlPresets_SelectedIndexChanged(object sender, EventArgs e)
        {

            // context.RenderDashlet();
        }

    }
}