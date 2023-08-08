using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JDash.Analytics.NLP
{

    public enum AggregationType
    {
        Sum,
        Average,
        Min,
        Max
    }
    public class FilterResultModel
    {
        public string Name { get; set; }
        public string FilteringValue { get; set; }
    }
    public class MeasureResultModel
    {
        public string Name { get; set; }
        public AggregationType Aggregation { get; set; }
    }

    public class ResultModel
    {
        public IEnumerable<MeasureResultModel> Measures { get; set; }
        public IEnumerable<string> Pivots { get; set; }
        public IEnumerable<string> Dimensions { get; set; }
        public IEnumerable<string> Filters { get; set; }
        public GraphType GraphType { get; set; }
    }
}
