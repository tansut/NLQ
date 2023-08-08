using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;
using JDash.WebForms.Demo.Helpers;


namespace JDash.WebForms.Demo.Controls.UI
{
    public enum InputType
    {
        text,
        password
    }


    public class BsTextBox : TextBox
    {
        public string Info { get; set; }
        public InputType Type { get; set; }

        protected override void AddAttributesToRender(System.Web.UI.HtmlTextWriter writer)
        {
            //writer.AddAttribute("type", Type.ToString());
            if (!string.IsNullOrWhiteSpace(Info))
                writer.AddAttribute("placeholder", Info);
            base.AddAttributesToRender(writer);
        }

        public string AuthRole { get; set; }
        protected override void OnPreRender(EventArgs e)
        {
            if (!Util.CheckUserInRole(AuthRole)) this.Visible = false;
            base.OnPreRender(e);
        }
        
    }
}
