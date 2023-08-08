using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using JDash.WebForms.Utils;

namespace JDash.WebForms.Demo.Controls.UI
{
    public class BsSwitch : CompositeControl, IPostBackEventHandler
    {
        public string OnLabel { get; set; }
        public string OffLabel { get; set; }
        public event EventHandler Change;

        public bool Checked
        {
            get
            {
                if (ViewState["checked"] == null)
                    return false;
                else return (bool)ViewState["checked"];
            }
            set
            {
                ViewState["checked"] = value;
                RecreateChildControls();
            }
        }
        HtmlGenericControl cb;

        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Div;
            }
        }

        protected override void CreateChildControls()
        {
            Controls.Clear();
            cb = new HtmlGenericControl("input");
            cb.Style.Add(HtmlTextWriterStyle.Visibility, "hidden");
            cb.Attributes.Add("type", "checkbox");
            if (Checked)
                cb.Attributes.Add("checked", "true");
            Controls.Add(cb);
            base.CreateChildControls();
        }

        protected override void AddAttributesToRender(HtmlTextWriter writer)
        {
            writer.AddAttribute("class", this.CssClass);
            writer.AddAttribute("data-on-label", OnLabel);
            writer.AddAttribute("data-off-label", OffLabel);
            base.AddAttributesToRender(writer);
        }

        protected override void Render(System.Web.UI.HtmlTextWriter writer)
        {
            base.Render(writer);
        }

        protected override void OnPreRender(EventArgs e)
        {
            var clevent = this.Page.ClientScript.GetPostBackEventReference(new PostBackOptions(this)
            {
                Argument = "value"
            });
            clevent = clevent.Replace("'value'", "value");

            var script = string.Format(
                "try {{ $('#{0}').bootstrapSwitch('destroy'); }} catch (e) {{null;}} $('#{0}').bootstrapSwitch(); $('#{0}').on('switch-change', function (e, data) {{" +
                "var $el = $(data.el), value = data.value; {1};}});", this.ClientID, clevent);

            var rm = ResourceManager.GetInstance();
            if (rm.ShouldCreateClient(this) && this.Visible)
            {
                ResourceManager.GetInstance().AddScript(script);
            }
            base.OnPreRender(e);
        }

        public void RaisePostBackEvent(string eventArgument)
        {
            var b = Convert.ToBoolean(eventArgument);
            this.Checked = b;
            if (Change != null)
                Change(this, EventArgs.Empty);
        }
    }
}
