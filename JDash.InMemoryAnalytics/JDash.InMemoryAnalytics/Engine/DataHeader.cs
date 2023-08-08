

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JDash.InMemoryAnalytics.Modeling;

namespace JDash.InMemoryAnalytics.Engine
{
    public class DataHeader
    {
        public string Name { get; set; }
        public string Caption { get; set; }
        public DataType Type { get; set; }


        public DataHeader(string name, string caption, DataType type)
        {
            this.Name = name;
            this.Caption = string.IsNullOrEmpty(caption) ? name : caption;
            this.Type = type;
        }

        public DataHeader(string name, DataType type)
            : this(name, null, type)
        {

        }

        public DataHeader(string name)
            : this(name, DataType.Text)
        {

        }

        public DataHeader()
            : this(string.Empty)
        {

        }
    }
}
