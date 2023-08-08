

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using JDash.InMemoryAnalytics.Extensions;
using JDash.InMemoryAnalytics.Engine;

namespace JDash.InMemoryAnalytics.Modeling
{
    public class CubeModel
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string GroupName { get; set; }
        public string Caption { get; set; }
        public string Description { get; set; }
        public string DataSourceID { get; set; }
        public string CubeType { get; set; }
        public List<DimensionModel> Dimensions { get; set; }
        public List<MeasureModel> Measures { get; set; }
        public string DefaultMeasure { get; set; }
        public AggregationType DefaultAggregation { get; set; }
        public Config Config { get; set; }        

        public CubeModel(string name, string description)
        {
            this.Name = name;
            this.Description = description;
            this.Caption = name;
            Dimensions = new List<DimensionModel>();
            Measures = new List<MeasureModel>();
            Config = new Config();
        }

        public CubeModel(string name)
            : this(name, string.Empty)
        {

        }

        public CubeModel(): this(string.Empty, string.Empty)
        {

        }

        public static CubeModel GenerateFromDataTable(DataTable table, Dictionary<string, DataType> columnTypes = null)
        {
            var model = new CubeModel(table.TableName);

            foreach (DataColumn col in table.Columns)
            {
                var type = DataType.Text;
                if (columnTypes != null)
                {
                    if (!columnTypes.TryGetValue(col.ColumnName, out type))
                        type = Helper.ToDataType(col.DataType);
                }
                else type = Helper.ToDataType(col.DataType);
                var isMeasure = Helper.IsMeasure(type);
                var caption = col.Caption;

                if (isMeasure)
                {
                    var measure = new MeasureModel(DataEngine.Identifier(col.ColumnName), type);
                    if (!string.IsNullOrEmpty(col.Caption))
                        measure.Caption = col.Caption;
                    model.Measures.Add(measure);
                }
                else
                {
                    var dimension = new DimensionModel(DataEngine.Identifier(col.ColumnName), type);
                    if (!string.IsNullOrEmpty(col.Caption))
                        dimension.Caption = col.Caption;
                    model.Dimensions.Add(dimension);
                }
            }

            return model;
        }
    }
}
