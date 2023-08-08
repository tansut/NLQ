<%@ Page Title="" Language="C#" MasterPageFile="~/Official.Master" AutoEventWireup="true" CodeBehind="Purchase.aspx.cs" Inherits="JDash.WebForms.Official.Purchase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        
    </script>
    <div class="container" id="purchase">
        <h1 id="mainH1" class="dark-blue">Purchase JDash.NET for Asp.Net</h1>
        <div class="purchase-table-container">
            <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Repeater OnItemDataBound="ctlLicenseRep_ItemDataBound" runat="server" ID="ctlLicenseRep">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table>
                                <thead>
                                    <tr>
                                        <th><%# Eval("Model") %></th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <tr class="grey">
                                        <td><strong><%# Eval("Title") %></strong></td>
                                    </tr>
                                    <tr style="height:90px;">
                                        <td><%# Eval("SubsDesc") %></td>
                                    </tr>
                                    <tr class="grey">
                                        <td class="price"><%# Eval("TotalPrice") %>$</td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <a runat="server" id="byLink" class="btn btn-purchase btn-success bigbutton"  href='<%# Eval("TotalLink") %>'>
                                                <span><%# Eval("BuyNow") %></span></a>
                                        </th>
                                    </tr>
                                    <tr class="grey" style='<%# SeperatedPurchase ? "": "display:none" %>'>
                                        <td>License Price</td>
                                    </tr>
                                    <tr style='<%# SeperatedPurchase ? "": "display:none" %>'>
                                        <td class="price"><%# Eval("LicensePrice") %>$</td>
                                    </tr>
                                    <tr class="grey" style='<%# SeperatedPurchase ? "": "display:none" %>'>
                                        <th class="center">
                                            <a runat="server" id="byLicenseLink" class="btn btn-purchase btn bigbutton"  href='<%# Eval("LicenseLink") %>'>
                                                <span><%# Eval("BuyNow") %></span></a>
                                        </th>
                                    </tr>

                                    <tr class="grey" style='<%# SeperatedPurchase ? "": "display:none" %>'>
                                        <td>1 Year Premium Support Price</td>
                                    </tr>
                                    <tr style='<%# SeperatedPurchase ? "": "display:none" %>'>
                                        <td class="price"><%# Eval("SupportPrice") %>$</td>
                                    </tr>

                                </tbody>
                            </table>
                        </ItemTemplate>
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:Repeater>

                    <div>
                    
                        <div class="checkbox inline" style="clear: both">
                            <asp:CheckBox AutoPostBack="true" OnCheckedChanged="ctlSeperate_CheckedChanged" Text="Seperate license and subscription prices" ID="ctlSeperate" runat="server" />
                        </div>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <div class="purchase-info">
            <h1>Licensing Overview and FAQ</h1>
            <h3 class="dark-blue">Developer License
            </h3>
            <p>
                License allows JDash.Net to be used with an unlimited number of SaaS projects and web applications for you or your customers. If you're setting up sites and web applications for a client as a SaaS or a contract job, you are allowed to do this under the Developer type licenses.
            </p>
            <p>
                Each individual who uses JDash.Net for development purposes must obtain a license to do so. A developer is individual working directly with JDash.Net in an IDE (such as Visual Studio, Visual Web Developer Express or similar) is considered a developer. Each developer is granted the right to install and use JDash.Net on his workstation used by that developer for development purposes.
            </p>
            <h3>OEM License</h3>
            <p>License allows you to embed JDash.Net into your software or hardware product to be installed on client hardware. Choose this model if you have a product which you sell to different customers, install your product to client hardware and want to embed JDash.Net into your product.</p>
            <h3>Company License</h3>
            <p>
                License allows JDash.Net to be used with an unlimited number of SaaS projects, web applications, embedding JDash.Net into your all software and hardware products. You also get source code of JDash.Net with this licensing model. 
            </p>

            <p>
                <a target="_blank" href="/docs/StandartLicense.pdf">Click</a> to view JDash.Net License Agreement
            </p>
            <h1>Premium Support</h1>
            <p>
                Premium Support includes following features;
            </p>
            <ul>
                <li>Maximum initial response time of 24 hours</li>
                <li>Free upgrades to next major/minor release within 12 months (2.x -> 3.x)</li>
                <li>Premium Help forum support account</li>
                <li>Emergency bug fixes</li>
                <li>Priority access to next release before public</li>
                <li>24 hour a day forum monitoring</li>
                <li>Max Initial response time of 24 hours</li>
            </ul>
        </div>
    </div>
</asp:Content>

