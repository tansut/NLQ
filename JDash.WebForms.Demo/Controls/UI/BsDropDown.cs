using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;
using JDash.WebForms.Demo.Helpers;


namespace JDash.WebForms.Demo.Controls.UI
{
    public class BsDropDown : DropDownList
    {

        public string EnumType { get; set; }
        public string AuthRole { get; set; }

        protected override void OnPreRender(EventArgs e)
        {
            if (!Util.CheckUserInRole(AuthRole)) this.Visible = false;
            base.OnPreRender(e);
        }
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!Page.IsPostBack)
            {
                if (!string.IsNullOrWhiteSpace(EnumType))
                {
                    var result = Util.GetDescriptionalEnumInfo(Type.GetType(EnumType));
                    this.DataValueField = "key";
                    this.DataTextField = "value";
                    this.DataSource = result;
                    this.DataBind();
                }
            }
        }
    
    }
}
