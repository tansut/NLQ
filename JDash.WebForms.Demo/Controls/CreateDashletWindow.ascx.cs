using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using JDash;
using JDash.Models;
using JDash.WebForms;
using JDash.InMemoryAnalytics.Engine;
using JDash.WebForms.Demo.JDash.Dashlets.DataAnalysis;
using JDash.InMemoryAnalytics.Modeling;



namespace JDash.WebForms.Demo.Controls.UI.Commons
{
    public partial class CreateDashletWindow : System.Web.UI.UserControl
    {
        IEnumerable<DashletModuleModel> modules;
        IEnumerable<DashletModuleModel> Modules
        {
            get
            {
                if (modules == null) modules = JDashManager.Provider.SearchDashletModules().data;
                return modules;
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                var groups = Modules.Where(w => !string.IsNullOrWhiteSpace(w.metaData.group)).Select(s => s.metaData.group).Distinct().ToList();
                ctlDashletGroupRepeater.DataSource = groups;
                ctlDashletGroupRepeater.DataBind();
                ctlDashletGroupInnerRepeater.DataSource = groups;
                ctlDashletGroupInnerRepeater.DataBind();
                ctlModalUpdatePanel.Update();
            }
        }

        public IEnumerable<DashletModuleModel> GetGroupDashlets(string groupName)
        {

            var result = Modules.Where(w => w.metaData.group == groupName).ToList();
            return result;
        }

        protected void ctlDashletItemRepeater_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {            
            var dash = ((IJDashPage)Page).JDash;
            var moduleId = e.CommandArgument.ToString();
            var module = Modules.Single(s => s.id == moduleId);
            dash.CreateDashlet(new DashletModel(module), DashletCreateMode.first);
        }
    }
}