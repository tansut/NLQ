*****************************************
CONFIGURE YOUR DATABASE (10 seconds)
*****************************************
--------------------------------------------------------------------------
To use Microsoft SQL Server
--------------------------------------------------------------------------
1. Scripts can be found at /Scripts/SqlServer.sql file inside this web application.
   Open this file and execute it on your SQL Server database.
2. Configure connection string named SqlConstr inside web.config. 
3. Close this window, return to Vs.Net. Restart web app.

--------------------------------------------------------------------------
To use MySQL 
--------------------------------------------------------------------------

1. To use MySQL, MySQL .Net connector must be installed. If not, MySQL .Net Connector can be download from http://dev.mysql.com/downloads/connector/net/
   If the connector is already installed, please skip this step.
2. Scripts can be found at /Scripts/MySql.sql file inside this web application.
   Open this file and execute it on your MySQL database.
3. Configure connection string named SqlConstr inside web.config. 
4. Close this window, return to Vs.Net. Restart web app.

--------------------------------------------------------------------------
Installing JDash.Net components into VS.NET Toolbox
--------------------------------------------------------------------------

The following steps are required to manually install the controls into 
your Visual Studio or Visual Web Developer Express Toolbox. 
		
	1.  Open Visual Studio or Visual Web Developer Express.

	2.  Open an existing web site or create a new web site project.
	
	3.  Open or create a new .aspx page.

	4.  Open the ToolBox panel, typically located on the left side in a 
	    fly-out panel (Ctrl + Alt + x).

	5.  Create a new "JDash.Net" Tab, by...
		  a. Right-Click in the ToolBox area.
		  b. Select "Add Tab".
		  c. Enter "JDash.Net".

	6.  Inside the "JDash.Net" tab, Right-Click and select 
	    "Choose Items...".

	7.  Under the ".NET Framework Components" Tab select the "Browse" 
	    button.

	8.  Navigate to and select the JDash.WebForms.dll file, choose open.
			
          NOTE: If the automatic installer has been run previously, the 
                JDash.WebForms.dll can typically be found in the 
                following location:

                C:\Program Files\Kalitte\JDash\Bin or
				C:\Program Files (x86)\Kalitte\JDash\Bin 


--------------------------------------------------------------------------
Release Notes V4.2
--------------------------------------------------------------------------

	1.  Dashlet inheritance supported. You can define a base class for your dashlets and implement common methods inside your base class.
	2.  Locating JEventHandler methods uses an internal cache for improving performance.
	3.  HtmlEncoding of dashlet titles fixed.
	4.  New theme (flat) designed.
	5.  JDash.Net now supports custom themes.
	6.  Some visual improvements for dashlets done.
	7.  Bootstrap 3.x upgrade completed.
	8.  Changing a theme adds new css classes to document body. This allows you to change all document styles for a theme change.
	9.  IE11 drag-drop supported.

Breaking Changes

   None.

--------------------------------------------------------------------------
Release Notes V4.1
--------------------------------------------------------------------------

	1.	Simple Analytics library integrated into demo application.
	2.	Licensing problems resolved.
	3.	Many bug fixes.
	4.	Added user configurable properties for dashboard, dashlet and dashlet modules. See breaking changes.

Breaking Changes

	1.	Execute following script to create user configurable columns for tables Dashboard, Dashlet and DashletModule for MS SQL and MySQL 

		alter table Dashboard Add UserProperty1 nvarchar(250);
		alter table Dashboard Add UserProperty2 nvarchar(250);
		alter table Dashboard Add UserProperty3 nvarchar(250);
		alter table Dashlet Add UserProperty1 nvarchar(250);
		alter table Dashlet Add UserProperty2 nvarchar(250);
		alter table Dashlet Add UserProperty3 nvarchar(250);
		alter table DashletModule Add UserProperty1 nvarchar(250);
		alter table DashletModule Add UserProperty2 nvarchar(250);
		alter table DashletModule Add UserProperty3 nvarchar(250);
	