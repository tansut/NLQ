

using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JDash.InMemoryAnalytics.Modeling;

namespace JDash.InMemoryAnalytics.Engine
{
    public class MdQueryResult
    {
        public List<HeaderCell> Headers { get; set; }
        public List<List<DataCell>> Items;

        public MdQueryResult()
        {
            Headers = new List<HeaderCell>();
            Items = new List<List<DataCell>>();
        }


        public DataList ToDataList()
        {

            var columns = new List<DataHeader>();

            foreach (var header in Headers)
            {
                var newheader = new DataHeader(header.Name, header.Type);
                if (!string.IsNullOrEmpty(header.Caption))
                    newheader.Caption = header.Caption;
                columns.Add(newheader);
            }

            var result = new DataList(columns);
            
            foreach (var row in Items)
            {
                var item = result.AddData(row.Select(p => p.FormattedValue).ToArray());
            }
            return result;
        }
    }
}
