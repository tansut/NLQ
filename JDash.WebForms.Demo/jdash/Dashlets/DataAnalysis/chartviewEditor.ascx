<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="chartviewEditor.ascx.cs" Inherits="JDash.WebForms.Demo.JDash.Dashlets.DataAnalysis.chartviewEditor" %>
<%@ Register Assembly="JDash.WebForms" Namespace="JDash.WebForms" TagPrefix="jdash" %>
<link href="/jdash/dashlets/Dataanalysis/Resource/DataAnalysisStyles.css" rel="stylesheet" />
<div class="form">
    <div class="item">
        <span>
            <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:Global, Title%>"></asp:Literal></span>
        <jdash:DashletTitleEditor CssClass="form-control" ID="ctlTitle" runat="server"></jdash:DashletTitleEditor>
    </div>

    <div class="itemGroup">
        <%--  <div class="item">
            <span>
                <asp:Literal ID="Literal2" runat="server" Text="<%$ Resources:Global, Style%>"></asp:Literal></span>
            <jdash:DashletStylesList ID="ctlStyle" runat="server"></jdash:DashletStylesList>
        </div>
        <div class="item" style="float: right">
            <span>
                <asp:Literal ID="Literal3" runat="server" Text="<%$ Resources:Global, CssClass%>"></asp:Literal></span>
            <jdash:DashletCssEditor CssClass="form-control" ID="ctlCss" runat="server"></jdash:DashletCssEditor>
        </div>--%>
        <div class="caption">
            <b>
                <asp:Label ID="ctlStepCaption" runat="server" Text="Data Source"></asp:Label></b>
        </div>
    </div>

    <div class="wizard">
        <asp:Panel runat="server" Visible="true" ID="ctlStep0" class="item steps">
            <div>
                <div  class="ctlSQLContainer hot handsontable htRowHeaders htColumnHeaders"></div>
                <asp:HiddenField ID="ctlSQL"  runat="server"></asp:HiddenField>

            </div>
        </asp:Panel>
        <asp:Panel runat="server" Visible="false" ID="ctlStep1" class="item steps">
            <div>
                <asp:TextBox ID="ctl_Txt_QueryText" runat="server" Font-Names="Courier New" TextMode="MultiLine" Rows="5">
                </asp:TextBox>
            </div>
        </asp:Panel>
    </div>
    <div class="wizardPager">
        <div class="stepCounter">
            <asp:Button ID="ctlPrevButton" Style="visibility: hidden" runat="server" Text="<%$ Resources:Global, PreviousStep%>" OnClick="ctlPrevButton_Click" CssClass="pagerbtn pagerprevious" />
            <asp:Label ID="ctlStepCounter" Text="1 / 2" runat="server" CssClass="pagenumber"></asp:Label>
            <asp:Button ID="ctlNextButton" runat="server" Text="<%$ Resources:Global, NextStep%>" OnClick="ctlNextButton_Click" CssClass="pagerbtn pagernext" />
        </div>
    </div>
    <script>
        $(document).ready(function () {

            alert('');

        })
    </script>
</div>
