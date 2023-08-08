using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JDash;
using JDash.Helpers;
using JDash.Models;
using JDash.WebForms;
using JDash.WebForms.Utils;

namespace JDash.WebForms.Demo.Controls.UI.Commons
{
    public partial class CreateDashboardWindow : System.Web.UI.UserControl
    {
        public bool IsEdit
        {
            get
            {
                return (bool)ViewState["isEdit"];
            }
            set
            {
                ViewState["isEdit"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                preLayoutsRep.DataSource = LayoutModel.PredefinedLayouts;
                preLayoutsRep.DataBind();

                bindGroups();
            }
        }

        private void bindGroups()
        {
            var dashboards = JDashManager.Provider.SearchDashboards();
            if (dashboards != null)
            {
                var groupedDashboards = dashboards.data.Where(d => d.metaData.group != null && d.metaData.group.Trim() != string.Empty);
                if (groupedDashboards != null)
                {
                    ctlGroups.DataSource = groupedDashboards.Select(d => d.metaData.group).OrderBy(d=>d).Distinct().ToList();
                    ctlGroups.DataBind();
                }
            }
        }

        protected void ctlSaveButton_Click(object sender, EventArgs e)
        {

            var dash = ((IJDashPage)Page).JDash;
           
            if (!IsEdit)
            {
                var model = new DashboardModel();
                model.title = ctlDashboardTitle.Text.Trim();
                model.metaData = new MetadataModel();
                model.metaData.description = ctlDashboardDescription.Text.Trim();

                model.metaData.group = getGroup();
                
                if (!string.IsNullOrWhiteSpace(ctlLayoutId.Value))
                {
                    var layout = LayoutModel.GetPredefinedGridLayout(ctlLayoutId.Value);
                    model.layout = layout;
                }
                Response.Redirect("/Dashboard?id=" + JDashManager.Provider.CreateDashboard(model).id);
   
               
            }
            else
            {
                var model = dash.Dashboard;
                model.title = ctlDashboardTitle.Text.Trim();
                model.metaData.description = ctlDashboardDescription.Text.Trim();
                model.metaData.group = getGroup();
                if (!string.IsNullOrWhiteSpace(ctlLayoutId.Value))
                {
                    var layout = LayoutModel.GetPredefinedGridLayout(ctlLayoutId.Value);
                    dash.ChangeLayout(layout);
                    var prms = new Config();
                    prms.Add("layoutType", layout);
                    dash.Broadcast(new JEvent("layoutChanged", prms)); 
                }
                else dash.SaveDashboard();
            }
            var masterPage = ((Main)Page.Master);
            masterPage.BindDashboards();
            masterPage.ShowDashboardProps();
            ResourceManager.GetInstance().AddScript("$(document).ready(function () { hideCreateDashboardControl()});");
            bindGroups();
        }

        private string getGroup()
        {
            return ctlUseCustomGroup.Checked?ctlCustomGroup.Text: ctlGroups.SelectedValue;
        }

        protected void ctlCloseButton_Click(object sender, EventArgs e)
        {

        }
        public void Show(DashboardModel model = null)
        {
            this.Clear();
            if (model != null)
            {
                ctlDashboardTitle.Text = model.title;
                ctlDashboardDescription.Text = model.metaData.description;
                if (!string.IsNullOrEmpty(model.metaData.group))
                {
                    ctlGroups.SelectedValue = model.metaData.group;
                }
                IsEdit = true;
            }
            else
            {
                IsEdit = false;
            }
            ctlModalUpdatePanel.Update();
            ScriptManager.RegisterClientScriptBlock(Page, GetType(), "ShowCreateDashboadControl", "$(document).ready(function () { showCreateDashboardControl()});", true);
        }

        private void Clear()
        {
            ctlDashboardTitle.Text = string.Empty;
            ctlDashboardDescription.Text = string.Empty; 
            ctlUseCustomGroup.Checked = false;
        }

    }
}