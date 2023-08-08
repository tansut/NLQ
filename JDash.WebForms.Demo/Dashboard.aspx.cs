using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JDash.Query;
using JDash.WebForms;
using JDash.WebForms.Demo.JDash.Dashlets.DataAnalysis;
namespace JDash.WebForms.Demo
{
    public partial class DashboardPage : System.Web.UI.Page, IJDashPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public DashboardView JDash
        {
            get { return this.dashboard; }
        }

       



    }
}