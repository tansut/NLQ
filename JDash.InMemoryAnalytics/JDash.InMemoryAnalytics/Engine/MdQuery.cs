

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JDash.InMemoryAnalytics.Modeling;

namespace JDash.InMemoryAnalytics.Engine
{
    public class MdQuery
    {
        public string ConnectionName { get; set; }
        public string CatalogName { get; set; }
        public string CubeName { get; set; }
        public List<string> Dimensions { get; set; }
        public List<string> Measures { get; set; }
        public Dictionary<string, AggregationType> Aggregations { get; set; }
        public object SourceData { get; set; }
        public List<Sort> Sort { get; set; }
        public int Skip { get; set; }
        public int Take { get; set; }
        public MdQuery()
        {
            Dimensions = new List<string>();
            Measures = new List<string>();
            Aggregations = new Dictionary<string, AggregationType>();
            Sort = new List<Sort>();
            Skip = -1;
            Take = -1;
        }
    }
}
