using System;
using System.IO;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Text;
using System.Xml;
using System.Drawing;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Korzh.EasyQuery;
using Korzh.EasyQuery.Db;
using Korzh.EasyQuery.WebControls;
using Korzh.Utils.Db;
using Helpers;
using JDash.InMemoryAnalytics.Modeling;

public partial class QueryMainForm : System.Web.UI.Page
{
    
    private System.Data.SqlClient.SqlConnection SqlDbConnection = null;
    //private Korzh.EasyQuery.WebControls.QueryPanel qpanel;

    private string baseDataPath = null;
    private static string appPrefix = "EQN-DEMO-AJAX-";
    private static string querySessionName = appPrefix + "QUERY";
    private static string langSessionName = appPrefix + "LANG";

    private DbQuery query = null;
    private LabelListXElement qpAddRow = null;
    private LabelListXElement qcAddRow = null;
    private LabelListXElement qsAddRow = null;
//    private string qpAddRowText = "<%$ Resources:txtQPAddRow%>";
//    private string qcAddRowText = "<%$ Resources:txtQCAddRow%>";
//    private string qsAddRowText = "<%$ Resources:txtQSAddRow%>";
    
    protected void Page_Init(object sender, EventArgs e) {
        baseDataPath = this.MapPath("~/App_Data");
        InitSessionObjects();
        BtnExportHideAndShow(false);
    }

    private void InitSessionObjects() {
        query = (DbQuery)Session[querySessionName];

        if (query == null) 
            InitQuery();

        //string path = AppDomain.CurrentDomain.BaseDirectory;
        //path += "data\\nwind1.xml";
    }

    protected override void InitializeCulture() {
        base.InitializeCulture();
        string lang = (string)Session[langSessionName];
        if (lang == null) 
            lang = InitLanguage();

        System.Globalization.CultureInfo ci = new System.Globalization.CultureInfo(lang);
        System.Threading.Thread.CurrentThread.CurrentCulture = ci;
        System.Threading.Thread.CurrentThread.CurrentUICulture = ci;
    }


    private void InitQuery() {
        DbModel model = new DbModel();
        model.UseResourcesForOperators = true;


        string path = System.IO.Path.Combine(baseDataPath, "MB8_Sample.xml");
//        string path = System.IO.Path.Combine(baseDataPath, "PersonSQLModel.xml");
        model.LoadFromFile(path);

        //System.Data.Common.DbConnection DbConn = new System.Data.SqlClient.SqlConnection();        
        //DbConn.ConnectionString = ConfigurationManager.ConnectionStrings["MB8SQLTestDBConnectionString"].ToString();
        //DbConn.Open();        
        //model.LoadFromConnection(DbConn, 0);

        query = new DbQuery();
        //query.Formats.EOL = Korzh.EasyQuery.EOLSymbol.None; 
        query.Model = model;
        //query.Formats.AlphaAlias = true;
        query.Formats.SetDefaultFormats(FormatType.MsSqlServer);
        Session[querySessionName] = query;
    }

    private string InitLanguage() {
        System.Globalization.CultureInfo ci = System.Threading.Thread.CurrentThread.CurrentUICulture;
        string lang = ci.ToString();
        if (lang.Length < 3) { //create the specific culture if the neutral one was passed in request
            lang = System.Globalization.CultureInfo.CreateSpecificCulture(lang).ToString();
        }

        Session[langSessionName] = lang;
        return lang;
    }

    protected void Page_Load(object sender, EventArgs e) {
        query.Model.Texts.ReloadNativeResources();
        Korzh.EasyQuery.WebControls.TextResources.ReloadNativeResources();

        query.Model.Texts.LoadFromFileForCulture(System.IO.Path.Combine(baseDataPath, "EQCoreMessages"));
        query.Model.RefreshResources();
        Korzh.EasyQuery.WebControls.TextResources.LoadFromFileForCulture(System.IO.Path.Combine(baseDataPath, "EQWebMessages"));

        if (!Page.IsPostBack) {
            string queryName = Page.Request.QueryString.Get("query");
            if (queryName != null) {
                query.LoadFromFile(baseDataPath + "\\" + queryName + ".xml");
            }
        }

        QueryPanel1.Query = query;
        
        QueryColumnsPanel1.Query = QueryPanel1.Query;
        EntitiesPanel1.Query = QueryPanel1.Query;

        SortColumnsPanel1.Query = QueryPanel1.Query;

        query.ColumnsChanged += new Korzh.EasyQuery.ColumnsChangedEventHandler(query_ColumnsChanged);
        query.ConditionsChanged += new Korzh.EasyQuery.ConditionsChangedEventHandler(query_ConditionsChanged);
        query.SortOrderChanged += new Korzh.EasyQuery.SortOrderChangedEventHandler(query_SortOrderChanged);

        System.Reflection.AssemblyFileVersionAttribute versionAttr =
            (System.Reflection.AssemblyFileVersionAttribute)System.Attribute.GetCustomAttribute(QueryPanel1.GetType().Assembly, typeof(System.Reflection.AssemblyFileVersionAttribute));

       
        qpAddRow = new LabelListXElement();
        qpAddRow.ID = "QPAddRowLink";
        qpAddRow.EmptyValueText = GetLocalResourceObject("txtQPAddRow").ToString();
        QueryPanel1.FillElementByEntityTree(qpAddRow);
        qpAddRow.ContentChanged += new ContentChangedEventHandler(QPAddRowContentChanged);
        qpAddRow.TextAdjusting += new TextAdjustingEventHandler(QPAddRowTextAdjusting);
        QPAddRowPanel.Controls.Add(qpAddRow);

        qcAddRow = new LabelListXElement();
        qcAddRow.ID = "QCAddRowLink";
        qcAddRow.EmptyValueText = GetLocalResourceObject("txtQCAddRow").ToString();
        QueryColumnsPanel1.FillEntityElement(qcAddRow);
        qcAddRow.ContentChanged += new ContentChangedEventHandler(QCAddRowContentChanged);
        qcAddRow.TextAdjusting += new TextAdjustingEventHandler(QCAddRowTextAdjusting);
        QCAddRowPanel.Controls.Add(qcAddRow);

        qsAddRow = new LabelListXElement();
        qsAddRow.ID = "QSAddRowLink";
        qsAddRow.EmptyValueText = GetLocalResourceObject("txtQSAddRow").ToString();
        SortColumnsPanel1.FillEntityElement(qsAddRow);
        qsAddRow.ContentChanged += new ContentChangedEventHandler(QSAddRowContentChanged);
        qsAddRow.TextAdjusting += new TextAdjustingEventHandler(QSAddRowTextAdjusting);
        QSAddRowPanel.Controls.Add(qsAddRow);


        QueryPanel1.ToolTip = GetLocalResourceObject("txtQPTooltip").ToString();
        QueryColumnsPanel1.ToolTip = GetLocalResourceObject("txtQCTooltip").ToString();
        SortColumnsPanel1.ToolTip = GetLocalResourceObject("txtQSTooltip").ToString();

        UpdateSql();
    }


    protected virtual void QPAddRowContentChanged(object sender, ContentChangedEventArgs e) {
        if (!e.ValueChanged) return;
        XElement elem = (XElement)sender;
        QueryPanel1.AddFirstLevelSimpleCondition(elem.Value);
    }

    protected virtual void QPAddRowTextAdjusting(object sender, TextAdjustingEventArgs e) {
        e.Text = GetLocalResourceObject("txtQPAddRow").ToString();
    }

    protected virtual void QCAddRowContentChanged(object sender, ContentChangedEventArgs e) {
        if (!e.ValueChanged) return;
        XElement elem = (XElement)sender;
        QueryColumnsPanel1.AddSimpleColumn(elem.Value);
    }

    protected virtual void QCAddRowTextAdjusting(object sender, TextAdjustingEventArgs e) {
        e.Text = GetLocalResourceObject("txtQCAddRow").ToString();
    }

    protected virtual void QSAddRowContentChanged(object sender, ContentChangedEventArgs e) {
        if (!e.ValueChanged) return;
        XElement elem = (XElement)sender;
        SortColumnsPanel1.AddSimpleColumn(elem.Value);
    }

    protected virtual void QSAddRowTextAdjusting(object sender, TextAdjustingEventArgs e) {
        e.Text = GetLocalResourceObject("txtQSAddRow").ToString();
    }

    private void EnableLinkButton(LinkButton btn) {
        string lang = System.Threading.Thread.CurrentThread.CurrentCulture.ToString();
        if (btn.CommandArgument == lang) {
            btn.ForeColor = Color.Black;
            btn.Font.Bold = true;
            btn.Font.Underline = false;
            btn.OnClientClick = "return false";
        }
        else {
            btn.ForeColor = Color.Empty;
            btn.Font.Bold = false;
            btn.Font.Underline = true;
            btn.OnClientClick = "";
        }
    }

    protected void Page_Unload(object sender, EventArgs e) {
        query = (DbQuery)Session[querySessionName];
		if (query != null) {
	        query.ColumnsChanged -= new Korzh.EasyQuery.ColumnsChangedEventHandler(query_ColumnsChanged);
		    query.ConditionsChanged -= new Korzh.EasyQuery.ConditionsChangedEventHandler(query_ConditionsChanged);
			query.SortOrderChanged -= new Korzh.EasyQuery.SortOrderChangedEventHandler(query_SortOrderChanged);
		}
    }

    protected void LoadBtn_Click(object sender, EventArgs e)
    {
        if (SavedQueryUpload.HasFile) {
            try {
                // Initialize the reader.
                System.IO.TextReader reader = new StreamReader(SavedQueryUpload.PostedFile.InputStream);
                
                // Copy the byte array into a string.
                string QueryText = reader.ReadToEnd();

                reader.Close();
                
                QueryPanel1.Query.LoadFromString(QueryText);
            }
            catch (Exception ex) {
                ErrorLabel.Text = "Error during loading: " + ex.Message;
                ErrorLabel.Visible = true;
            }
        }
    }
    protected void SaveBtn_Click(object sender, EventArgs e){
        Response.ClearHeaders();
        Response.ContentType = "text/xml";
        Response.Clear();

        Response.BufferOutput = true;
        Response.AddHeader("Content-Disposition", "attachment;filename=query.xml"); 

        string QueryText = QueryPanel1.Query.SaveToString();
        byte[] output = System.Text.UnicodeEncoding.UTF8.GetBytes(QueryText);

        Response.OutputStream.Write(output, 0, output.GetLength(0));

        Response.End();
    }

    protected void ClearBtn_Click(object sender, EventArgs e){
        QueryPanel1.Query.Clear();
        ResultGrid.Columns.Clear();
        EntitiesPanel1.SelectNone();
        EntitiesPanel1.RefreshEntityTree();
        SqlTextBox.Text = string.Empty;
        ResultLabel.Text = string.Empty;
        BtnExportHideAndShow(false);
    }

    protected void CheckConnection() {
        if (SqlDbConnection == null)
        {
            SqlDbConnection = new SqlConnection();
            //DbConnection.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" +
            //   System.IO.Path.Combine(baseDataPath, "Nwind.mdb") + ";Persist Security Info=False";

            SqlDbConnection.ConnectionString = @"Data Source=.\SQLExpress;Initial Catalog=MB8SQLTestDB;Integrated Security=True";
            SqlDbConnection.Open();
        }
    }

    private void GetListBySql(string sql, ValueItemList resultItems) {
        CheckConnection();
        //OleDbDataAdapter resultDA = new OleDbDataAdapter(sql, DbConnection);
        SqlDataAdapter resultDA = new SqlDataAdapter(sql, SqlDbConnection);
        DataSet tempDS = new DataSet();
        resultDA.Fill(tempDS, "Result");

        StringWriter strWriter = new StringWriter();
        tempDS.WriteXml(strWriter);
        resultItems.LoadFromXml(strWriter.ToString());

    }
    protected void QueryPanel1_SqlExecute(object sender, Korzh.EasyQuery.WebControls.SqlExecuteEventArgs e) {
        GetListBySql(e.SQL, e.ListItems);
    }

    protected void QueryPanel1_ListRequest(object sender, Korzh.EasyQuery.WebControls.ListRequestEventArgs e) {
        EntityAttr countryAttr = query.Model.EntityRoot.FindAttribute(EntityAttrProp.Expression, "Customers.Country");
        string country = query.GetOneValueForAttr(countryAttr);

        if (e.ListName == "RegionList") {
            e.ListItems.Clear();

            if (country == "Canada") {
                e.ListItems.Add("British Columbia", "BC");
                e.ListItems.Add("Quebec", "Quebec");
            }
            else if (country == "USA") {
                e.ListItems.Add("California", "CA");
                e.ListItems.Add("Colorado", "CO");
                e.ListItems.Add("Oregon", "OR");
                e.ListItems.Add("Washington", "WA");
            }
        }
        else if (e.ListName == "CityList") {
            string sql = "SELECT DISTINCT city, city FROM Customers";


            if (!string.IsNullOrEmpty(country)) {
                sql += " WHERE country = '" + country.Replace("'", "''") + "'";
            }
            GetListBySql(sql, e.ListItems);
        }
    }

    protected void query_ColumnsChanged(object sender, Korzh.EasyQuery.ColumnsChangeEventArgs e) {
        UpdateSql();
    }

    protected void query_ConditionsChanged(object sender, Korzh.EasyQuery.ConditionsChangeEventArgs e) {
        UpdateSql();
    }

    protected void query_SortOrderChanged(object sender, Korzh.EasyQuery.SortOrderChangedEventArgs e) {
        UpdateSql();
    }
    

    protected void UpdateSql() {
        try {
            
                SqlQueryBuilder builder = new SqlQueryBuilder(query);
                //builder.BuildSQL();
                if (builder.CanBuild)
                {
                    builder.BuildSQL();
                    SqlTextBox.Text = builder.Result.SQL;
                } 

                //SqlTextBox.Text = builder.Result.SQL;
                QueryTextFormats formats = new QueryTextFormats();
                formats.UseHtml = true;
                formats.UseMathSymbolsForOperators = true;
                literalQueryText.Text = query.GetConditionsText(formats);

                ResultGrid.Visible = false;            

        }
        catch {
            SqlTextBox.Text = "";
            literalQueryText.Text = "";
        }
    }

    protected void UpdateResultBtn_Click(object sender, EventArgs e) {
        if (SqlTextBox.Text.StartsWith("SELECT", StringComparison.InvariantCultureIgnoreCase)) { //we do not allow to execute statements other that SELECT
            try {
                ResultDS.SelectCommand = SqlTextBox.Text;
                ResultDS.Select(DataSourceSelectArguments.Empty);
                ResultLabel.Visible = false;
                ResultGrid.Visible = true;
                BtnExportHideAndShow(true);
            }
            catch (Exception ex) {
                ResultGrid.Visible = false;
                ResultLabel.Width = new Unit("100%");
                ResultLabel.Text = "Error in SQL statement: " + ex.Message;
                ResultLabel.Visible = true;

            }
        }
    }

    protected void QueryPanel1_CreateValueElement(object sender, Korzh.EasyQuery.WebControls.CreateValueElementEventArgs e) {
        // this method demonstrates an ability to change value elelements at run-time
        // for example in this case we change element from ListRowElement to EditRowElement if list of available values is too long

        if (e.ConditionRow.Condition is SimpleCondition) {
            Expression baseExpr = ((SimpleCondition)e.ConditionRow.Condition).BaseExpr;
            EntityAttr attr = ((EntityAttrExpr)baseExpr).Attribute;
            if (attr.DefaultEditor is SqlListValueEditor) {
                string sql = ((SqlListValueEditor)attr.DefaultEditor).SQL;
                if (ResultSetIsTooBig(sql)) { //or put your condition here
                    e.Element = new EditXElement();
                }
            }
        }
    }

    private bool ResultSetIsTooBig(string sql) {
        CheckConnection();
        //OleDbDataAdapter resultDA = new OleDbDataAdapter(sql, DbConnection);
        SqlDataAdapter resultDA = new SqlDataAdapter(sql, SqlDbConnection);
        DataSet tempDS = new DataSet();
        resultDA.Fill(tempDS, "Result");
        return tempDS.Tables[0].Rows.Count > 100;
    }

    protected void Button1_Click(object sender, EventArgs e) {
        string path = AppDomain.CurrentDomain.BaseDirectory;
        path += "data\\nwind2.xml";
        query.Model.LoadFromFile(path);
        QueryPanel1.UpdateModelInfo();

        QueryColumnsPanel1.UpdateModelInfo();
    }

    protected void ExportExcelBtn_Click(object sender, EventArgs e) {
       
        ExportResultToExcel("result.xls");
    }

    protected void ExportResultToCSV(string fileName) {
        ResultDS.SelectCommand = SqlTextBox.Text;
        DataView view = (DataView)ResultDS.Select(DataSourceSelectArguments.Empty);
        if (view == null) return;
        Response.Clear();
        Response.ContentType = "text/csv";
        Response.AddHeader("Content-Disposition",
            string.Format("attachment; filename=\"{0}\"", HttpUtility.UrlEncodeUnicode(fileName)));
        DbExport.ExportToCsv(view.Table, Response.Output, CsvFormats.Default);
        Response.End();
    }



    protected void ExportResultToExcel(string fileName) {
        ResultDS.SelectCommand = SqlTextBox.Text;
        DataView view = (DataView)ResultDS.Select(DataSourceSelectArguments.Empty);
        if (view == null) return;
        this.EnableViewState = false;
        Response.Clear();
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition",
        string.Format("attachment; filename=\"{0}\"", HttpUtility.UrlEncodeUnicode(fileName)));
        DbExport.ExportToExcelHtml(view.Table, Response.Output, ExcelFormats.Default);
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control) {
		//it is necessary for "Export to Excel" operation
        //we just ignore this event for GridView and do in usual way for all other controls
        if (!(control is GridView) && !(control is CheckBox))
            base.VerifyRenderingInServerForm(control);
    }

    protected void LangSwitch_Command(object sender, CommandEventArgs e) {
        Session[langSessionName] = e.CommandArgument;
        Response.Redirect(Request.Path, true);
    }

    protected void ExportCsvBtn_Click(object sender, EventArgs e){
         ExportResultToCSV("result.csv");
    }

    private void BtnExportHideAndShow(bool isActiv) {
        if (isActiv){
            btnExportExcel.Visible = true;
            btnExportCsv.Visible = true;
        }
        else{
            btnExportExcel.Visible = false;
            btnExportCsv.Visible = false;
        }
    }

    protected void btnExecute_Click(object sender, EventArgs e)
    {
        var ds = new DataSet();
        var table = ds.Tables.Add("MyData");
        DBManager.GetTable(table, SqlTextBox.Text);
        var cubeModel = CubeModel.GenerateFromDataTable(table);
        cubeModel.DataSourceID = SqlTextBox.Text;
        HttpContext.Current.Items["cube"] = cubeModel;
        Server.Transfer("EditCube.aspx");
        //Context.Items.Add("sqlQuery", SqlTextBox.Text);
        //Server.Transfer("Dashboard.aspx");
    }
}
