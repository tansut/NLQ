using Helpers;
using JDash.InMemoryAnalytics.Modeling;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JDash.WebForms.Demo
{
    public partial class GenerateSQL : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }



        protected void ctlModelData_Click(object sender, EventArgs e)
        {
            var ds = new DataSet();
            var table = ds.Tables.Add("MyData");
            DBManager.GetTable(table, ctlSQL.Text);
            var cubeModel = CubeModel.GenerateFromDataTable(table);
            cubeModel.DataSourceID = ctlSQL.Text;
            HttpContext.Current.Items["cube"] = cubeModel;
            Server.Transfer("EditCube.aspx");
        }

        protected void ctlExecute_Click(object sender, EventArgs e)
        {
            var ds = new DataSet();
            var table = ds.Tables.Add("MyData");
            DBManager.GetTable(table, ctlSQL.Text);
            grid.DataSource = table;
            grid.DataBind();
        }
    }
}