<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Edit.ascx.cs" Inherits="JDash.WebForms.Demo.JDash.Dashlets.Kendo.Edit" %>
<%@ Register Assembly="JDash.WebForms" Namespace="JDash.WebForms" TagPrefix="jdash" %>

<style>

</style>
<div class="form">
    <div class="item">
        <span>
            <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:Global, Title%>"></asp:Literal></span>
        <jdash:DashletTitleEditor CssClass="form-control"  ID="ctlTitle" runat="server"></jdash:DashletTitleEditor>
    </div>

    <div class="itemGroup">
        <div class="item">
            <span>
                <asp:Literal ID="Literal2" runat="server" Text="<%$ Resources:Global, Style%>"></asp:Literal></span>
            <jdash:DashletStylesList ID="ctlStyle" runat="server"></jdash:DashletStylesList>
        </div>
        <div class="item">
            <span>
                <asp:Literal ID="Literal3" runat="server" Text="<%$ Resources:Global, CssClass%>"></asp:Literal></span>
            <jdash:DashletCssEditor CssClass="form-control" ID="ctlCss" runat="server"></jdash:DashletCssEditor>
        </div>
    </div>
<div class="itemGroup">
    <div class="item">
        <span>
            <asp:Literal ID="Literal4" runat="server" Text="<%$ Resources:Global, Presets%>"></asp:Literal></span>
        <asp:DropDownList CssClass="form-control" ID="ctlPresets" runat="server">

            <asp:ListItem Text="Pie" Value="pie" />
            <asp:ListItem Text="Line" Value="line" />
            <asp:ListItem Text="Bar" Value="bar" />
        </asp:DropDownList>
    </div>

            <div class="item">
            <span>
                <asp:Literal ID="Literal12" runat="server" Text="<%$ Resources:Global, ChartTheme%>"></asp:Literal></span>
            <asp:DropDownList CssClass="form-control" runat="server" DataTextField="Value" DataValueField="Key" ID="ctlTheme" ></asp:DropDownList>

        </div>
</div>

</div>
