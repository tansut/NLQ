
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JDash.InMemoryAnalytics.Modeling;

namespace JDash.InMemoryAnalytics.Modeling
{
    public class MeasureModel : DataModel
    {
        public AggregationType Aggregation { get; set; }

        public MeasureModel(string name, DataType type): base(name, type)
        {

        }

        public MeasureModel(string name)
            : base(name, DataType.Text)
        {

        }

        public MeasureModel()
            : base(string.Empty)
        {

        }
    }
}
