/****** Object:  Table [Dashboard]    Script Date: 23.12.2013 09:21:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Dashboard](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](250) NULL,
	[layout] [ntext] NOT NULL,
	[config] [ntext] NULL,
	[paneConfig] [ntext] NULL,
	[style] [ntext] NULL,
	[cls] [ntext] NULL,
	[attr] [ntext] NULL,
	[groupName] [nvarchar](150) NULL,
	[description] [nvarchar](max) NULL,
	[createdBy] [nvarchar](150) NOT NULL,
	[modifiedBy] [nvarchar](150) NULL,
	[sharedBy] [nvarchar](150) NULL,
	[created] [datetime] NOT NULL,
	[modified] [datetime] NULL,
	[shared] [datetime] NULL,
	[userData] [ntext] NULL,
	[viewOrder] [int] NULL,
	[groupOrder] [int] NULL,
	[UserProperty1] [nvarchar](250) NULL,
	[UserProperty2] [nvarchar](250) NULL,
	[UserProperty3] [nvarchar](250) NULL,
 CONSTRAINT [PK_Dashboard] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [Dashlet]    Script Date: 23.12.2013 09:21:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Dashlet](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dashboardId] [int] NOT NULL,
	[dashletModuleId] [int] NOT NULL,
	[title] [nvarchar](255) NULL,
	[config] [ntext] NULL,
	[paneConfig] [ntext] NULL,
	[position] [ntext] NOT NULL,
	[style] [ntext] NULL,
	[cls] [ntext] NULL,
	[attr] [ntext] NULL,
	[groupName] [nvarchar](150) NULL,
	[description] [nvarchar](max) NULL,
	[createdBy] [nvarchar](150) NOT NULL,
	[modifiedBy] [nvarchar](150) NULL,
	[sharedBy] [nvarchar](150) NULL,
	[created] [datetime] NOT NULL,
	[modified] [datetime] NULL,
	[shared] [datetime] NULL,
	[userData] [ntext] NULL,
	[UserProperty1] [nvarchar](250) NULL,
	[UserProperty2] [nvarchar](250) NULL,
	[UserProperty3] [nvarchar](250) NULL,
 CONSTRAINT [PK_Dashlets] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [DashletModule]    Script Date: 23.12.2013 09:21:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DashletModule](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[path] [nvarchar](max) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[config] [ntext] NOT NULL,
	[paneConfig] [ntext] NOT NULL,
	[dashletConfig] [ntext] NOT NULL,
	[style] [ntext] NULL,
	[cls] [ntext] NULL,
	[attr] [ntext] NULL,
	[description] [nvarchar](max) NULL,
	[createdBy] [nvarchar](150) NOT NULL,
	[modifiedBy] [nvarchar](150) NULL,
	[sharedBy] [nvarchar](150) NULL,
	[created] [datetime] NOT NULL,
	[modified] [datetime] NULL,
	[shared] [datetime] NULL,
	[groupName] [nvarchar](150) NULL,
	[userData] [ntext] NULL,
	[viewOrder] [int] NULL,
	[groupOrder] [int] NULL,
	[UserProperty1] [nvarchar](250) NULL,
	[UserProperty2] [nvarchar](250) NULL,
	[UserProperty3] [nvarchar](250) NULL,
 CONSTRAINT [PK_DashletModules] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [EntityAuth]    Script Date: 23.12.2013 09:21:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [EntityAuth](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[entityType] [nvarchar](50) NOT NULL,
	[entityId] [int] NOT NULL,
	[roleOrUser] [nvarchar](50) NOT NULL,
	[permission] [nvarchar](50) NOT NULL,
	[authType] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_EntityAuth] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Tag]    Script Date: 23.12.2013 09:21:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Tag](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tagName] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [TagRelation]    Script Date: 23.12.2013 09:21:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TagRelation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tagId] [int] NOT NULL,
	[controlId] [int] NOT NULL,
	[controller] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_TagRelation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [Dashboard] ON 

GO
INSERT [Dashboard] ([id], [title], [layout], [config], [paneConfig], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (467, N'Some Visualizations', N'{"type":"grid","sections":{"section1":{"zones":{"zone1":{}}},"section2":{"zones":{"zone1":{},"zone2":{}}},"section3":{"zones":{"zone1":{}}}},"addFirst":true}', N'null', N'null', NULL, NULL, NULL, N'Built-in Dashboards', N'', N'xxx', NULL, NULL, CAST(0x0000A19700C97F98 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashboard] ([id], [title], [layout], [config], [paneConfig], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (473, N'Your First Dashboard', N'{"type":"grid","sections":{"section1":{"zones":{"zone1":{"flex":2},"zone2":{}}},"section2":{"zones":{"zone1":{}}}},"addFirst":true}', N'null', N'null', NULL, NULL, NULL, N'Your Dashboards', N'', N'xxx', NULL, NULL, CAST(0x0000A198013CD4FC AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashboard] ([id], [title], [layout], [config], [paneConfig], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (475, N'Online Tutorial', N'{"type":"grid","sections":{"section1":{"zones":{"zone1":{}}}},"addFirst":true}', N'null', N'null', NULL, NULL, NULL, N'Built-in Dashboards', NULL, N'xxx', NULL, NULL, CAST(0x0000A1A000B02A70 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashboard] ([id], [title], [layout], [config], [paneConfig], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (483, N'Data Analysis Demo', N'{"type":"grid","sections":{"section1":{"zones":{"zone1":{}}},"section2":{"zones":{"zone1":{},"zone2":{"flex":2}}},"section3":{"zones":{"zone1":{}}}},"addFirst":true}', N'null', N'null', NULL, NULL, NULL, N'Built-in Dashboards', NULL, N'KALITTE\tansu', NULL, NULL, CAST(0x0000A1B700D413CC AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashboard] ([id], [title], [layout], [config], [paneConfig], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (484, N'Getting Started', N'{"type":"grid","sections":{"section1":{"zones":{"zone1":{"flex":2},"zone2":{}}},"section2":{"zones":{"zone1":{}}}},"addFirst":true}', N'null', N'null', NULL, NULL, NULL, N'Built-in Dashboards', N'', N'KALITTE\tansu', NULL, NULL, CAST(0x0000A29A0127DF75 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [Dashboard] OFF
GO
SET IDENTITY_INSERT [Dashlet] ON 

GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7291, 467, 223, N'Ms Chart Sample', N'{"settings":"<?xml version=\"1.0\" encoding=\"utf-16\"?><MsChartSettings xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://schemas.datacontract.org/2004/07/JDash.WebForms.Demo.Jdash.Dashlets.MsChart\"><_x003C_AlphaLevel_x003E_k__BackingField>128</_x003C_AlphaLevel_x003E_k__BackingField><_x003C_AreaBackColor_x003E_k__BackingField i:nil=\"true\" /><_x003C_AreaGradient_x003E_k__BackingField i:nil=\"true\" /><_x003C_AreaSecondaryBackColor_x003E_k__BackingField i:nil=\"true\" /><_x003C_BackColor_x003E_k__BackingField>White</_x003C_BackColor_x003E_k__BackingField><_x003C_BorderSkin_x003E_k__BackingField>None</_x003C_BorderSkin_x003E_k__BackingField><_x003C_ChartKey_x003E_k__BackingField i:nil=\"true\" /><_x003C_ChartType_x003E_k__BackingField>33</_x003C_ChartType_x003E_k__BackingField><_x003C_CollectPieOther_x003E_k__BackingField>false</_x003C_CollectPieOther_x003E_k__BackingField><_x003C_CollectedPieTreshold_x003E_k__BackingField>0</_x003C_CollectedPieTreshold_x003E_k__BackingField><_x003C_Description_x003E_k__BackingField></_x003C_Description_x003E_k__BackingField><_x003C_Enable3D_x003E_k__BackingField>true</_x003C_Enable3D_x003E_k__BackingField><_x003C_Gradient_x003E_k__BackingField>None</_x003C_Gradient_x003E_k__BackingField><_x003C_HasBorderColor_x003E_k__BackingField>true</_x003C_HasBorderColor_x003E_k__BackingField><_x003C_Height_x003E_k__BackingField>500</_x003C_Height_x003E_k__BackingField><_x003C_IsClustured_x003E_k__BackingField>true</_x003C_IsClustured_x003E_k__BackingField><_x003C_IsShownValues_x003E_k__BackingField>true</_x003C_IsShownValues_x003E_k__BackingField><_x003C_LegendAlignment_x003E_k__BackingField i:nil=\"true\" /><_x003C_LegendDocking_x003E_k__BackingField i:nil=\"true\" /><_x003C_LegendStyle_x003E_k__BackingField i:nil=\"true\" /><_x003C_LegendsEnabled_x003E_k__BackingField>false</_x003C_LegendsEnabled_x003E_k__BackingField><_x003C_MarkerSize_x003E_k__BackingField>0</_x003C_MarkerSize_x003E_k__BackingField><_x003C_MarkerStyle_x003E_k__BackingField>None</_x003C_MarkerStyle_x003E_k__BackingField><_x003C_Palette_x003E_k__BackingField>BrightPastel</_x003C_Palette_x003E_k__BackingField><_x003C_PieDrawingStyle_x003E_k__BackingField>Default</_x003C_PieDrawingStyle_x003E_k__BackingField><_x003C_PieLabelStyle_x003E_k__BackingField>Disabled</_x003C_PieLabelStyle_x003E_k__BackingField><_x003C_SecondaryBackColor_x003E_k__BackingField>White</_x003C_SecondaryBackColor_x003E_k__BackingField><_x003C_SeriesCount_x003E_k__BackingField>0</_x003C_SeriesCount_x003E_k__BackingField><_x003C_ShowLabels_x003E_k__BackingField>true</_x003C_ShowLabels_x003E_k__BackingField><_x003C_ShowMarkersLine_x003E_k__BackingField>false</_x003C_ShowMarkersLine_x003E_k__BackingField><_x003C_TitleAlignment_x003E_k__BackingField>TopCenter</_x003C_TitleAlignment_x003E_k__BackingField><_x003C_Title_x003E_k__BackingField></_x003C_Title_x003E_k__BackingField><_x003C_Width_x003E_k__BackingField>360</_x003C_Width_x003E_k__BackingField></MsChartSettings>"}', N'{"cssClass":"msChart homeRow2","builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[]}', N'{"section":"section2","zone":"zone2","pos":0}', NULL, NULL, NULL, NULL, NULL, N'xxx', NULL, NULL, CAST(0x0000A1970131C490 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7417, 467, 213, N'JqPlot Sample', N'{"preset":"New Year Expectations"}', N'{"cssClass":"nopad homeRow2","builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[]}', N'{"section":"section2","zone":"zone2","pos":1}', NULL, NULL, NULL, NULL, NULL, N'xxx', NULL, NULL, CAST(0x0000A19800FFE628 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7567, 467, 240, N'Fusion Chart Sample', N'{"preset":{"title":"Service And Stickiness","chartConfig":{"config":{"type":"Bubble","width":"100%","height":"100%","debugMode":false},"data":{"chart":{"caption":"Service And Stickiness","palette":"3","numberprefix":"$","is3d":"1","xaxismaxvalue":"100","showplotborder":"0","xaxisname":"Stickiness","yaxisname":"Cost Per Service","chartrightmargin":"30"},"categories":[{"category":[{"label":"0%","x":"0"},{"label":"20%","x":"20","showverticalline":"1"},{"label":"40%","x":"40","showverticalline":"1"},{"label":"60%","x":"60","showverticalline":"1"},{"label":"80%","x":"80","showverticalline":"1"},{"label":"100%","x":"100","showverticalline":"1"}]}],"dataset":[{"showvalues":"0","data":[{"x":"30","y":"1.3","z":"116","name":"Traders"},{"x":"32","y":"3.5","z":"99","name":"Farmers"},{"x":"8","y":"2.1","z":"33","name":"Individuals"},{"x":"62","y":"2.5","z":"72","name":"Medium Business Houses"},{"x":"78","y":"2.3","z":"55","name":"Corporate Group A"},{"x":"75","y":"1.4","z":"58","name":"Corporate Group C"},{"x":"68","y":"3.7","z":"80","name":"HNW Individuals"},{"x":"50","y":"2.1","z":"105","name":"Small Business Houses"}]}],"trendlines":{"line":[{"startvalue":"2.5","istrendzone":"0","displayvalue":"Median Cost","color":"0372AB"}]},"vtrendlines":{"line":[{"startvalue":"0","endvalue":"60","istrendzone":"1","displayvalue":"Potential Wins","color":"663333","alpha":"10"},{"startvalue":"60","endvalue":"100","istrendzone":"1","displayvalue":"Cash Cows","color":"990099","alpha":"5"}]}}}}}', N'{"cssClass":"nopad homeRow2","builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[]}', N'{"section":"section2","zone":"zone1","pos":1}', NULL, NULL, NULL, NULL, NULL, N'xxx', NULL, NULL, CAST(0x0000A19A013DF544 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7597, 475, 207, N'Step 2 - Configure SQL Server Providers', N'{"html":"<p>\nBuilt-in provider <i>SQLDashboardProvider</i> uses Microsoft SQL Server to retrieve and persist metadata. In this tutorial we will use <i>SQLDashboardProvider</i>.\n</p>\n<ol>\n<li>Using project references window (Inside solution explorer window, right click on References and click Add Reference menu item) add reference to <i>JDash.SqlProvider.dll</i>. Assembly can be found inside installation directory (by default C:\\Program Files\\Kalitte\\JDash\\Bin directory).</li>\n<li>Rebuild your project. If this step fails you may not be able to create metadata at design time.</li>\n<li>Using SQL Server Management Studio create new database.</li>\n<li>Return to Visual Studio and add a connection string to web.config for the database you setup on previous step. Ensure connection string has the necessary authentication information for connecting to the database.</li>\n<li>Open DisplayDashboard.aspx in design view, select <i>ResourceManager</i> control and using smart tag of the control, click JDash Settings menu item.</li>\n<li>Select the connection string and click Create Metadata button. This will create the necessary tables on your database. Alternatively you can use Get Script button to get the SQL scripts and manually execute the scripts.</li>\n</ol>\n<p>Below is a sample screen shot of set settings dialog.</p>\n<img src=\"../../Resource/img/Tutorial/tutorial-img2.png\" />\n"}', N'{"cssClass":"demo-content","builtInCommands":["maximize","restore","remove"],"customCommands":[]}', N'{"section":"section1","zone":"zone1","pos":1}', NULL, NULL, NULL, NULL, NULL, N'xxx', NULL, NULL, CAST(0x0000A1A000B02CC8 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7607, 475, 207, N'Step 1 - Add JDash.Net Controls', N'{"html":"<ol>\n<li>Open Microsoft Visual Studio.Net or your preferred IDE.</li>\n<li>Create a new Asp.Net Web Application project and add a new page i.e. DisplayDashboard.aspx.</li>\n<li>Using Toolbox (if not visible use Ctrl-Alt-X key combination to open it) drop <i>ScriptManager</i> (Inside Ajax Extensions tab), then <i>ResourceManager</i> control (Inside Jdash.Net tab) on the page. Settings dialog will be displayed automatically for the first time. Close settings dialog.</li>\n<li>Finally, drop <i>DashboardView</i> control on to page, after <i>ResourceManager</i> control. Please note control order should be 1 <i>ScriptManager</i>, 2 <i>ResourceManager</i> and then other controls like <i>DashboardView</i>.</li>\n</ol>\n<p>Below is a sample screenshot of the page.</p>\n<img src=\"../../Resource/img/Tutorial/tutorial-img1.png\" />"}', N'{"builtInCommands":["maximize","restore","remove"],"customCommands":[],"themeStyleId":"a","disableTheming":false}', N'{"section":"section1","zone":"zone1","pos":0}', NULL, NULL, NULL, NULL, NULL, N'xxx', NULL, NULL, CAST(0x0000A1A000FAE9FC AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7609, 475, 207, N'Step 3 - Create Your First Dashlet', N'{"html":"<p>In this step you will be creating your first dashlet with a dashlet editor.</p>\n<ol>\n<li>Using solution explorer window, select the project and right click. Create a directory named JDash and create another directory Dashlets inside JDash directory. You may choose using other names for directories although this is the recommended setup.</li>\n<li>Select Dashlets directory. Right click, using Add New Item dialog, add two Asp.Net user controls named HtmlDashlet.ascx and HtmlDashletEditor.ascx inside Dashlets directory.</li>\n<li>Implement these controls as you like. In this tutorial we will be implementing an Html Dashlet.</li>\n<li>Open HtmlDashlet.ascx and drop an Asp.Net Literal control.\n<p><code style=\"display:block;color:#424242\">&lt;asp:Literal runat=&quot;server&quot; ID=&quot;htmlLit&quot;&gt;&lt;/asp:Literal&gt;</code></p>\n</li>\n\n<li>Implement your dashlet. Below code block shows a sample. Basically, it tries to get the html configuration value set by user and renders it.\n<p><code style=\"display:block;color:#424242\">using System;<br/>\nusing System.Collections.Generic;<br/>\nusing System.Linq;<br/>\nusing System.Web;<br/>\nusing System.Web.UI;<br/>\nusing System.Web.UI.WebControls;<br/>\nusing JDash.WebForms;<br/>\n<br/>\nnamespace HelloWorld.JDash.Dashlets<br/>\n{<br/>\n   &nbsp;&nbsp;&nbsp; public partial class HtmlDashlet : System.Web.UI.UserControl<br/>\n    &nbsp;&nbsp;&nbsp; {<br/>\n        &nbsp;&nbsp;&nbsp; &nbsp; private DashletContext context;<br/>\n<br/>\n        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;[JEventHandler(JEvent.InitContext)]<br/>\n        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;public void InitContext(object sender, JEventArgs args)<br/>\n        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{<br/>\n            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;this.context = args.Event.Parameters.Get&lt;DashletContext&gt;(&quot;context&quot;);<br/>\n        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br/>\n<br/>\n       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; public override void DataBind()<br/>\n        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{<br/>\n         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   var htmlString = context.Model.config.Get&lt;string&gt;(&quot;html&quot;, &quot;&quot;);<br/>\n         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   htmlLit.Text = htmlString;<br/>\n           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.RenderDashlet();<br/>\n           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base.DataBind();<br/>\n       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br/>\n    &nbsp;&nbsp;&nbsp;}<br/>\n}<br/>\n</code></p>\n</li>\n<li>Open HtmlDashletEditor.ascx. Drop a <i>DashletTitleEditor</i> and <i>DashletStylesList</i> control using Toolbox, JDash tab. Finally add a Textbox. Content of HtmlDashletEditor.ascx should be like this.</li>\n<p><code style=\"display:block;color:#424242\">&lt;jdash:DashletTitleEditor ID=&quot;DashletTitleEditor1&quot; runat=&quot;server&quot; /&gt;<br />\n&lt;jdash:DashletStylesList ID=&quot;DashletStylesList1&quot; runat=&quot;server&quot; /&gt;\n<br/>&lt;asp:TextBox ID=&quot;htmlInput&quot; runat=&quot;server&quot; Rows=&quot;5&quot; TextMode=&quot;MultiLine&quot;&gt;&lt;/asp:TextBox&gt;\n</code></p>\n<li>Implement your dashlet editor.</li>\n<p><code style=\"display:block;color:#424242\">\nusing System;<br />\nusing System.Collections.Generic;<br />\nusing System.Linq;<br />\nusing System.Web;<br />\nusing System.Web.UI;<br />\nusing System.Web.UI.WebControls;<br />\nusing JDash.WebForms;<br />\n<br />\nnamespace HelloWorld.JDash.Dashlets<br />\n{<br />\n  &nbsp;&nbsp;&nbsp;  public partial class HtmlDashletEditor : System.Web.UI.UserControl<br />\n&nbsp;&nbsp;&nbsp;    {<br />\n&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;     DashletContext context = null;<br />\n\t\t<br />\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     public override void DataBind()<br />\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    {<br />\n      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      htmlInput.Text = context.Model.config.Get&lt;string&gt;(&quot;html&quot;, &quot;&quot;);<br />\n      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      base.DataBind();<br />\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     }<br />\n\t\t<br />\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     [JEventHandler(JEvent.InitContext)]<br />\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     public void InitContext(object sender, JEventArgs args)<br />\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     {<br />\n     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;       this.context = args.Event.Parameters.Get&lt;DashletContext&gt;(&quot;context&quot;);<br />\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     }<br />\n\t\t<br />\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     [JEventHandler(JEvent.ValidateDashletEditor)]<br />\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     public void ValidateDashletEditor(object sender, JEventArgs args)<br />\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     {<br />\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        context.Model.config[&quot;html&quot;] = htmlInput.Text;<br />\n     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;       context.SaveModel();<br />\n      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      context.DashletControl.DataBind();<br />\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    }<br />\n &nbsp;&nbsp;&nbsp;   }<br />\n}\n</code></p>\n<li>Now it is time to register your first dashlet. Select ResourceManager control and use smart tag of the control to open Management Portal. This is the application where you will define your dashlets.</li>\n<li>Click Dashlet Modules and create a new one. Note we just set a title, user control path for dashlet and editor control path.</li>\n</ol>\n<img src=\"../../Resource/img/Tutorial/tutorial-img3.png\" />"}', N'{"builtInCommands":["maximize","restore","remove"],"customCommands":[]}', N'{"section":"section1","zone":"zone1","pos":2}', NULL, NULL, NULL, NULL, NULL, N'xxx', NULL, NULL, CAST(0x0000A1A00104FC1C AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7611, 475, 207, N'Step 4 - Create a New Dashboard', N'{"html":"<p>In this step you will create a sample dashboard management page.<p>\n\n<ol>\n<li>Using project references window add reference to <i>JDash.dll</i> which can be found inside installation directory (by default C:\\Program Files\\Kalitte\\JDash\\Bin directory).</li>\n<li>Add a new Asp.Net page to your project (i.e. ManageDashboards.aspx). Using this page you will be creating and viewing dashboards.</li>\n<li>Drop an Asp.Net Textbox, Button and Repeater control on the page. Below list shows a sample markup. This page basically lists current dashboards and allows user to click to a dashboard to view it. Note we use query string to pass id of clicked dashboard.\n<p><code style=\"display:block; color:#424242\">\n\n\n&lt;form id=&quot;form1&quot; runat=&quot;server&quot;&gt; <br />\n&lt;div&gt; <br />\n&nbsp;&nbsp;&nbsp;  &lt;asp:TextBox ID=&quot;dashTitle&quot; runat=&quot;server&quot;&gt;&lt;/asp:TextBox&gt; <br />\n&nbsp;&nbsp;&nbsp;  &lt;asp:Button ID=&quot;createBtn&quot; runat=&quot;server&quot; Text=&quot;Create Dashboard&quot; \n              OnClick=&quot;createBtn_Click&quot; /&gt;&lt;br /&gt; <br />\n &nbsp;&nbsp;&nbsp; &lt;asp:Label Text=&quot;Dashboards&quot; runat=&quot;server&quot; /&gt;&lt;br /&gt; <br />\n&nbsp;&nbsp;&nbsp;  &lt;asp:Repeater runat=&quot;server&quot; id=&quot;listRepeater&quot;&gt; <br />\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      &lt;ItemTemplate&gt; <br />\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;       &lt;asp:HyperLink runat=&quot;server&quot; Target=&quot;_blank&quot;\n                         Text=&#39;&lt;%# Eval(&quot;title&quot;) %&gt;&#39; \nNavigateUrl=&#39;&lt;%# string.Format(&quot;/DisplayDashboard.aspx?id={0}&quot;, Eval(&quot;Id&quot;))  %&gt;&#39;&gt;&lt;/asp:HyperLink&gt; \n           &lt;br /&gt; <br />\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      &lt;/ItemTemplate&gt; <br />\n &nbsp;&nbsp;&nbsp;  &lt;/asp:Repeater&gt; <br />\n&lt;/div&gt; <br />\n&lt;/form&gt; <br />\n\n\n\n</code></p>\n</li>\n<li>Inside page load handler bind current dashboards to repeater.\n<p><code style=\"display:block; color:#424242\">\n\nusing System;<br />\nusing System.Collections.Generic;<br />\nusing System.Linq;<br />\nusing System.Web;<br />\nusing System.Web.UI;<br />\nusing System.Web.UI.WebControls;<br />\nusing JDash;<br />\nusing JDash.Models;<br />\n<br />\n...<br />\n<br />\nprotected void Page_Load(object sender, EventArgs e)<br />\n{<br />\n&nbsp;&nbsp;&nbsp;    if (!Page.IsPostBack)<br />\n&nbsp;&nbsp;&nbsp;    {<br />\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     listRepeater.DataSource = JDashManager.Provider.SearchDashboards().data;<br />\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     listRepeater.DataBind();<br />\n &nbsp;&nbsp;&nbsp;   }<br />\n}<br />\n\n</code></p>\n\n\n</li>\n<li>Inside click handler of button, create a new dashboard.\n<p><code style=\"display:block; color:#424242\">\n\nprotected void createBtn_Click(object sender, EventArgs e)<br />\n{<br />\n&nbsp;&nbsp;&nbsp;   var newDashboard = new DashboardModel()<br />\n &nbsp;&nbsp;&nbsp;  {<br />\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  title = dashTitle.Text<br />\n  &nbsp;&nbsp;&nbsp; };<br />\n   &nbsp;&nbsp;&nbsp;&nbsp;JDashManager.Provider.CreateDashboard(newDashboard);<br />\n  &nbsp;&nbsp;&nbsp; listRepeater.DataSource = JDashManager.Provider.SearchDashboards().data;<br />\n  &nbsp;&nbsp;&nbsp; listRepeater.DataBind();<br />\n}\n\n\n</code></p>\n\n\n</li>\n</ol>"}', N'{"builtInCommands":["maximize","restore","remove"],"customCommands":[]}', N'{"section":"section1","zone":"zone1","pos":3}', NULL, NULL, NULL, NULL, NULL, N'xxx', NULL, NULL, CAST(0x0000A1A001063F8C AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7612, 475, 207, N'Step 5 - Display and Design Dashboard', N'{"html":"<p>Final step is to add basic design functionality to DisplayDashboard.aspx.</p>\n\n<ol>\n<li>Open DisplayDashboard.aspx file, add an update panel and repeater. Repeater will be used to list dashlet modules and user will click a dashlet module to add it to dashboard. Please note we have changed <i>UserDesignMode</i> property of <i>DashboardView </i>control.\n<p><code style=\"display:block; color:#424242\">\n\n&lt;form id=&quot;form1&quot; runat=&quot;server&quot;&gt;<br />\n&nbsp;&nbsp;&nbsp;  &lt;div&gt;<br />\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &lt;asp:ScriptManager ID=&quot;ScriptManager1&quot; runat=&quot;server&quot;&gt;&lt;/asp:ScriptManager&gt;<br />\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &lt;jdash:ResourceManager ID=&quot;ResourceManager1&quot; runat=&quot;server&quot; /&gt;<br />\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &lt;asp:UpdatePanel runat=&quot;server&quot;&gt;<br />\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &lt;ContentTemplate&gt;<br />\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    &lt;asp:Repeater runat=&quot;server&quot; id=&quot;modulesList&quot; \n                     OnItemCommand=&quot;modulesList_ItemCommand&quot;&gt;<br />\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        &lt;ItemTemplate&gt;<br />\n      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     &lt;asp:LinkButton runat=&quot;server&quot; Text=&#39;&lt;%# Eval(&quot;title&quot;) %&gt;&#39; \n                           CommandArgument=&#39;&lt;%# Eval(&quot;id&quot;) %&gt;&#39;&gt;&lt;/asp:LinkButton&gt;<br />\n     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    &lt;/ItemTemplate&gt;<br />\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    &lt;/asp:Repeater&gt;<br />\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;/ContentTemplate&gt;<br />\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &lt;/asp:UpdatePanel&gt;<br />\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;jdash:DashboardView ID=&quot;myDashboard&quot; UserDesignMode=&quot;full&quot; runat=&quot;server&quot; /&gt;<br />\n &nbsp;&nbsp;&nbsp; &lt;/div&gt;<br />\n&lt;/form&gt;<br />\n\n\n\n</code></p>\n</li>\n\n<li>On page load handler, use query string parameter to get <i>id</i> of dashboard which should be loaded by <i>DashboardView</i> control. We also bind dashlet modules to repeater.\n<p><code style=\"display:block; color:#424242\">\n\n\n\n\nprotected void Page_Load(object sender, EventArgs e)<br />\n{<br />\n &nbsp;&nbsp;&nbsp;  if (!Page.IsPostBack &amp;&amp; !string.IsNullOrEmpty(Request.QueryString[&quot;id&quot;]))<br />\n    &nbsp;&nbsp;&nbsp;  {<br />\n     &nbsp;&nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;       myDashboard.DashboardId = Request.QueryString[&quot;id&quot;];<br />\n     &nbsp;&nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;       myDashboard.DataBind();<br />\n     &nbsp;&nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;       modulesList.DataSource = JDashManager.Provider.SearchDashletModules().data;<br />\n      &nbsp;&nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;      modulesList.DataBind();<br />\n  &nbsp;&nbsp;&nbsp;     }<br />\n}<br />\n\n\n</code></p>\n</li>\n<li>Final step is to create a dashlet.\n\n<p><code style=\"display:block; color:#424242\">\n\n\nprotected void modulesList_ItemCommand(object source, RepeaterCommandEventArgs e)<br />\n{<br />\n&nbsp;&nbsp;&nbsp;     var moduleId = e.CommandArgument.ToString();<br />\n &nbsp;&nbsp;&nbsp;    var module = JDashManager.Provider.GetDashletModule(moduleId);<br />\n &nbsp;&nbsp;&nbsp;    var newDashlet = new DashletModel(module);<br />\n&nbsp;&nbsp;&nbsp;     myDashboard.CreateDashlet(newDashlet);<br />\n}<br />\n\n\n</code></p>\n</li>\n</ol>\n\n<p>All done and everything is automatically managed by JDash.Net framework. You may create as many as dashlets you want.</p>\n<img src=\"../../Resource/img/Tutorial/tutorial-img4.png\" />"}', N'{"builtInCommands":["maximize","restore","remove"],"customCommands":[]}', N'{"section":"section1","zone":"zone1","pos":4}', NULL, NULL, NULL, NULL, NULL, N'xxx', NULL, NULL, CAST(0x0000A1A00106B264 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7704, 483, 250, N'Totals by Payment Types', N'{"query":"{\"ConnectionName\":null,\"CatalogName\":null,\"CubeName\":\"Product Sales\",\"Dimensions\":[\"Country\"],\"Measures\":[\"Quantity\",\"Total_Price\"],\"Aggregations\":{},\"SourceData\":null,\"Sort\":[{\"Column\":\"Quantity\",\"Direction\":1}],\"Skip\":-1,\"Take\":5}"}', N'{"builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[],"cssClass":"nopad"}', N'{"section":"section2","zone":"zone1","pos":2}', NULL, NULL, NULL, NULL, NULL, N'KALITTE\tansu', NULL, NULL, CAST(0x0000A1B700D428E4 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7705, 483, 250, N'Top Totals By Product & Payment Type', N'{"query":"{\"ConnectionName\":null,\"CatalogName\":null,\"CubeName\":\"Product Sales\",\"Dimensions\":[\"Product\",\"Payment_Type\"],\"Measures\":[\"Quantity\",\"Total_Price\"],\"Aggregations\":{},\"SourceData\":null,\"Sort\":[{\"Column\":\"Quantity\",\"Direction\":1}],\"Skip\":-1,\"Take\":5}"}', N'{"builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[],"cssClass":"nopad"}', N'{"section":"section2","zone":"zone2","pos":2}', NULL, NULL, NULL, NULL, NULL, N'KALITTE\tansu', NULL, NULL, CAST(0x0000A1B700D43820 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7706, 483, 251, N'Quantity by Product', N'{"query":"{\"ConnectionName\":null,\"CatalogName\":null,\"CubeName\":\"Product Sales\",\"Dimensions\":[\"Product\"],\"Measures\":[\"Quantity\"],\"Aggregations\":{},\"SourceData\":null,\"Sort\":[],\"Skip\":-1,\"Take\":-1}","chart":"{\"ChartType\":0,\"Header\":\"\",\"Footer\":\"\",\"Height\":\"\",\"HasPivotDimension\":false,\"Theme\":\"blue\"}"}', N'{"builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[],"cssClass":"nopad"}', N'{"section":"section2","zone":"zone2","pos":1}', NULL, NULL, NULL, NULL, NULL, N'KALITTE\tansu', NULL, NULL, CAST(0x0000A1B700D487D0 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7707, 483, 251, N'Product Totals by Year', N'{"query":"{\"ConnectionName\":null,\"CatalogName\":null,\"CubeName\":\"Product Sales\",\"Dimensions\":[\"Product\"],\"Measures\":[\"Total_Price\"],\"Aggregations\":{},\"SourceData\":null,\"Sort\":[],\"Skip\":-1,\"Take\":-1}","chart":"{\"ChartType\":4,\"Header\":\"\",\"Footer\":\"\",\"Height\":\"\",\"HasPivotDimension\":false,\"Theme\":\"default\"}"}', N'{"builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[],"cssClass":"nopad"}', N'{"section":"section2","zone":"zone1","pos":1}', NULL, NULL, NULL, NULL, NULL, N'KALITTE\tansu', NULL, NULL, CAST(0x0000A1B700D55AC0 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7708, 483, 251, N'Quantity by State & Product', N'{"query":"{\"ConnectionName\":null,\"CatalogName\":null,\"CubeName\":\"Product Sales\",\"Dimensions\":[\"State\",\"Product\"],\"Measures\":[\"Quantity\"],\"Aggregations\":{},\"SourceData\":null,\"Sort\":[],\"Skip\":-1,\"Take\":-1}","chart":"{\"ChartType\":2,\"Header\":\"\",\"Footer\":\"\",\"Height\":\"\",\"HasPivotDimension\":true,\"Theme\":\"default\"}"}', N'{"builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[],"cssClass":"nopad"}', N'{"section":"section2","zone":"zone2","pos":0}', NULL, NULL, NULL, NULL, NULL, N'KALITTE\tansu', NULL, NULL, CAST(0x0000A1B700D5E88C AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7709, 483, 251, N'Collected VAT by Product & Year', N'{"query":"{\"ConnectionName\":null,\"CatalogName\":null,\"CubeName\":\"Product Sales\",\"Dimensions\":[\"Year\",\"Product\"],\"Measures\":[\"Quantity\"],\"Aggregations\":{},\"SourceData\":null,\"Sort\":[],\"Skip\":-1,\"Take\":-1}","chart":"{\"ChartType\":1,\"Header\":\"\",\"Footer\":\"\",\"Height\":\"\",\"HasPivotDimension\":true,\"Theme\":\"default\"}"}', N'{"builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[],"cssClass":"nopad"}', N'{"section":"section1","zone":"zone1","pos":1}', NULL, NULL, NULL, NULL, NULL, N'KALITTE\tansu', NULL, NULL, CAST(0x0000A1B700D6B0F0 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7710, 483, 251, N'Total by Year', N'{"query":"{\"ConnectionName\":null,\"CatalogName\":null,\"CubeName\":\"Product Sales\",\"Dimensions\":[\"Year\"],\"Measures\":[\"Total_Price\"],\"Aggregations\":{},\"SourceData\":null,\"Sort\":[],\"Skip\":-1,\"Take\":-1}","chart":"{\"ChartType\":4,\"Header\":\"\",\"Footer\":\"\",\"Height\":\"\",\"HasPivotDimension\":false,\"Theme\":\"default\"}"}', N'{"builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[],"cssClass":"nopad"}', N'{"section":"section2","zone":"zone1","pos":0}', NULL, NULL, NULL, NULL, NULL, N'KALITTE\tansu', NULL, NULL, CAST(0x0000A1B700D9E414 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7711, 467, 209, N'Highchart Sample', N'{"preset":"Combination chart","theme":"default"}', N'{"cssClass":"nopad homeRow2","builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[]}', N'{"section":"section2","zone":"zone1","pos":0}', NULL, NULL, NULL, N'', N'', N'KALITTE\tansu', NULL, NULL, CAST(0x0000A29A01006098 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7712, 467, 229, N'D3 Sample', N'{"preset":"Multiple Chart Selection"}', N'{"builtInCommands":["maximize","restore","remove"],"customCommands":[],"cssClass":"nopad homeRow2"}', N'{"section":"section2","zone":"zone2","pos":2}', NULL, NULL, NULL, N'', N'', N'KALITTE\tansu', NULL, NULL, CAST(0x0000A29A0100B907 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7713, 467, 233, N'Geographic Heat Map Sample', N'{}', N'{"cssClass":"googleMapVis","builtInCommands":["maximize","restore","remove"],"customCommands":[]}', N'{"section":"section1","zone":"zone1","pos":0}', NULL, NULL, NULL, N'', N'', N'KALITTE\tansu', NULL, NULL, CAST(0x0000A29A01019A0A AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7715, 467, 232, N'Geographic Polylines Sample', N'{}', N'{"cssClass":"googleMapVis nopad homeRow2","builtInCommands":["maximize","restore","remove"],"customCommands":[],"themeStyleId":"b","disableTheming":false}', N'{"section":"section2","zone":"zone1","pos":2}', NULL, NULL, NULL, N'', N'', N'KALITTE\tansu', NULL, NULL, CAST(0x0000A29A0101E643 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7726, 473, 207, N'HTML', N'{"html":"<h2 class=\"text-success\">Hi! This is your dashboard.</h2>\n<h3>Why not to <a onclick=\"showCreateDashletControl(); return false;\"  href=\"javascript:__doPostBack(''ctl00$createDashetBtn'','''')\">+ add some new dashlets</a> ?</h3>\nor <a href=\"/demo?id=484\">get started</a>."}', N'{"builtInCommands":["maximize","restore","remove"],"customCommands":[],"cssClass":"h220"}', N'{"section":"section1","zone":"zone1","pos":1}', NULL, NULL, NULL, N'', N'', N'KALITTE\tansu', NULL, NULL, CAST(0x0000A29A01223562 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7728, 484, 207, N'More ?', N'{"html":"<div>\n\n        <div class=\"row\">\n            <div class=\"span12\">\n                <div class=\"col-md-4\">\n\n                    <div id=\"product\" class=\"col\">\n                        <h1>Imagine this:</h1>\n                        <h2>Your users are able to customize start page of your application and create their own dashboards using your dashlets.</h2>\n                        <h2>And you develop dashlets as regular Asp.Net user controls - ascx files. So cool ? And now even easy!</h2>\n                        <p>\n                            Dashboards are great ways for end users to understand and monitor current status of their business.\n                        </p>\n                        <p>\n                            With JDash.Net, you allow them to create and design their own dashboards using desktop or mobile devices with simple drag-drops. Result is highly satisfied happy customers and reduced maintenance costs. \n                        </p>\n                        <h2>Key features\n                        </h2>\n                        <ul>\n                            <li>Responsive design. Mobile and desktop fully supported.</li>\n                            <li>Seemlessly integratable into your application.</li>\n                            <li>Use your current Asp.Net skills for development.</li>\n                            <li>Supports multiple layouts, not limited to only columns.</li>\n                            <li>Database and browser independent. MsSQL and MySql included.</li>\n\n                        </ul>\n                    </div>\n\n                </div>\n                <div class=\"col-md-4\">\n\n                    <div id=\"demo\" class=\"col\">\n                        <h1>About this demo\n                        </h1>\n                        <p>\n                            Purpose of this application is to demonstrate features and powerful architecture of JDash.Net. Demo is open source and <a target=\"_blank\" href=\"http://jdash.net/download\">download package</a> includes source code.\n                        </p>\n                        <ul>\n                            <li>Have a look at your <a href=\"demo?id=473\">first dashboard</a>. </li>\n                            <li>Click \"Home Dashboard\" button  on top of page to open a list of dashboards.</li>\n                            <li>Use <i class=\"icon-th\"></i>Create link on toolbar to create a dashboard for you.</li>\n                            <li>Use <i class=\"icon-plus-sign\"></i>Add Dashlet link to add some dashlets. We demonstrated image/javascript based charts from different vendors in Sample Visualizations tab.</li>\n                            <li>Resize your browser or view this demo on your tablet or mobile phone to see responsive design capabilities.</li>\n                        </ul>\n                        <h2>About Dashlets\n                        </h2>\n                        <p>\n                            Demo includes dashlets which may use 3rd party libraries or products. Please refer to their own documentation for licensing options of 3rd party libraries.\n                        </p>\n                    </div>\n\n                </div>\n\n                <div class=\"col-md-4\">\n\n                    <div id=\"developer\" class=\"col\">\n                        <h1>Developer notes\n                        </h1>\n                        <h2>It only takes 60 seconds to get started with JDash.Net</h2>\n                        <h2></h2>\n                        <p>\n                            Simply, develop regular Asp.Net user controls – ascx. JDash.Net automatically converts your user controls to drag-drop dashlets which in turn your users use dashlets to design their dashboards. \n                It only takes 60 seconds to get started with JDash.Net using your current Asp.Net knowledge. \n                        </p>\n                        <p>\n                            No JavaScript skill is required. All page lifecycle and dynamic control creation is handled intelligently by JDash.Net.\n                        </p>\n                        <h2>Resources\n                        </h2>\n                        <ul>\n                            <li><a target=\"_blank\" href=\"/download\">Download JDash.Net</a></li>\n                            <li><a href=\"/demo?id=475\">View Online Tutorial</a></li>\n                            <li><a target=\"_blank\" href=\"/Docs/JDashNetDevelopersGuide.pdf\">View Developers Guide</a> </li>\n                            <li><a target=\"_blank\" href=\"http://forum.jdash.net\">Get support</a></li>\n                        </ul>\n                    </div>\n                </div>\n\n            </div>\n        </div>\n    </div>"}', N'{"builtInCommands":["maximize","restore","remove"],"customCommands":[],"cssClass":"demo-content"}', N'{"section":"section1","zone":"zone1","pos":1}', NULL, NULL, NULL, N'', N'', N'KALITTE\tansu', NULL, NULL, CAST(0x0000A29A0127E351 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7729, 484, 207, N'HTML', N'{"html":"<h3 class=\"\">\nBrowse some great dashboards ?\n</h3>\n\n<a href=\"/demo?id=467\" class=\"btn btn-primary btn-block btn-lg\">Sample Visualizations</a>\n<a href=\"/demo?id=483\" class=\"btn btn-primary btn-block btn-lg\">Data Analysis </a>\n<h3>\nMaybe \n<a href=\"javascript:__doPostBack(''ctl00$ctlCreateDashboardWindow'','''')\">create an empty dashboard</a> ?\n</h3>"}', N'{"builtInCommands":["maximize","restore","remove"],"customCommands":[]}', N'{"section":"section1","zone":"zone2","pos":1}', NULL, NULL, NULL, N'', N'', N'KALITTE\tansu', NULL, NULL, CAST(0x0000A29A012847ED AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7730, 484, 207, N'So simply what is this stuff ?', N'{"html":"<div class=\"row\">\n  <div class=\"col-md-4\">\n    <h2 class=\"text-success\">You</h2>\n    <h3>Implement Asp.Net user controls – ascx files.</h3> \n  </div>\n\n  <div class=\"col-md-4\">\n    <h2 class=\"text-success\">JDash</h2>\n    <h3>Converts them into drag-drop dashlets.</h3>\n  </div>\n\n<div class=\"col-md-4\">\n   <h2 class=\"text-success\">Customers</h2>\n   <h3>Design their dashboards using dashlets!</h3>\n</div>\n\n</div>"}', N'{"builtInCommands":["maximize","restore","remove"],"customCommands":[]}', N'{"section":"section1","zone":"zone1","pos":0}', NULL, NULL, NULL, N'', N'', N'KALITTE\tansu', NULL, NULL, CAST(0x0000A29A01287AD6 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7731, 484, 207, N'Move Forward', N'{"html":"<h1>\nIncredible! \n</h1>\n<h3>\nAll done with Asp.Net Web Forms!\n</h3>\n<div class=\"row\">\n  <div class=\"col-md-4\">\n<a href=\"/download\" class=\"btn btn-success btn-block btn-lg\">Download</a>\n  </div>\n\n  <div class=\"col-md-4\">\n<a href=\"/demo?id=475\" class=\"btn btn-success btn-block btn-lg\">Tutorial</a>\n  </div>\n\n<div class=\"col-md-4\">\n<a href=\"/Docs/JDashNetDevelopersGuide.pdf\" class=\"btn btn-success btn-block btn-lg\">Guide</a>\n</div>\n\n</div>"}', N'{"builtInCommands":["maximize","restore","remove"],"customCommands":[]}', N'{"section":"section1","zone":"zone2","pos":2}', NULL, NULL, NULL, N'', N'', N'KALITTE\tansu', NULL, NULL, CAST(0x0000A29A01288974 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [Dashlet] ([id], [dashboardId], [dashletModuleId], [title], [config], [paneConfig], [position], [style], [cls], [attr], [groupName], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [userData], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (7732, 484, 207, N'HTML', N'{"html":"<h3>Why not to <a onclick=\"showCreateDashletControl(); return false;\"  href=\"javascript:__doPostBack(''ctl00$createDashetBtn'','''')\">+ add some new dashlets</a> ?</h3>\nor goto <a href=\"/demo?id=473\">your first dashboard</a>."}', N'{"builtInCommands":["maximize","restore","remove"],"customCommands":[]}', N'{"section":"section1","zone":"zone2","pos":0}', NULL, NULL, NULL, N'', N'', N'KALITTE\tansu', NULL, NULL, CAST(0x0000A29A012B146D AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [Dashlet] OFF
GO
SET IDENTITY_INSERT [DashletModule] ON 

GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (207, N'[WfDefault]', N'HTML', N'{"wfConfig":{"uc":"~/jdash/dashlets/html/view.ascx","ec":"~/jdash/dashlets/html/edit.ascx","autoEdit":true,"notifications":{"commands":[]}},"editor":{"paneConfig":{"cssClass":"","width":"700px","height":"-"},"useWindow":true}}', N'{"cssClass":null,"builtInCommands":["maximize","restore","remove"],"customCommands":[]}', N'{}', NULL, NULL, NULL, N'Allows to use html mark-up inside a dashlet.', N'berkay', NULL, NULL, CAST(0x0000A24600644010 AS DateTime), NULL, NULL, N'Library', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (208, N'[WfDefault]', N'RSS Reader', N'{"wfConfig":{"uc":"~/Jdash/dashlets/RssReader/View.ascx","autoEdit":true,"notifications":{"commands":[]},"ec":"~/Jdash/dashlets/RssReader/Edit.ascx"},"editor":{"paneConfig":{"cssClass":"","width":"600px","height":"-"},"useWindow":true}}', N'{"cssClass":"rssReader","builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[]}', N'{}', NULL, NULL, NULL, N'Retreives rss feeds and displays inside dashlet.', N'berkay', NULL, NULL, CAST(0x0000A248012A0110 AS DateTime), NULL, NULL, N'Library', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (209, N'jdash/dashlets/highchart/hcModule', N'Highchart Sample', N'{"wfConfig":{"uc":"~/jdash/dashlets/Highchart/view.ascx","ec":"~/jdash/dashlets/Highchart/edit.ascx","autoEdit":false,"notifications":{"commands":[]}},"editor":{"paneConfig":{"cssClass":null,"width":null,"height":null},"useWindow":false}}', N'{"cssClass":"nopad","builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[]}', N'{}', NULL, NULL, NULL, N'Displays a Highchart chart.', N'berkay', NULL, NULL, CAST(0x0000A24900C72090 AS DateTime), NULL, NULL, N'Visualizations', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (211, N'[WfDefault]', N'Publisher', N'{"wfConfig":{"uc":"~/jdash/dashlets/Publisher/View.ascx","ec":"~/jdash/dashlets/Publisher/Edit.ascx","autoEdit":false,"notifications":{"commands":[]}},"editor":{"paneConfig":{"cssClass":""},"useWindow":false}}', N'{"builtInCommands":["remove"],"customCommands":[]}', N'{}', NULL, NULL, NULL, NULL, N'berkay', NULL, NULL, CAST(0x0000A24A00F890D0 AS DateTime), NULL, NULL, N'Samples', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (212, N'[WfDefault]', N'Consumer', N'{"wfConfig":{"uc":"~/jdash/dashlets/Consumer/View.ascx","ec":"~/jdash/dashlets/Consumer/Edit.ascx","autoEdit":false,"notifications":{"commands":[]}},"editor":{"paneConfig":{"cssClass":""},"useWindow":false}}', N'{"builtInCommands":["remove"],"customCommands":[]}', N'{}', NULL, NULL, NULL, NULL, N'berkay', NULL, NULL, CAST(0x0000A24A00F890D0 AS DateTime), NULL, NULL, N'Samples', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (213, N'jdash/dashlets/jqplot/jqPlotModule', N'JqPlot Sample', N'{"wfConfig":{"uc":"~/jdash/dashlets/JqPlot/view.ascx","ec":"~/jdash/dashlets/JqPlot/edit.ascx","autoEdit":false,"notifications":{"commands":[]}},"editor":{"paneConfig":{"cssClass":null,"width":null,"height":null},"useWindow":false}}', N'{"cssClass":null,"builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[]}', N'{}', NULL, NULL, NULL, N'Displays a JqPlot chart', N'berkay', NULL, NULL, CAST(0x0000A24A00644010 AS DateTime), NULL, NULL, N'Visualizations', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (219, N'[WfDefault]', N'Google Code', N'{"wfConfig":{"uc":"~/jdash/dashlets/RssReader/view.ascx","ec":"~/jdash/dashlets/RssReader/edit.ascx","autoEdit":false,"notifications":{"commands":["maximize","restore"]}},"editor":{"useWindow":false,"paneConfig":{}}}', N'{"cssClass":"rssReader","builtInCommands":["maximize","restore","remove","refresh"],"themeStyleId":"b","disableTheming":true,"customCommands":[]}', N'{"RssUrl":"http://feeds.feedburner.com/GDBcode?format=xml","Interval":15,"ShowBody":false}', NULL, NULL, NULL, N'A pre configured Rss Reader for Google Code Blog.', N'berkay', NULL, NULL, CAST(0x0000A24A0095B050 AS DateTime), NULL, NULL, N'Rss Feeds', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (220, N'[WfDefault]', N'Event Capturer', N'{"wfConfig":{"uc":"~/Jdash/dashlets/EventCapture/view.ascx","ec":null,"autoEdit":false,"notifications":{"commands":["ClearCapturedEvents"]}}}', N'{"builtInCommands":["maximize","restore","remove"],"customCommands":[{"name":"ClearCapturedEvents","label":"Clear Captured Events","type":"custom","confirm":true,"confirmMessage":"Clear all events captured ?","ui":{"iconClass":"d-icon-trash","title":"Clear Captured Events"}}],"cssClass":"nopad"}', N'{}', NULL, NULL, NULL, N'Listens for events, captures and displays.', N'xxx', NULL, NULL, CAST(0x0000A18E01649208 AS DateTime), NULL, NULL, N'Samples', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (221, N'JDash/Dashlets/GoogleMaps/GoogleMap', N'Google Map Template', N'{"wfConfig":{"uc":"~/jdash/dashlets/GoogleMaps/view.ascx","ec":"~/jdash/dashlets/GoogleMaps/edit.ascx","autoEdit":false,"notifications":{"commands":[]}},"editor":{"paneConfig":{"cssClass":null,"width":null,"height":null},"useWindow":false}}', N'{"cssClass":"nopad","builtInCommands":["maximize","restore","remove"],"customCommands":[]}', N'{}', NULL, NULL, NULL, NULL, N'xxx', NULL, NULL, CAST(0x0000A18E0129BD18 AS DateTime), NULL, NULL, N'Samples', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (222, N'[WfDefault]', N'Pop Client', N'{"wfConfig":{"uc":"~/jdash/dashlets/PopClient/view.ascx","ec":"~/jdash/dashlets/PopClient/edit.ascx","autoEdit":false,"notifications":{"commands":["refresh"]}},"editor":{"paneConfig":{"width":"500px","height":"450px","cssClass":null},"useWindow":true}}', N'{"cssClass":"popClient","builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[]}', N'{}', NULL, NULL, NULL, N'Connects Smtp servers to get e-mails.', N'xxx', NULL, NULL, CAST(0x0000A18E00EB8C00 AS DateTime), NULL, NULL, N'Library', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (223, N'[WfDefault]', N'Ms Chart Sample', N'{"wfConfig":{"uc":"~/jdash/dashlets/MsChart/view.ascx","ec":"~/jdash/dashlets/MsChart/edit.ascx","autoEdit":true,"notifications":{"commands":["refresh"]}},"editor":{"paneConfig":{"width":"550px","height":"375px","cssClass":null},"useWindow":true}}', N'{"cssClass":"msChart","builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[]}', N'{}', NULL, NULL, NULL, N'Sample MsCharts', N'xxx', NULL, NULL, CAST(0x0000A18F001804D4 AS DateTime), NULL, NULL, N'Visualizations', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (224, N'[WfDefault]', N'Rich Text', N'{"wfConfig":{"uc":"~/Jdash/dashlets/RichText/View.ascx","autoEdit":true,"notifications":{"commands":[]},"ec":"~/Jdash/dashlets/RichText/Edit.ascx"},"editor":{"paneConfig":{"cssClass":"rtEditor","width":"500px","height":"-"},"useWindow":true,"path":"JDash/Dashlets/RichText/RichTextEditor"}}', N'{"builtInCommands":["maximize","restore","remove"],"customCommands":[],"cssClass":null}', N'{}', NULL, NULL, NULL, NULL, N'xxx', NULL, NULL, CAST(0x0000A190001E0528 AS DateTime), NULL, NULL, N'Library', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (229, N'JDash/Dashlets/D3/D3Module', N'D3 Sample', N'{"wfConfig":{"uc":"~/Jdash/dashlets/D3/View.ascx","ec":"~/Jdash/dashlets/D3/Edit.ascx","autoEdit":false,"notifications":{"commands":[]}},"editor":{"paneConfig":{"cssClass":null,"width":null,"height":null},"useWindow":false}}', N'{"builtInCommands":["maximize","restore","remove"],"customCommands":[],"cssClass":"D3Dashlet"}', N'{}', NULL, NULL, NULL, NULL, N'xxx', NULL, NULL, CAST(0x0000A1920128F388 AS DateTime), NULL, NULL, N'Visualizations', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (232, N'JDash/Dashlets/PolyLines/GoogleMapVisualizer', N'Geographic Polylines Sample', N'{"wfConfig":{"uc":"~/jdash/dashlets/PolyLines/view.ascx","ec":"~/jdash/dashlets/PolyLines/edit.ascx","autoEdit":false,"notifications":{"commands":[]}},"editor":{"paneConfig":{"cssClass":null,"width":null,"height":null},"useWindow":false}}', N'{"cssClass":"googleMapVis","builtInCommands":["maximize","restore","remove"],"customCommands":[]}', N'{}', NULL, NULL, NULL, NULL, N'xxx', NULL, NULL, CAST(0x0000A1940054A2CC AS DateTime), NULL, NULL, N'Visualizations', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (233, N'JDash/Dashlets/HeatMap/GoogleMapVisualizer', N'Geographic Heat Map Sample', N'{"wfConfig":{"uc":"~/jdash/dashlets/HeatMap/view.ascx","ec":"~/jdash/dashlets/HeatMap/edit.ascx","autoEdit":false,"notifications":{"commands":[]}},"editor":{"paneConfig":{"cssClass":null,"width":null,"height":null},"useWindow":false}}', N'{"cssClass":"googleMapVis","builtInCommands":["maximize","restore","remove"],"customCommands":[]}', N'{}', NULL, NULL, NULL, NULL, N'xxx', NULL, NULL, CAST(0x0000A19500C0BDCC AS DateTime), NULL, NULL, N'Visualizations', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (236, N'[WfDefault]', N'Reddit Programming', N'{"wfConfig":{"uc":"~/jdash/dashlets/RssReader/view.ascx","ec":"~/jdash/dashlets/RssReader/edit.ascx","autoEdit":false,"notifications":{"commands":["maximize","restore"]}},"editor":{"useWindow":false,"paneConfig":{"cssClass":null,"width":null,"height":null}}}', N'{"cssClass":"rssReader","builtInCommands":["maximize","restore","remove","refresh"],"themeStyleId":"b","disableTheming":true,"customCommands":[]}', N'{"RssUrl":"http://www.reddit.com/r/programming/.rss","Interval":15,"ShowBody":false}', NULL, NULL, NULL, N'A pre configured Rss Reader for programming sub Reddit.', N'berkay', NULL, NULL, CAST(0x0000A24A00644010 AS DateTime), NULL, NULL, N'Rss Feeds', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (237, N'[WfDefault]', N'Microsoft Offical Blog', N'{"wfConfig":{"uc":"~/jdash/dashlets/RssReader/view.ascx","ec":"~/jdash/dashlets/RssReader/edit.ascx","autoEdit":false,"notifications":{"commands":["maximize","restore"]}},"editor":{"useWindow":false,"paneConfig":{"cssClass":null,"width":null,"height":null}}}', N'{"cssClass":"rssReader","builtInCommands":["maximize","restore","remove","refresh"],"themeStyleId":"b","disableTheming":true,"customCommands":[]}', N'{"RssUrl":"http://blogs.technet.com/b/microsoft_blog/rss.aspx","Interval":15,"ShowBody":false}', NULL, NULL, NULL, N'A pre configured Rss Reader for Microsoft Blog.', N'berkay', NULL, NULL, CAST(0x0000A24A00644010 AS DateTime), NULL, NULL, N'Rss Feeds', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (238, N'[WfDefault]', N'Software Engineering Radio', N'{"wfConfig":{"uc":"~/jdash/dashlets/RssReader/view.ascx","ec":"~/jdash/dashlets/RssReader/edit.ascx","autoEdit":false,"notifications":{"commands":["maximize","restore"]}},"editor":{"useWindow":false,"paneConfig":{"cssClass":null,"width":null,"height":null}}}', N'{"cssClass":"rssReader","builtInCommands":["maximize","restore","remove","refresh"],"themeStyleId":"b","disableTheming":true,"customCommands":[]}', N'{"RssUrl":"http://www.se-radio.net/feed/","Interval":15,"ShowBody":false}', NULL, NULL, NULL, N'The Podcast for Professional Software Developers.', N'berkay', NULL, NULL, CAST(0x0000A24A00644010 AS DateTime), NULL, NULL, N'Rss Feeds', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (239, N'[WfDefault]', N'Net Tuts+', N'{"wfConfig":{"uc":"~/jdash/dashlets/RssReader/view.ascx","ec":"~/jdash/dashlets/RssReader/edit.ascx","autoEdit":false,"notifications":{"commands":["maximize","restore"]}},"editor":{"useWindow":false,"paneConfig":{"cssClass":null,"width":null,"height":null}}}', N'{"cssClass":"rssReader","builtInCommands":["maximize","restore","remove","refresh"],"themeStyleId":"b","disableTheming":true,"customCommands":[]}', N'{"RssUrl":"http://feeds.feedburner.com/nettuts","Interval":15,"ShowBody":false}', NULL, NULL, NULL, N'Offical Net Tuts+ feeds.', N'berkay', NULL, NULL, CAST(0x0000A24A00644010 AS DateTime), NULL, NULL, N'Rss Feeds', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (240, N'jdash/dashlets/FusionCharts/FusionChart', N'Fusion Charts Sample', N'{"wfConfig":{"uc":"~/jdash/dashlets/FusionCharts/view.ascx","ec":"~/jdash/dashlets/FusionCharts/edit.ascx","autoEdit":false,"notifications":{"commands":[]}},"editor":{"paneConfig":{"cssClass":null,"width":null,"height":null},"useWindow":false}}', N'{"cssClass":"nopad","builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[]}', N'{}', NULL, NULL, NULL, N'Displays a Fusion Chart.', N'berkay', NULL, NULL, CAST(0x0000A248012A0110 AS DateTime), NULL, NULL, N'Visualizations', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (241, N'[WfDefault]', N'CNN Top News', N'{"wfConfig":{"uc":"~/jdash/dashlets/RssReader/view.ascx","ec":"~/jdash/dashlets/RssReader/edit.ascx","autoEdit":false,"notifications":{"commands":["maximize","restore"]}},"editor":{"useWindow":false,"paneConfig":{}}}', N'{"cssClass":"rssReader","builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[]}', N'{"RssUrl":"http://rss.cnn.com/rss/edition.rss","Interval":5,"ShowBody":true}', NULL, NULL, NULL, N'A pre configured Rss Reader for CNN Top News', N'berkay', NULL, NULL, CAST(0x0000A24A00C72090 AS DateTime), NULL, NULL, N'Rss Feeds', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (246, N'[WfDefault]', N'Dashboard List', N'{"wfConfig":{"uc":"~/Jdash/dashlets/DashboardList/view.ascx","ec":"~/Jdash/dashlets/DashboardList/edit.ascx","autoEdit":false,"notifications":{"commands":["refresh"]}},"editor":{"paneConfig":{"cssClass":null,"width":null,"height":null},"useWindow":false}}', N'{"builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[],"cssClass":"nopad"}', N'{}', NULL, NULL, NULL, N'Listens for events, captures and displays.', N'xxx', NULL, NULL, CAST(0x0000A18E0101B188 AS DateTime), NULL, NULL, N'Library', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (250, N'[WfDefault]', N'Table View', N'{"wfConfig":{"uc":"~/Jdash/dashlets/DataAnalysis/tableview.ascx","ec":"~/Jdash/dashlets/DataAnalysis/tableviewEditor.ascx","autoEdit":true,"notifications":{"commands":["refresh"]}},"editor":{"paneConfig":{"cssClass":null,"width":"500px","height":"500px"},"useWindow":true}}', N'{"builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[],"cssClass":"nopad"}', N'{}', NULL, NULL, NULL, N'Displays analysis results as a regular table', N'xxx', NULL, NULL, CAST(0x0000A18E007DDB88 AS DateTime), NULL, NULL, N'Sample Data Analysis', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [DashletModule] ([id], [path], [title], [config], [paneConfig], [dashletConfig], [style], [cls], [attr], [description], [createdBy], [modifiedBy], [sharedBy], [created], [modified], [shared], [groupName], [userData], [viewOrder], [groupOrder], [UserProperty1], [UserProperty2], [UserProperty3]) VALUES (251, N'jdash/dashlets/dataanalysis/chartdashlet', N'Chart View', N'{"wfConfig":{"uc":"~/Jdash/dashlets/DataAnalysis/chartview.ascx","ec":"~/Jdash/dashlets/DataAnalysis/chartviewEditor.ascx","autoEdit":true,"notifications":{"commands":["refresh"]}},"editor":{"paneConfig":{"cssClass":null,"width":"500px","height":"500px"},"useWindow":true}}', N'{"builtInCommands":["maximize","restore","remove","refresh"],"customCommands":[],"cssClass":"nopad"}', N'{}', NULL, NULL, NULL, N'Visualize your data by charts', N'xxx', NULL, NULL, CAST(0x0000A18D01649208 AS DateTime), NULL, NULL, N'Sample Data Analysis', NULL, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [DashletModule] OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Dashboard]    Script Date: 23.12.2013 09:21:41 ******/
CREATE NONCLUSTERED INDEX [IX_Dashboard] ON [Dashboard]
(
	[UserProperty1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Dashboard_1]    Script Date: 23.12.2013 09:21:41 ******/
CREATE NONCLUSTERED INDEX [IX_Dashboard_1] ON [Dashboard]
(
	[UserProperty2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Dashboard_2]    Script Date: 23.12.2013 09:21:41 ******/
CREATE NONCLUSTERED INDEX [IX_Dashboard_2] ON [Dashboard]
(
	[UserProperty3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Dashlet]    Script Date: 23.12.2013 09:21:41 ******/
CREATE NONCLUSTERED INDEX [IX_Dashlet] ON [Dashlet]
(
	[UserProperty1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Dashlet_1]    Script Date: 23.12.2013 09:21:41 ******/
CREATE NONCLUSTERED INDEX [IX_Dashlet_1] ON [Dashlet]
(
	[UserProperty2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Dashlet_2]    Script Date: 23.12.2013 09:21:41 ******/
CREATE NONCLUSTERED INDEX [IX_Dashlet_2] ON [Dashlet]
(
	[UserProperty3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DashletModule]    Script Date: 23.12.2013 09:21:41 ******/
CREATE NONCLUSTERED INDEX [IX_DashletModule] ON [DashletModule]
(
	[UserProperty1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DashletModule_1]    Script Date: 23.12.2013 09:21:41 ******/
CREATE NONCLUSTERED INDEX [IX_DashletModule_1] ON [DashletModule]
(
	[UserProperty2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DashletModule_2]    Script Date: 23.12.2013 09:21:41 ******/
CREATE NONCLUSTERED INDEX [IX_DashletModule_2] ON [DashletModule]
(
	[UserProperty3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_EntityAuth]    Script Date: 23.12.2013 09:21:41 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_EntityAuth] ON [EntityAuth]
(
	[entityType] ASC,
	[entityId] ASC,
	[roleOrUser] ASC,
	[authType] ASC,
	[permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [Dashlet]  WITH CHECK ADD  CONSTRAINT [FK_Dashlets_Dashboard] FOREIGN KEY([dashboardId])
REFERENCES [Dashboard] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Dashlet] CHECK CONSTRAINT [FK_Dashlets_Dashboard]
GO
ALTER TABLE [Dashlet]  WITH CHECK ADD  CONSTRAINT [FK_Dashlets_DashletModules] FOREIGN KEY([dashletModuleId])
REFERENCES [DashletModule] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Dashlet] CHECK CONSTRAINT [FK_Dashlets_DashletModules]
GO
ALTER TABLE [TagRelation]  WITH NOCHECK ADD  CONSTRAINT [FK_TagRelation_Dashboard] FOREIGN KEY([controlId])
REFERENCES [Dashboard] ([id])
GO
ALTER TABLE [TagRelation] NOCHECK CONSTRAINT [FK_TagRelation_Dashboard]
GO
ALTER TABLE [TagRelation]  WITH NOCHECK ADD  CONSTRAINT [FK_TagRelation_DashletModule] FOREIGN KEY([controlId])
REFERENCES [DashletModule] ([id])
GO
ALTER TABLE [TagRelation] NOCHECK CONSTRAINT [FK_TagRelation_DashletModule]
GO
ALTER TABLE [TagRelation]  WITH NOCHECK ADD  CONSTRAINT [FK_TagRelation_Dashlets] FOREIGN KEY([controlId])
REFERENCES [Dashlet] ([id])
GO
ALTER TABLE [TagRelation] NOCHECK CONSTRAINT [FK_TagRelation_Dashlets]
GO
ALTER TABLE [TagRelation]  WITH CHECK ADD  CONSTRAINT [FK_TagRelation_Tags] FOREIGN KEY([tagId])
REFERENCES [Tag] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [TagRelation] CHECK CONSTRAINT [FK_TagRelation_Tags]
GO
