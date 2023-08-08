using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;
using JDash.WebForms.Demo.Helpers;

namespace JDash.WebForms.Demo.Controls.UI
{
    public class BsCheckBox : CheckBox
    {
        public string AuthRole { get; set; }
        protected override void OnPreRender(EventArgs e)
        {
            if (!Util.CheckUserInRole(AuthRole)) this.Visible = false;
            base.OnPreRender(e);
        }
    }
}
