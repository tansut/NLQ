
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JDash.InMemoryAnalytics.Modeling;

namespace JDash.InMemoryAnalytics.Modeling
{
    public class DimensionModel: DataModel
    {
        public string DimensionType { get; set; }

        public DimensionModel(string name, DataType type)
            : base(name, type)
        {
            DimensionType = "";
        }

        public DimensionModel(string name)
            : this(name, DataType.Text)
        {

        }

        public DimensionModel()
            : this(string.Empty)
        {

        }
    }
}
