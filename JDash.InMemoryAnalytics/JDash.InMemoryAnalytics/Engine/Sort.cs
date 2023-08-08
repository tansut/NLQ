

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace JDash.InMemoryAnalytics.Engine
{
    public enum SortDirection
    {
        Ascending,
        Descending
    }

    public class Sort
    {
        public string Column { get; set; }
        public SortDirection Direction { get; set; }
        public Sort()
        {

        }

        public Sort(string field)
        {
            this.Column = field;
        }

        public Sort(string field, SortDirection dir)
        {
            this.Column = field;
            this.Direction = dir;
        }


    }
}
