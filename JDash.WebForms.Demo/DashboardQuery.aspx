<%@ Page Language="C#" AutoEventWireup="true" Inherits="QueryMainForm" EnableSessionState="True" Trace="False" EnableEventValidation = "False" Codebehind="DashboardQuery.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
  
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" dir="ltr">
	<head runat="server"> 
		<meta name="vs_snapToGrid" content="True" />
		<title>MB8 Dashboard.</title>
		<meta content="C#" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
        <link href="Resource/css/StyleSheet.css" rel="stylesheet" type="text/css" />
        <link href="Resource/css/EQStyles.css" rel="stylesheet" type="text/css" />
         <link href="Resource/css/DashboardQuery.css" rel="stylesheet" type="text/css" />
         <link href="Resource/css/cerulean.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
          a:link { color:#006699 }
          a:active { color:#FF0000 }
          a:visited { color:#006699 }
          img {
              border-width:0px;
          }              
          td.leftCol{
            background-color:#FFFFFF;
            border-color:#4B9EDC;
            border-style:solid;
            border-width:4px 1px 4px 4px;
            vertical-align:top;
            padding: 4px;
          }

          td.rightCol{
            background-color:#FFFFFF;
            border-color:#4B9EDC;
            border-style:solid;
            border-width:4px 4px 4px 1px;
          }
          
        </style>
        <script type="text/javascript">
        function lang(){
            var theForm = getElementById('lang');
            if (theForm.value == "eng"){
                
            }
        }
        </script>
    </head>
<body>
<form id="Form1" method="post" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server" />
    <div class='wrap'>
     <div class="container-fluid">
     <div class="navbar navbar-inverse navbar-default radT" style='margin-bottom: -2px'>
                <!-- static navbar -->
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">
                        <img alt="MarketBuilder Logo" src='Resource/img/Icons/mpIcon.PNG' class='headerLogo nBreak img-responsive' />
                            MarketBuilder Dashboard
                    </a>
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="glyphicon glyphicon-user delGreen"></span>&nbsp;&nbsp;Welcome, User<b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Logout</a></li>
                            </ul>
                        </li>
                    </ul>
                    <!-- /navbar-right -->
                </div>
                <!-- /nav-collapse -->
            </div>
          <div class="col-md-12 spacer"></div>
    <div class="col-md-12">
    <div class="col-md-12 ">   
          <span class="IndexTitle text-left">Dashboard Queries</span>        
            <%--<asp:Button ID="btnSave" runat="server" OnClick="SaveBtn_Click" Text="Save.." CssClass="saveButton"  meta:resourcekey="btnSave" />--%>
            <!--<asp:Literal ID="txtQueryFile" runat="server" Text="<%$ Resources:txtQueryFile%>" />--> 
            <!--<asp:FileUpload ID="SavedQueryUpload" runat="server" CssClass="inputFileButton" />-->
            <!--<asp:Button ID="btnLoad" runat="server" OnClick="LoadBtn_Click" Text="Load" CssClass="loadButton"  meta:resourcekey="btnLoad"/>-->                                                   
         <span class="fRight">   
         <asp:Button ID="btnExecute" runat="server" OnClick="btnExecute_Click" Text="Execute" CssClass="executeButton text-right clear" />
         <asp:Button ID="btnClear" runat="server" OnClick="ClearBtn_Click" Text="Clear"  CssClass="clearButton text-right clear" meta:resourcekey="btnClear" />
         </span>
    </div>                

        
<asp:Label ID="ErrorLabel" runat="server" Text="______" CssClass="error-label" Visible="False"></asp:Label>
<div id="content">
    <div class="col-md-12">
    <div class="eqdax-entitiesPanel col-md-4">        
	   <asp:UpdatePanel ID="UpdatePanelEntities" runat="server">
                    <ContentTemplate>
                        <div class="eqdax-entitiesBorder"></div>
                        <div class="eqdax-entitiesTitle">
                            <asp:Literal ID="Literal2" runat="server" Text="<%$ Resources:txtEntAttr%>" />
                        </div>
                        <keqwc:EntitiesPanel ID="EntitiesPanel1" runat="server" BorderStyle="None" ToolTip="Entities and attributes" 
                            cssClass="eqdax-entities-table" UseAppearanceStyle="False"  ToolBarOnTop="False" UseDefaultStyle="False"></keqwc:EntitiesPanel>							
                    </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    
    <div class="eqdax-rightBlocks col-md-8">
        <div class="eqdax-columnsBlock">
        <asp:UpdatePanel ID="UpdatePanelColumns" runat="server">
            <ContentTemplate>
                <div class="eqdax-resultColumn col-md-6">
                <div class="eqdax-topBorder-block"></div>
                    <span class="eqdax-resultColumn-title"><asp:Literal ID="txtResultColumns" runat="server" Text="<%$ Resources:txtResultColumns%>" />
                    </span> 
                    <asp:Panel ID="QCAddRowPanel" CssClass="eqdax-resultColumn-addRow" runat="server"></asp:Panel>                   
                    <keqwc:QueryColumnsPanel ID="QueryColumnsPanel1" runat="server" BorderStyle="none" ShowHeaders="True" 
                        ToolTip="Result Columns" UseDefaultStyle="False" 
                        UseAppearanceStyle="False" 
                        Appearance-AttrElementFormat="{entity} {attr}" 
                        Appearance-RowButtonTooltip="Click here to see all available operations"></keqwc:QueryColumnsPanel>							
                </div>              
                <div class="eqdax-columnSorting-block col-md-5">
                    <div class="eqdax-topBorder-block"></div>
                    <span class="eqdax-columnSorting-title">
                    <asp:Literal ID="txtColumnSoring" runat="server" Text="<%$ Resources:txtColumnSorting%>" /></span>                     
                    <asp:Panel ID="QSAddRowPanel" CssClass="eqdax-columnSorting-addRow" runat="server"></asp:Panel>
                    <keqwc:SortColumnsPanel ID="SortColumnsPanel1" runat="server" ToolTip="Columns Sorting" BorderStyle="none" UseDefaultStyle="False" 
                        UseAppearanceStyle="False"></keqwc:SortColumnsPanel>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>

        <div class="eqdax-conditionsPanel col-md-11">
            <div class="eqdax-topBorder-block"></div>
                <span class="eqdax-queryConditions-title"><asp:Literal ID="txtQueryConditions" runat="server" Text="<%$ Resources:txtQueryConditions%>" /></span>
                <asp:UpdatePanel ID="UpdatePanelConditions" runat="server">
                    <ContentTemplate>
                        <asp:Panel ID="QPAddRowPanel" CssClass="eqdax-queryCondition-addRow" runat="server"></asp:Panel>
                        <keqwc:QueryPanel ID="QueryPanel1" runat="server"
                            BorderStyle="none" ScrollBars="Auto" OnSqlExecute="QueryPanel1_SqlExecute" 
                            OnListRequest="QueryPanel1_ListRequest" 
                            OnCreateValueElement="QueryPanel1_CreateValueElement" 
                            Appearance-ScriptMenuStyle-ItemMinWidth="160" 
                            UseListCache="True" 
                            UseDefaultStyle="False" UseAppearanceStyle="False"></keqwc:QueryPanel>
                    </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    </div>
 <div class="col-md-12">
<div id="contentBot" class="eqdax-resultBlock col-md-4">
	<div id="eqdax-sqlPanel col-md-12">
    	<div class="eqdax-topBorderSQL col-md-12 "></div>
		<div class="eqdax-sqlTitle ">SQL</div>
        <div class="eqdax-sqlPanel-block col-md-12">
			<asp:UpdatePanel ID="UpdatePanel3" runat="server">
				<ContentTemplate>
                	<asp:TextBox ID="SqlTextBox" runat="server" CssClass="eqdax-sqlPanel-textBox col-md-12" TextMode="MultiLine"></asp:TextBox>
				</ContentTemplate>
			</asp:UpdatePanel>
        </div>
	</div>
    </div>
    <div class="col-md-8 eqdax-resultBlock">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server" >
        <ContentTemplate>
            <div class="eqdax-topBorderUpdatePanel"></div>
                <div class="eqdax-updatePanel-bottomBorder">
           <span class="eqdax-resultPanel-title"><asp:Literal ID="txtResult" runat="server" Text="<%$ Resources:txtResult%>" />  </span>
 		 <span class="eqdax-resultPanel-actions">
            <asp:Button ID="btnUpdateResult" runat="server" OnClick="UpdateResultBtn_Click" Text="Update Result" CssClass="eqdax-resultPanel-updateButton"  meta:resourcekey="btnUpdateResult" /> </span>
           <span class="eqdax-resultPanel-export">
              <asp:Button ID="btnExportExcel" runat="server" OnClick="ExportExcelBtn_Click" Text="Export to Excel" CssClass="eqdax-resultPanel-exportButton"  meta:resourcekey="btnExportExcel" />
              <asp:Button ID="btnExportCsv" runat="server" OnClick="ExportCsvBtn_Click"  Text="Export to Csv" CssClass="eqdax-resultPanel-exportButton" meta:resourcekey="btnExportCsv" />
                            </span>
                </div>
                <asp:Label ID="ResultLabel" runat="server" Text="Label" Visible="False"></asp:Label>
                <asp:Panel ID="PanelResult" runat="server" >
                    <asp:GridView ID="ResultGrid" runat="server" DataSourceID="ResultDS" CellPadding="4"  CellSpacing="2" GridLines="Vertical" AllowPaging="True"></asp:GridView>
                </asp:Panel>
        </ContentTemplate>
        <Triggers>
           <asp:PostBackTrigger ControlID="btnExportExcel" />
           <asp:PostBackTrigger ControlID="btnExportCsv" />
           <asp:AsyncPostBackTrigger ControlID="SqlTextBox" EventName="TextChanged" />
         </Triggers>
    </asp:UpdatePanel>
    </div>
</div>

</div>
    <span class="copyright">
        <asp:SqlDataSource ID="ResultDS" runat="server" ConnectionString="Data Source=.\SQLExpress;Initial Catalog=MB8SQLTestDB;Integrated Security=True" SelectCommand="SELECT * FROM [ACTIVITY]" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
        
    </span>
</div>

<div style="display: none;">
<asp:UpdatePanel ID="UpdatePanelQueryText" runat="server">
    <ContentTemplate>
        <asp:Literal ID="literalQueryText" runat="server"></asp:Literal><br />&nbsp;
    </ContentTemplate>
</asp:UpdatePanel>
                    
    <asp:UpdateProgress ID="UpdateProgressColumns" runat="server" AssociatedUpdatePanelID="UpdatePanelColumns">
        <ProgressTemplate>
            <span style="font-weight:bold;font-size:14px">Processing... </span>
            <img src="/Resource/img/EasyQuery/progressBar2.gif" alt="Progress Bar"/>
        </ProgressTemplate>
    </asp:UpdateProgress>
    
    <asp:UpdateProgress ID="UpdateProgressConditions" runat="server" AssociatedUpdatePanelID="UpdatePanelConditions">
        <ProgressTemplate>
            <span style="font-weight:bold;font-size:14px">Processing... </span>
            <img src="/Resource/img/EasyQuery/progressBar2.gif" alt="Progress Bar" /> 
        </ProgressTemplate>
    </asp:UpdateProgress>
</div>
         </div>
        </div>
    <div class="col-md-12 footer padT">
        <div class="col-md-6 nPadL nPadR">Copyright &copy; 2014 Deloitte Development LLC. All rights reserved..</div>
            <div class="col-md-6 nPadL nPadR text-right">
                 <a href="#">About</a> |<a href="#">Contact</a>|<a href="#">Help</a> 
            </div>
    </div>
        </form>
        			 
	</body>
</html>
