<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GenerateSQL.aspx.cs" Inherits="JDash.WebForms.Demo.GenerateSQL" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:TextBox ID="ctlSQL" runat="server" Font-Names="Courier New" Height="406px" TextMode="MultiLine" Width="792px"><%--select [Customer Segment], Region, count(*) from Orders
Group By [Customer Segment], Region --%>
                
SELECT top 5000 e.ID,e.SourceName,e.DestName,e.SourceRegionName,e.SourceRegionPath,e.Commodity,e.Price,e.Quantity,TIME_POINT.TIME_POINT as Time, SUB_TIME_POINT.SUB_TIME_POINT as Subtime FROM
(SELECT d.ID,d.SourceName,d.DestName,d.SourceRegionName,d.SourceRegionPath,COMMODITY.NAME as Commodity,d.Price,d.Quantity,d.TimeID, d.SubtimeID FROM
(SELECT LINK_DATA.ID as ID, c.SourceName,c.DestName,c.SourceRegionName,c.SourceRegionPath,c.Commodity_ID,LINK_DATA.PRICE as Price,LINK_DATA.QUANTITY as Quantity, LINK_DATA.TIME_POINT_ID as TimeID, LINK_DATA.SUB_TIME_POINT_ID as SubtimeID FROM
(SELECT b.ID, b.SourceName, b.DestName, REGION.Name as SourceRegionName, REGION.Path as SourceRegionPath, b.Commodity_ID FROM
(SELECT a.ID, a.SourceName, ACTIVITY.NAME AS DestName,A.SourceRegion, a.COMMODITY_ID FROM
(SELECT LINK.ID,ACTIVITY.NAME as SourceName,ACTIVITY.[REGION_ID] as SourceRegion,LINK.[DESTINATION_ACTIVITY_ID],LINK.[COMMODITY_ID] FROM
LINK LEFT JOIN ACTIVITY ON SOURCE_ACTIVITY_ID = ACTIVITY.ID) a
LEFT JOIN ACTIVITY ON a.DESTINATION_ACTIVITY_ID=ACTIVITY.ID) b
LEFT JOIN REGION ON b.SourceRegion = Region.ID) c
RIGHT JOIN LINK_DATA ON c.ID = LINK_DATA.LINK_ID) d
LEFT JOIN COMMODITY ON d.COMMODITY_ID=Commodity.ID) e
LEFT JOIN TIME_POINT ON e.TimeID=TIME_POINT.ID LEFT JOIN SUB_TIME_POINT ON e.SubtimeID=SUB_TIME_POINT.ID</asp:TextBox>

        </div>
        <asp:Button runat="server" ID="ctlExecute" Text="Execute" OnClick="ctlExecute_Click" />
        <asp:GridView runat="server" ID="grid" AllowPaging="True" AllowSorting="True"></asp:GridView>
        <asp:Button ID="ctlModelData" runat="server" OnClick="ctlModelData_Click" Text="Model Data" />
    </form>
</body>
</html>
