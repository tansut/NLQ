using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using JDash;
using JDash.Models;
using JDash.Query;
using JDash.WebForms;
using Microsoft.AspNet.FriendlyUrls;
using JDash.InMemoryAnalytics.Modeling;
using JDash.InMemoryAnalytics.Engine;
using JDash.WebForms.Demo.JDash.Dashlets.DataAnalysis;

namespace JDash.WebForms.Demo
{

    public interface IJDashPage
    {
        DashboardView JDash { get; }
    }



    public partial class Main : System.Web.UI.MasterPage
    {

        public List<DashboardModel> Dashboards { get; set; }

        public ThemeInfo GetCustomTheme()
        {
            var theme = new ThemeInfo("My Custom Theme", Page.ResolveUrl("~/Resource/Themes/Custom/main.css"));
            theme.Styles.Add("a", new ThemeStyleInfo("Black", "black"));
            theme.Styles.Add("f", new ThemeStyleInfo("Yellow", "yellow"));
            theme.DefaultStyle = "a";
            return theme;
        }

        private void ensureConnectionString()
        {
            if (JDashManager.Provider.ConnectionString.IndexOf("[YOUR DATABASE]") > 0)
                Response.Redirect("~/readme.txt", true);


        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ensureConnectionString();
            ResourceManager.GetInstance().PrepareClientConfig += Main_PrepareClientConfig;
            DashPage.JDash.DashboardLoaded += JDash_DashboardLoaded;

            if (!Page.IsPostBack)
            {
                BindDashboards();
                BindThemes();
                DashPage.JDash.UserDesignMode = string.IsNullOrEmpty(Request.QueryString["design"]) ?
                DashboardDesignMode.full : DashboardDesignMode.full;
                var idToShow = string.Empty;
                if (Request.QueryString["id"] != null)
                {
                    idToShow = Request.QueryString["id"];
                    if (!string.IsNullOrEmpty(idToShow))
                        ShowDashboard(idToShow);
                }
                else
                {
                    idToShow = ConfigurationManager.AppSettings["homeDashboardId"];
                    if (!string.IsNullOrEmpty(idToShow))
                    {
                        try
                        {
                            ShowDashboard(idToShow);
                        }
                        catch (ArgumentException)
                        {
                            // Do nothing.                            
                        }
                    }
                }

            }
        }

        private void BindThemes()
        {
            var themes = ResourceManager.GetInstance().Themes;
            var customTheme = GetCustomTheme();
            themes.Add(customTheme);
            ResourceManager.GetInstance().RegisterTheme(customTheme);
            ctlThemesRepeater.DataSource = themes;
            ctlThemesRepeater.DataBind();
        }

        void Main_PrepareClientConfig(object sender, ClientConfigEventArgs e)
        {
            // e.Config.Add("baseUrl", "'/ASDASDASD'");
        }

        void JDash_DashboardLoaded(object sender, EventArgs e)
        {
            var list = DashPage.JDash.DashletContextList;
            if (list.Count == 0)
                DashPage.JDash.UserDesignMode = DashboardDesignMode.full;

            ShowDashboardProps();
        }

        public IJDashPage DashPage
        {
            get
            {
                return this.Page as IJDashPage;
            }
        }

        public void ShowDashboardProps()
        {
            ctlCurrentDashboardTitle.Text = DashPage.JDash.Dashboard.title;
            deleteDashboardBtn.Visible = DashPage.JDash.UserDesignMode == DashboardDesignMode.full;
            ctlEditDashboard.Visible = DashPage.JDash.UserDesignMode == DashboardDesignMode.full;
            createDashetBtn.Visible = DashPage.JDash.UserDesignMode == DashboardDesignMode.full;
            ctlDesignModeSw.Visible = true;
            dashboardInfoUp.Update();
            ResourceManager.GetInstance().AddUpdatePanelToRefresh(dashboardInfoUp);
        }

        public void ShowDashboard(string id)
        {


            if (HttpContext.Current.Items.Contains("dashboardId"))
            {


            }
            else
            {
                DashPage.JDash.DashboardId = id;
                DashPage.JDash.DataBind();
            }
        }


        private IEnumerable<DashboardModel> GetMyDashboards()
        {
            if (Thread.CurrentPrincipal.Identity.IsAuthenticated)
            {
                DynamicQuery filter = new DynamicQuery();
                filter.filter = new FilterParam();
                var flts = new List<Filter>();
                flts.Add(new Filter() { field = "metaData.createdBy", value = Thread.CurrentPrincipal.Identity.Name, op = CompareOperator.eq });
                filter.filter.filters = flts;
                return JDashManager.Provider.SearchDashboards(filter).data;
            }
            else
                return new List<DashboardModel>(); ;

        }

        public void BindDashboards()
        {

            Dashboards = new List<DashboardModel>(JDashManager.Provider.SearchDashboards().data);
            var groups = Dashboards.Select(p => new { group = p.metaData.group }).Distinct();
            groupsRepeater.DataSource = groups;
            groupsRepeater.DataBind();
            dashboardsUp.Update();

        }


        protected IEnumerable<DashboardModel> getDashboardsOfGroup(string group)
        {
            var list = Dashboards.Where(p => p.metaData.group == group).Select(p => p).OrderBy(p => p.groupOrder).OrderBy(p => p.metaData.group).AsEnumerable();
            return list;
        }


        protected void dashboardsRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            var did = e.CommandArgument.ToString();
            ShowDashboard(did);
        }


        protected void ctlEditDashboard_Click(object sender, EventArgs e)
        {
            CreateDashboardWindow.Show(DashPage.JDash.Dashboard);
        }

        protected void ctlCreateDashboardWindow_Click(object sender, EventArgs e)
        {
            CreateDashboardWindow.Show();
        }

        protected void deleteDashboardBtn_Click(object sender, EventArgs e)
        {
            var id = DashPage.JDash.DashboardId;
            JDashManager.Provider.DeleteDashboard(id);
            Response.Redirect("~/Dashboard");
        }

        protected void readonlyView_CheckedChanged(object sender, EventArgs e)
        {
            var isDesign = ctlDesignModeSw.Checked;
            DashPage.JDash.UserDesignMode = isDesign ? DashboardDesignMode.full : DashboardDesignMode.none;
            ShowDashboardProps();
        }

        protected void ctlThemesRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            var theme = e.CommandArgument.ToString();
            ResourceManager.GetInstance().ChangeTheme(theme, null, true);
        }
    }
}