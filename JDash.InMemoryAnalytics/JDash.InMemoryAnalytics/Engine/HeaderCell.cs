

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JDash.InMemoryAnalytics.Modeling;

namespace JDash.InMemoryAnalytics.Engine
{
    public class HeaderCell: DataHeader
    {
        public HeaderType HeaderType { get; set; }

        public HeaderCell(string name, string caption, DataType cellType, HeaderType type): base(name, caption, cellType)
        {
            this.HeaderType = type;
        }
    }
}
