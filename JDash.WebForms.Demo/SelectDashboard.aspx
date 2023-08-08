<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectDashboard.aspx.cs" Inherits="JDash.WebForms.Demo.SelectDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h2>Select a dashboard to create visualization</h2>
    <asp:Repeater runat="server" id="listRepeater" OnItemCommand="listRepeater_ItemCommand"> 
       <ItemTemplate> 
          <asp:LinkButton ID="HyperLink1" runat="server"  Text='<%# Eval("title") %>' CommandName="go" CommandArgument='<%# string.Format("{0}", Eval("Id")) %>'></asp:LinkButton> <br /> 
       </ItemTemplate> 
    </asp:Repeater> 
    </div>
    </form>
</body>
</html>
