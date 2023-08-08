<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditCube.aspx.cs" Inherits="JDash.WebForms.Demo.EditCube" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <link href="Resource/css/StyleSheet.css" rel="stylesheet" type="text/css" />
        <link href="Resource/css/DashboardQuery.css" rel="stylesheet" type="text/css" />
        <link href="Resource/css/cerulean.css" rel="stylesheet" type="text/css" />
    <title>MarketBuilder DashBoard</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class='wrap'>
     <div class="container-fluid">
     <div class="navbar navbar-inverse navbar-default radT" style='margin-bottom: -2px'>
                <!-- static navbar -->
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">
                        <img alt="MarketBuilder Logo" src='Resource/img/Icons/mpIcon.PNG' class='headerLogo nBreak img-responsive' />
                            MarketBuilder Dashboard
                    </a>
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="glyphicon glyphicon-user delGreen"></span>&nbsp;&nbsp;Welcome, User<b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Logout</a></li>
                            </ul>
                        </li>
                    </ul>
                    <!-- /navbar-right -->
                </div>
                <!-- /nav-collapse -->
            </div>
          <div class="col-md-12 spacer"></div>
    <div class="col-md-12 ">   
          <span class="IndexTitle text-left">Dimension & Measure</span>        
    </div>                

        <div class="col-md-12">
            <div class="form-inline">
                  <div class="form-group">
                    <label>Title: </label> &nbsp;&nbsp;
                    <asp:TextBox runat="server" CssClass="form-control" ID="ctlCubeCaption" />
                  </div>
                  <div class="form-group">
                    <label >Description : </label>
                     <asp:TextBox runat="server" ID="ctlDesc" CssClass="form-control" TextMode="MultiLine" Rows="1" /> 
                  </div>
                     <div class="col-md-12 spacer"></div>
                </div>
            <asp:Button ID="Button2" Text="Add To Dashboard" runat="server" CssClass="btn btn-default" OnClick="Button2_Click" />
            <div class="col-md-12 spacer"></div>
         </div>
          <div class="col-md-12 spacer"></div>
          <div class="col-md-12 spacer"></div>
        <div class="col-md-12">
            <asp:Repeater  runat="server" ID="cubeModelRepeater" OnItemDataBound="cubeModelRepeater_ItemDataBound" OnItemCommand="cubeModelRepeater_ItemCommand">
                <HeaderTemplate>
                </HeaderTemplate>
                <FooterTemplate>
                </FooterTemplate>
                <ItemTemplate>
                    <div class="col-md-2 form-group textbox-height" style="padding: 5px; border: 1px solid #CCCCCC; float: left;background-color: #EEEEEE; margin-right: 10px;">
                        <span>ID:</span>
                        <asp:Label Font-Bold="true" Text='<%# Eval("Name") %>' runat="server" ID="ctlName" /><br />
                        <asp:TextBox runat="server" ID="ctlCaption" Text='<%# Eval("Caption") %>' CssClass="form-control" Style="width: 95%;" />
                        <asp:RequiredFieldValidator ID="validator" Enabled="true" ValidationGroup="cubes" ControlToValidate="ctlCaption" Text="Required!" ClientIDMode="AutoID" runat="server" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />

                        <span>Dimension / Measure</span>
                        <asp:DropDownList runat="server"  CssClass="form-control" ID="ctlType" AutoPostBack="true" OnSelectedIndexChanged="ctlType_SelectedIndexChanged">
                            <asp:ListItem Text="Dimension" Value="Dimension" Selected="True" />
                            <asp:ListItem Text="Measure" Value="Measure" />
                        </asp:DropDownList>
                        <br />
                        <asp:Panel runat="server" ID="ctlMeasurePanel">
                            <span>Data Type</span>
                            <asp:DropDownList runat="server" ID="ctlDataType"  CssClass="form-control">
                            </asp:DropDownList>
                            <br />
                            <span>Format</span><br />
                            <asp:TextBox runat="server" ID="ctlFormat"  CssClass="form-control" Text='<%# Eval("Format") %>' Style="width: 95%;" />
                            <br />
                            <asp:Label Text="How to aggregate" runat="server" ID="ctlAggText" />
                            <asp:DropDownList runat="server" ID="ctlAgg"  CssClass="form-control">
                                <asp:ListItem Text="Sum" Value="Sum" />
                                <asp:ListItem Text="Average" Value="Avg" />
                                <asp:ListItem Text="Count" Value="Count" />
                            </asp:DropDownList>
                        </asp:Panel>
                        <br />
                        <asp:Button ID="BsButton1" CssClass="btn btn-link" Text="Remove" runat="server" CommandName="Delete" CommandArgument='<%# Eval("Name") %>' />
                    </div>

                </ItemTemplate>
            </asp:Repeater>
        </div>
         </div>
        </div>
         <div class="col-md-12 footer padT">
        <div class="col-md-6 nPadL nPadR">Copyright &copy; 2014 Deloitte Development LLC. All rights reserved..</div>
            <div class="col-md-6 nPadL nPadR text-right">
                 <a href="#">About</a> |<a href="#">Contact</a>|<a href="#">Help</a> 
            </div>
    </div>
    </form>
</body>
</html>
