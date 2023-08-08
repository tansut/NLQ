<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="georaphyviewEditor.ascx.cs" Inherits="Kalitte.Kalkinma.Dashboard.jdash.Dashlets.Dataanalysis.georaphyviewEditor" %>
<div class="form">
    <div class="item">
        <span>
            <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:Global, Title%>"></asp:Literal></span>
        <jdash:DashletTitleEditor ID="ctlTitle" runat="server"></jdash:DashletTitleEditor>
    </div>

    <div class="itemGroup">
        <div class="item">
            <span>
                <asp:Literal ID="Literal2" runat="server" Text="<%$ Resources:Global, Style%>"></asp:Literal></span>
            <jdash:DashletStylesList ID="ctlStyle" runat="server"></jdash:DashletStylesList>
        </div>
        <div class="item" style="float: right">
            <span>
                <asp:Literal ID="Literal3" runat="server" Text="<%$ Resources:Global, CssClass%>"></asp:Literal></span>
            <jdash:DashletCssEditor ID="ctlCss" runat="server"></jdash:DashletCssEditor>
        </div>

    </div>
            <div class="caption">
            <b>
                <asp:Label ID="ctlStepCaption" runat="server" Text="<%$ Resources:Global, ChartDataDashletStep1%>"></asp:Label></b>
        </div>
    <div class="wizard">
        <asp:Panel runat="server" Visible="true" ID="ctlStep1" class="item steps">
            <div class="itemGroup">
                <div class="">
                    <span>
                        <asp:Literal ID="Literal4" runat="server" Text="<%$ Resources:Global, SelectCube%>"></asp:Literal></span>
                    <asp:DropDownList runat="server" ID="ctlCube" DataTextField="Caption" DataValueField="Name" AutoPostBack="True" CssClass="cubecombo"></asp:DropDownList>
                </div>

            </div>
            <div class="alert alert-success">
                <asp:Literal ID="Literal20" runat="server" Text="<%$ Resources:Global, ChartDataDashletStep1Desc%>"></asp:Literal>
            </div>
        </asp:Panel>
        <asp:Panel runat="server" Visible="false" ID="ctlStep2" class="item steps">
            <div class="item">
                <span>
                    <asp:Literal ID="Literal8" runat="server" Text="<%$ Resources:Global, SelectMetric%>"></asp:Literal></span>
                <asp:DropDownList runat="server" ID="ctlFirstMetric" DataTextField="Caption" DataValueField="Name" AutoPostBack="True"></asp:DropDownList>

            </div>
            <div class="alert alert-success">
                <asp:Literal ID="Literal17" runat="server" Text="<%$ Resources:Global, ChartDataDashletStep2Desc%>"></asp:Literal>
            </div>
        </asp:Panel>
        <asp:Panel runat="server" Visible="false" ID="ctlStep3" class="item steps">
            <div class="item">
                <span>
                    <asp:Literal ID="Literal13" runat="server" Text="<%$ Resources:Global, SelectDimensions%>"></asp:Literal></span>
            </div>
                <div class="item">
                    <span>
                        <asp:Literal ID="Literal5" runat="server" Text="<%$ Resources:Global, FirstDimension%>"></asp:Literal></span>
                    <asp:DropDownList runat="server" ID="ctlFirstDimension" DataTextField="Caption" DataValueField="Name" AutoPostBack="True"></asp:DropDownList>
                </div>
                <div class="item">
                    <span>
                        <asp:Literal ID="Literal14" runat="server" Text="<%$ Resources:Global, PivotData%>"></asp:Literal></span>
                    <asp:DropDownList runat="server" ID="ctlPivotDimension" DataTextField="Caption" DataValueField="Name" AutoPostBack="True"></asp:DropDownList>
                </div>

            <div class="alert alert-success">
                <asp:Literal ID="Literal15" runat="server" Text="<%$ Resources:Global, ChartDataDashletStep3Desc%>"></asp:Literal>
            </div>
        </asp:Panel>
        <asp:Panel runat="server" Visible="false" ID="ctlStep4" class="item steps">
            <div class="item">
                <span>
                    <asp:Literal ID="Literal9" runat="server" Text="<%$ Resources:Global, HeaderText%>"></asp:Literal></span>
                <asp:TextBox runat="server" ID="ctlHeader" CssClass="textbox-fullwidth"></asp:TextBox>
            </div>
          
            <div class="alert alert-success">
                <asp:Literal ID="Literal19" runat="server" Text="<%$ Resources:Global, ChartDataDashletStep5Desc%>"></asp:Literal>
            </div>
        </asp:Panel>
    </div>
    <div class="wizardPager">
        <div class="stepCounter">
            <asp:Button ID="ctlPrevButton" Style="visibility: hidden" runat="server" Text="<%$ Resources:Global, PreviousStep%>" OnClick="ctlPrevButton_Click" CssClass="pagerbtn pagerprevious" />
            <asp:Label ID="ctlStepCounter" Text="1 / 4" runat="server" CssClass="pagenumber"></asp:Label>
            <asp:Button ID="ctlNextButton" runat="server" Text="<%$ Resources:Global, NextStep%>" OnClick="ctlNextButton_Click" CssClass="pagerbtn pagernext" />
        </div>
    </div>
</div>
