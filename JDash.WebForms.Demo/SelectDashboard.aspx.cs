using JDash.InMemoryAnalytics.Engine;
using JDash.InMemoryAnalytics.Modeling;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JDash.WebForms.Demo
{
    public partial class SelectDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Session["cube"] = HttpContext.Current.Items["cube"] as CubeModel;
                Session["query"] = HttpContext.Current.Items["query"] as MdQuery;
                listRepeater.DataSource = JDashManager.Provider.SearchDashboards().data;
                listRepeater.DataBind();
            }
        }

        protected void listRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "go")
            {
                var cube = Session["cube"] as CubeModel;
                var query = Session["query"] as MdQuery;
                HttpContext.Current.Items.Add("cube", cube);
                HttpContext.Current.Items.Add("query", query);
                HttpContext.Current.Items.Add("dashboardId", e.CommandArgument.ToString());
                Server.Transfer("Dashboard.aspx");

            }
        }
    }
}