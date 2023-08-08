<%@ Page Title="" Language="C#" MasterPageFile="Official.Master" AutoEventWireup="true" CodeBehind="download.aspx.cs" Inherits="JDash.WebForms.Official.Official.download" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="container" id="download">
     <h1 id="mainH1" class="dark-blue">Download JDash.NET</h1>
    <div class="download-table-container">
        <table>
            <thead></thead>
            <tbody>
                <tr>
                    <th colspan="2"> <a class="btn btn-success btn-lg btn-download" href="startdownload.aspx">

                               <i class="glyphicon glyphicon-download"></i> Start Download</a>
                    </th>
                </tr>
                <tr>
                    <td class="left-cell"><strong>Version</strong>
                    </td>
                    <td>4.2</td>
                </tr>
                <tr class="grey">
                    <td class="left-cell"><strong>Release Date</strong>
                    </td>
                    <td>2013-12-27</td>
                </tr>
                <tr>
                    <td class="left-cell"><strong>Framework</strong>
                    </td>
                    <td>.NET 4.0+</td>
                </tr>
                <tr class="grey">
                    <td class="left-cell"><strong>CPU</strong>
                    </td>
                    <td>32 &amp; 64 Bit</td>
                </tr>
                <tr>
                    <td class="left-cell"><strong>Additional</strong>
                    </td>
                    <td class="download-additional"><a target="_blank" href="/docs/StandartLicense.pdf">License</a> 
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="download-info">
         <h1>Download Information</h1>
         <h3>Trial License

            </h3>
        <p>Without payment of a fee whatsoever, in consideration for the mutual covenants
            contained herein, we grant you a non-transferable and non-exclusive license
            to install and use the Software on an unlimited number of developer workstations
            within your organization for the purposes of evaluation and testing when
            accessed by http://localhost or http://127.0.0.1 local address. For any
            locations other than http://localhost or http://127.0.0.1 the Software
            will display the message, ‘This Software is Unlicensed’ with a ‘Buy License’
            link. If you wish to remove this message you are required to purchase a
            Developer, Team, Workgroup or Enterprise License; otherwise you must leave
            this message intact and not attempt to modify it in any way.</p>
         <h3>Open Source Asp.Net Dashboard Demo application

            </h3>
        <p>Source code of demo web site and dashlet library is included with the
            download package. Demo web site also includes 3rd party libraries.</p>
         <h3>About 3rd party libraries inside Demo 

            </h3>
        <p>3rd party libraries are not part of JDash.Net and they are used for demo
            application for only demonstration purposes. JDash.Net license doesnot
            grant you to use or distribute them with your application. Please read
            license terms of each 3rd library or product for using or distributing
            them.</p>
         <h3>About Kalitte</h3>
        <p>JDash.Net is developed using Asp.Net and Microsoft Visual Studio.</p>
        <p>As a Gold Partner of Microsoft Corporation, Kalitte has all permissions
            to use Microsoft Visual Studio.Net, C# and other developer tools to design,
            develop and deploy JDash.Net.</p>
         <h3>Uninstall Information

            </h3>
        <p>Setup is distributed as a regular Windows Installer Package. To uninstall
            JDash.Net, goto Control Panel - Programs and Features. Locate JDash.Net
            and click uninstall button.</p>
    </div>
</div>

</asp:Content>
