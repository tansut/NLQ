<%@ Page Title="" Language="C#" MasterPageFile="Official.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="JDash.WebForms.Official.Official.contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container" id="contact">
     <h1 id="mainH1" class="dark-blue">Contact Us</h1>
    <div>
        <div class="contact-left left">
            <div class="content">
                 <h4 class="dark-blue">Office Information</h4>
                <p>Kalitte Professional Information Technologies Ltd. Co.</p>
                <p>Middle East Tehnical University Technopolis Galyum Block K1 N19</p>
                <p><b>T : </b>+90 (312) 210 10 88</p>
                <p><b>F : </b>+90 (312) 210 10 89</p>
                <p><b>Ankara / TURKEY</b>
                </p>
            </div>
        </div>
        <div class="contact-middle left">
            <div class="content">
                 <h4 class="dark-blue">Hours of Operation</h4>
                <p>09:00 - 18:00 (GMT+3)</p>
                <p>Current Office DateTime:
                    <asp:literal id="officeTime" runat="server"></asp:literal>
                </p>
                 <h4 class="dark-blue" style="padding-top: 20px;">Official Websites</h4>
                <p>Company Website: <a href="http://www.kalitte.com.tr">www.kalitte.com.tr</a>
                </p>
                <p>Product Demo Website: <a href="demo">jdash.net/demo</a>
                </p>
            </div>
        </div>
        <div class="contact-right left">
            <div class="content">
                 <h4 class="dark-blue">Direct E-mail</h4>
                <p>Sales <a href="mailto: sales@jdash.net">sales@jdash.net</a>
                    <br />Support <a href="mailto: support@jdash.net">support@jdash.net</a>
                </p>
                 <h4 class="dark-blue" style="padding-top: 10px;">Online Technical Support</h4>
                <p><a target="_blank" href="http://forum.jdash.net/">Premium Support Subscription</a> 
                </p>
                <p><a target="_blank" href="http://forum.jdash.net/">Support Forum</a>
                </p>
            </div>
        </div>
    </div>
</div>

</asp:Content>
