<%@ Page Title="" Language="C#" MasterPageFile="~/Official.Master" AutoEventWireup="true" CodeBehind="Definitions.aspx.cs" Inherits="JDash.WebForms.Official.Definitions" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="container" id="contact">
     <h1>Glossary of Asp.Net Dashboard Toolkit - JDash.Net</h1>
    <table class="table table-hover">
        <thead>
            <tr>
                <td>Term</td>
                <td>Definition</td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Dashboard</td>
                <td>Dashboards often provide at-a-glance views of KPIs (key performance indicators)
                    relevant to a particular objective or business process (e.g. sales, marketing,
                    human resources, or production).[1] The term dashboard originates from
                    the automobile dashboard where drivers monitor the major functions at a
                    glance. Dashboards give signs about a business letting you know something
                    is wrong or something is right.
                    <br />
                    <br />Dashboard contains one Layout and optional dashlets. Dashboard is responsible
                    to manage lifecycle of layout and dashlets inside layout.</td>
            </tr>
            <tr>
                <td>Layout</td>
                <td>Layout is the main container for dashlets and is located inside a dashboard.
                    Layout is responsible positioning and drag-drop of dashlets.</td>
            </tr>
            <tr>
                <td>Dashlet Module/Widget Module</td>
                <td>Dashlet module defines a type which includes Asp.Net user control path,
                    title, description and optional initialization data for a dashlet.</td>
            </tr>
            <tr>
                <td>Dashlet/Widget</td>
                <td>Dashlet is an instance of dashlet module. It inherits properties and behavior
                    from dashlet module.</td>
            </tr>
            <tr>
                <td>Dashlet Editor</td>
                <td>Dashlet editor is the Asp.Net user control which provides a user interface
                    for configuration of a dashlet by end user.</td>
            </tr>
            <tr>
                <td>Metadata</td>
                <td>Metadata contains data structures for dashboards, dashlet modules and
                    dashlets.</td>
            </tr>
            <tr>
                <td>Provider</td>
                <td>Provider is responsible to provide metadata to JDash.Net framework. JDash.Net
                    is database independent and it is provider’s responsibility to store and
                    retrieve metadata.</td>
            </tr>
        </tbody>
    </table>
</div>
</asp:Content>
