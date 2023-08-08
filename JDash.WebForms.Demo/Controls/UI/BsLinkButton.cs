using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using JDash.WebForms.Demo.Helpers;

namespace JDash.WebForms.Demo.Controls.UI
{
    public class BsLinkButton : LinkButton
    {
        public bool DisableTheming { get; set; }
        public BsButtonType ButtonType { get; set; }
        public BsButtonSize ButtonSize { get; set; }
        public string AuthRole { get; set; }
        public bool FullWidth { get; set; }
        public string IconClass { get; set; }
        

        private string ButtonCssClass
        {
            get
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("btn");
                switch (ButtonSize)
                {
                    case BsButtonSize.mini:
                        sb.Append(" btn-mini");
                        break;
                    case BsButtonSize.small:
                        sb.Append(" btn-small");
                        break;
                    case BsButtonSize.large:
                        sb.Append(" btn-large");
                        break;
                    default:
                        break;
                }
                if (FullWidth) sb.Append(" btn-block");
                switch (ButtonType)
                {
                    case BsButtonType.primary:
                        sb.Append(" btn-primary");
                        break;
                    case BsButtonType.info:
                        sb.Append(" btn-info");
                        break;
                    case BsButtonType.success:
                        sb.Append(" btn-success");
                        break;
                    case BsButtonType.warning:
                        sb.Append(" btn-warning");
                        break;
                    case BsButtonType.danger:
                        sb.Append(" btn-danger");
                        break;
                    case BsButtonType.inverse:
                        sb.Append(" btn-inverse");
                        break;
                    case BsButtonType.link:
                        sb.Append(" btn-link");
                        break;
                    default:
                        break;
                }
                if (!IsEnabled) sb.Append(" disabled");
                return sb.ToString();

            }
        }

        protected override void CreateChildControls()
        {
            Controls.Clear();
            if (!string.IsNullOrEmpty(IconClass))
            {
                var icon = new HtmlGenericControl() { TagName = "i" };
                icon.Attributes.Add("class", IconClass);
                Controls.Add(icon);
                Controls.Add(new Literal() { Text = " " + this.Text });
            }
            base.CreateChildControls();
        }

        protected override void OnPreRender(EventArgs e)
        {
            if (!Util.CheckUserInRole(AuthRole)) this.Visible = false;
            base.OnPreRender(e);
        }
        protected override void AddAttributesToRender(System.Web.UI.HtmlTextWriter writer)
        {
            if (!DisableTheming)
            {
                writer.AddAttribute("class", ButtonCssClass);
            }
            this.Attributes.Remove("href");
            base.AddAttributesToRender(writer);
            writer.AddAttribute("href", string.IsNullOrEmpty(PostBackUrl) ? "#" : PostBackUrl);
        }

    }
}
