using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JDash;


namespace JDash.WebForms.Demo.JDash.Dashlets.Html
{
    public partial class Edit : System.Web.UI.UserControl
    {
        DashletContext context = null;

        public override void DataBind()
        {
            html.Text = context.Model.config.Get<string>("html", "");
            base.DataBind();
        }

        [JEventHandler(JEvent.InitContext)]
        public void InitContext(object sender, JEventArgs args)
        {
            this.context = args.Event.Parameters.Get<DashletContext>("context");
        }

        [JEventHandler(JEvent.ValidateDashletEditor)]
        public void ValidateDashletEditor(object sender, JEventArgs args)
        {
            context.Model.config["html"] = html.Text;
            var currentClass = context.Model.paneConfig.Get<string>("cssClass", "");
            context.SaveModel();
            context.DashletControl.DataBind();
        }
    }
}