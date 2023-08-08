using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JDash.WebForms.Official.Official
{
    public partial class contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            officeTime.Text = DateTime.UtcNow.AddHours(3).ToString("dddd, MMMM d, yyyy a\\t h:mmtt");
        }
    }
}