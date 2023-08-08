<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CreateDashletWindow.ascx.cs" Inherits="JDash.WebForms.Demo.Controls.UI.Commons.CreateDashletWindow" %>

<script type="text/javascript">


    function showCreateDashletControl() {
        $("#ctlCreateDashletModal").modal();

    }

    function hideCreateDashletControl() {
        $("#ctlCreateDashletModal").modal('hide');
    }



</script>
<asp:UpdatePanel ID="ctlModalUpdatePanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
    <ContentTemplate>
        <div id="ctlCreateDashletModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabelcd" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3 id="myModalLabelcd">
                            <asp:Literal runat="server" ID="ctlModelTitle" Text="Add new dashlets" /></h3>
                    </div>
                    <div class="modal-body">
                        <asp:Repeater runat="server" ID="ctlDashletGroupRepeater">
                            <HeaderTemplate>
                                <ul id="dashletGroupTab" class="nav nav-tabs groupTab">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <li class='<%# Container.ItemIndex == 0 ? "active" : string.Empty%>'><a href='<%# string.Format("#{0}",Container.DataItem == null ? "NullGroup": Container.DataItem.ToString().Replace(" ", "")) %>' data-toggle="tab"><span class="iconContainer <%# Container.DataItem.ToString().Replace(" ", "") %> "><div class='glyphicon glyphicon-bookmark'></div></span><%# Container.DataItem ==null ? "Others":Container.DataItem  %></a></li>
                            </ItemTemplate>
                            <FooterTemplate></ul></FooterTemplate>
                        </asp:Repeater>
                        <asp:Repeater runat="server" ID="ctlDashletGroupInnerRepeater">
                            <HeaderTemplate>
                                <div id="dashletGroupContent" class="tab-content">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div class='<%# Container.ItemIndex == 0 ? "tab-pane active" : "tab-pane"%>' id='<%# Container.DataItem == null ? "NullGroup": Container.DataItem.ToString().Replace(" ",string.Empty) %>'>
                                    <asp:Repeater runat="server" ID="ctlDashletItemRepeater" DataSource='<%# GetGroupDashlets(Container.DataItem.ToString()) %>' OnItemCommand="ctlDashletItemRepeater_ItemCommand">
                                        <HeaderTemplate>
                                            <ul class="nav nav-tabs nav-stacked">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <li>
                                                <div class="row" style="margin: 10px;">
                                                    <div class="pull-left">
                                                        <%# DataBinder.Eval(Container.DataItem,"title") %>
                                                    </div>
                                                    <div class="pull-right">
                                                        <asp:Button runat="server" Text="Add" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"id") %>' OnClientClick="hideCreateDashletControl();return true;" CssClass="btn btn-primary form-control"></asp:Button>
                                                    </div>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                        <FooterTemplate></ul></FooterTemplate>
                                    </asp:Repeater>
                                </div>
                            </ItemTemplate>
                            <FooterTemplate></div></FooterTemplate>
                        </asp:Repeater>
                    </div>
                    <div class="modal-footer">
                        <div style="float: left">
                            <asp:UpdateProgress ID="updProgress"
                                AssociatedUpdatePanelID="ctlModalUpdatePanel"
                                runat="server">
                                <ProgressTemplate>
                                    <img src="../../Resource/img/loading.gif" alt="" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </div>
                        <jdemo:BsButton ID="ctlCloseButton" runat="server" ButtonType="basic" ButtonSize="small" Text="Close" OnClientClick="hideCreateDashletControl(); return false;" />
                    </div>
                </div>
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
