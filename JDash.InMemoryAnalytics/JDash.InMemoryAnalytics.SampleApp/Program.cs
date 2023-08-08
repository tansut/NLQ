


using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using FileHelpers;
using JDash.InMemoryAnalytics.Engine;
using JDash.InMemoryAnalytics.Modeling;
using JDash.InMemoryAnalytics.View;
using Newtonsoft.Json;


namespace Kalitte.SimpleAnalytics.SampleProject
{
    class Program
    {
        static void Main(string[] args)
        {
            var file = "sales.csv";
            var table = CsvEngine.CsvToDataTable(file, ';');
            
            var columnTypes = new Dictionary<string, Type>();
            columnTypes.Add("Year", typeof(string));
            columnTypes.Add("Month", typeof(string));
            columnTypes.Add("Quantity", typeof(int));
            columnTypes.Add("VAT", typeof(decimal));
            columnTypes.Add("Unit_Price", typeof(decimal));
            columnTypes.Add("Total_Price", typeof(decimal));

            var newTable = new DataTable();
            newTable.TableName = "Product Sales";
            foreach (DataColumn col in table.Columns)
            {
                var t = typeof(string);
                if (!columnTypes.TryGetValue(col.ColumnName, out t))
                    t= typeof(string);
                newTable.Columns.Add(col.ColumnName, t);
            }

            foreach (DataRow row in table.Rows)
            {
                newTable.Rows.Add(row.ItemArray);
            }

            var cubeModel = CubeModel.GenerateFromDataTable(newTable);
            cubeModel.Dimensions.RemoveAll(p => p.Name == "Year");
            cubeModel.Dimensions.RemoveAll(p => p.Name == "Month");

            cubeModel.Dimensions.Add(new DimensionModel("Year", DataType.Text));
            cubeModel.Dimensions.Add(new DimensionModel("Month", DataType.Text));

            cubeModel.Dimensions.Add(new DimensionModel("Quarter", DataType.Text) { Expression = "Year + \" \" + Month" });
            cubeModel.Measures.Add(new MeasureModel("CalcField", DataType.Integer) { Expression = "Total_Price + Unit_Price" });


            foreach (var item in cubeModel.Dimensions)
            {
                item.Caption = item.Name.Replace('_', ' ');
            }

            foreach (var item in cubeModel.Measures)
            {
                item.Caption = item.Name.Replace('_', ' ');
            }

            cubeModel.Measures.Single(p => p.Name == "Total_Price").Caption = "Total Price";
            cubeModel.Measures.Single(p => p.Name == "Total_Price").Aggregation = AggregationType.Count;
            cubeModel.Measures.Single(p => p.Name == "Unit_Price").Caption = "Unit Price";

            cubeModel.Measures.Single(p => p.Name == "Total_Price").DefaultFormat = new DataFormat() { FormatString = "C" };
            cubeModel.Measures.Single(p => p.Name == "Unit_Price").DefaultFormat = new DataFormat() { FormatString = "C" };

            var ds = new DataSet();
            ds.Tables.Add(newTable);
            ds.WriteXml(cubeModel.Name + "-DataSet.xml");


            DataEngine engine = new DataEngine(cubeModel);
            var query = new MdQuery();
            query.SourceData = DynamicObject.ListFromDataTable(newTable);
            //query.Dimensions.Add("Year");
            query.Dimensions.Add("Month");
            //query.Dimensions.Add("Quarter");
            query.Measures.Add("Unit_Price");
            query.Measures.Add("Total_Price");
            query.Measures.Add("CalcField");



            query.Sort.Add(new JDash.InMemoryAnalytics.Engine.Sort("CalcField", JDash.InMemoryAnalytics.Engine.SortDirection.Descending));
            query.Take = 5;
            query.Skip= 5;

            var result = engine.Execute(query);

            foreach (var header in result.Headers)
            {
                Console.Write(header.Caption + "\t");
            }
            Console.WriteLine();
            foreach (var row in result.Items)
            {
                foreach (var cell in row)
                {
                    Console.Write(cell.FormattedValue + "\t");
                }
                Console.WriteLine();
            }
            Console.ReadLine();
        }
    }
}
