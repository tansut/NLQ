debugger;
var rowCount = 300;
var columnCount = 40;
var myData = Handsontable.helper.createEmptySpreadsheetData(rowCount, columnCount),
  container = document.querySelector('.ctlSQLContainer')[0],
  hot;
var colWidths = [];
for (var i = 0; i < rowCount ; i++)
    colWidths.push(87);
hot = new Handsontable(container, {
    data: myData,
    colWidths: colWidths,
    rowHeaders: true,
    colHeaders: false,
    fixedRowsTop: 1,
    fixedColumnsLeft: 0
});