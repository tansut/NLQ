

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JDash.InMemoryAnalytics.Extensions;
using JDash.InMemoryAnalytics.Modeling;
using JDash.InMemoryAnalytics.View;

namespace JDash.InMemoryAnalytics.Modeling
{
    public class DataModel
    {
        public string Name { get; set; }
        public string Source { get; set; }
        public string Caption { get; set; }
        public DataType Type { get; set; }
        public DataFormat DefaultFormat { get; set; }
        public Config Config { get; set; }
        public string Expression { get; set; }


        public DataModel(string name, string caption, DataType type)
        {
            this.Name = name;
            this.Source = name;
            this.Caption = string.IsNullOrEmpty(caption) ? name: caption;
            this.Type = type;
            Config = new Config();
        }

        public DataModel(string name, DataType type): this(name, null, type)
        {

        }

        public DataModel(string name): this(name, DataType.Text)
        {

        }

        public DataModel()
            : this(string.Empty)
        {

        }
    }
}
