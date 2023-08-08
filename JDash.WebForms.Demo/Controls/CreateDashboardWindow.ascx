<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CreateDashboardWindow.ascx.cs" Inherits="JDash.WebForms.Demo.Controls.UI.Commons.CreateDashboardWindow" %>
<script type="text/javascript">

    function selectLayout(node, id) {
        var hidden = document.getElementById('<%= ctlLayoutId.ClientID%>');
        hidden.value = id;
        $(".d-layout-predefined").removeClass("selected");
        $(node).addClass("selected");
    }

    function showDashboardError(message) {
        var messageControl = document.getElementById("cdw_ctlErrorAlertMessage");
        messageControl.innerHTML = message;
        $("#cdw_ctlErrorAlert").removeClass('hide');
    }

    function showCreateDashboardControl() {
        $("#ctlCreateDashboardModal").modal();

    }

    function hideCreateDashboardControl() {
        $("#ctlCreateDashboardModal").modal('hide');
    }

    function validateDashboardForm() {
        var title = document.getElementById('<%= ctlDashboardTitle.ClientID%>');
        var description = document.getElementById('<%= ctlDashboardDescription.ClientID%>');
        var hidden = document.getElementById('<%= ctlLayoutId.ClientID%>');

        if (title.value == "") {
            showDashboardError("Not optional: title");
            return false;
        }
        return true;
    }


    function toggleGroups(groupCB) {
        if (groupCB) {
            $('#ctlGroupBox').hide();
            $('#ctlCustomGroupBox').show();

        } else {
            $('#ctlGroupBox').show();
            $('#ctlCustomGroupBox').hide();
        }
    }

</script>
<asp:UpdatePanel ID="ctlModalUpdatePanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
    <ContentTemplate>
        <asp:HiddenField ID="ctlLayoutId" runat="server" />
        <div id="ctlCreateDashboardModal" class="modal fade dashboardForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3 id="myModalLabel">
                            <asp:Literal runat="server" ID="ctlModelTitle" Text="Set dashboard properties" /></h3>
                    </div>

                    <div class="modal-body">
                        <div class="form-vertical form">
                            <div class="alert alert-danger hide" id="cdw_ctlErrorAlert" style="margin-bottom: 0px; clear: both;">
                                <div id="cdw_ctlErrorAlertMessage"></div>
                            </div>
                            <div class="control-group item">
                                <label class="control-label " for="ctlDashboardTitle">
                                    <asp:Literal runat="server" ID="ctlDashboardLabel" Text="Title" /></label>
                                <div class="controls">
                                    <jdemo:BsTextBox runat="server" ID="ctlDashboardTitle" Info="Set a title for your dashboard" CssClass="form-control"></jdemo:BsTextBox>
                                </div>
                            </div>

                            <div class="control-group item">
                                <label class="control-label" for="ctlDashboardDescription">
                                    <asp:Literal runat="server" ID="Literal2" Text="Select a layout:" /></label>
                                <div class="controls">
                                    <asp:Repeater runat="server" ID="preLayoutsRep">
                                        <ItemTemplate>
                                            <div class='d-layout-predefined d-layout-predefined<%# Eval("Key") %>' onclick='javascript:selectLayout(this,"<%# Eval("Key") %>")'></div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                <div style="clear: both"></div>
                            </div>

                            <div id="ctlGroupBox" class="control-group item">
                                <label class="control-label" for="ctlDashboardTitle">
                                    <asp:Literal runat="server" ID="Literal3" Text="Assign dashboard to an existing logical group (optional)" /></label>
                                <div class="controls">
                                    <jdemo:BsDropDown runat="server" ID="ctlGroups" CssClass="form-control"></jdemo:BsDropDown>
                                </div>
                            </div>
                            <div class="control-group item">
                                <div class="controls">
                                    <input type="checkbox" id="ctlUseCustomGroup" onchange="toggleGroups(this.checked)" runat="server" class="checkBox" />
                                    or create a new group
                                </div>
                            </div>
                            <div id="ctlCustomGroupBox" class="control-group item" style="display: none">
                                <label class="control-label" for="ctlDashboardTitle">
                                    <asp:Literal runat="server" ID="Literal4" Text="Group name" /></label>
                                <div class="controls">
                                    <jdemo:BsTextBox  CssClass="form-control" runat="server" Info="Set a group name for your dashboard" ID="ctlCustomGroup"></jdemo:BsTextBox>
                                </div>
                            </div>
                            <div class="control-group item">
                                <label class="control-label" for="ctlDashboardDescription">
                                    <asp:Literal runat="server" ID="Literal1" Text="Description" /></label>
                                <div class="controls">
                                    <jdemo:BsTextBox CssClass="form-control" runat="server" ID="ctlDashboardDescription" Info="Set a description (optional)" TextMode="MultiLine" Rows="3"></jdemo:BsTextBox>
                                </div>
                            </div>

                        </div>
                        <div>
                        </div>

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
                        <jdemo:BsButton ID="ctlSaveButton" runat="server" ButtonType="primary" ButtonSize="small" Text="Save" OnClientClick="return validateDashboardForm()" OnClick="ctlSaveButton_Click" />
                        <jdemo:BsButton ID="ctlCloseButton" runat="server" ButtonType="basic" ButtonSize="small" Text="Close" OnClientClick="javascript:hideCreateDashboardControl(); return false;" />
                    </div>
                </div>
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
