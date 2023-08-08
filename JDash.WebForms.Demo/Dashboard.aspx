<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true"
    CodeBehind="Dashboard.aspx.cs"
    Inherits="JDash.WebForms.Demo.DashboardPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="JDash/Resource/JavaScript/kendo/2013.3.1119_css/kendo.common.min.css" type="text/css" />
    <link rel="stylesheet" href="JDash/Resource/JavaScript/kendo/2013.3.1119_css/kendo.blueopal.min.css" type="text/css" />
    <link rel="stylesheet" href="JDash/Resource/JavaScript/kendo/2013.3.1119_css/kendo.dataviz.min.css" type="text/css" />
    <link rel="stylesheet" href="JDash/Resource/JavaScript/kendo/2013.3.1119_css/kendo.dataviz.blueopal.min.css" type="text/css" />

    <script type="text/javascript" src="JDash/Resource/JavaScript/kendo/2013.3.1119_js/kendo.dataviz.min.js"></script>
    <link href="JDash/Resource/JavaScript/handsontable/handsontable.css" rel="stylesheet" />
    <script src="JDash/Resource/JavaScript/handsontable/handsontable.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageContent" runat="server">

    <jdash:DashboardView runat="server" ID="dashboard" />


</asp:Content>
