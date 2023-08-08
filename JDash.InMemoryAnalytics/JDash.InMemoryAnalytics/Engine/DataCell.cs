

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace JDash.InMemoryAnalytics.Engine
{
    public class DataCell: Cell
    {
        public object Value { get; private set; }
        public string FormattedValue { get; private set; }

        public DataCell(object val, string format)
        {
            this.Value = val;
            FormatWith(format);
        }

        public DataCell(object val): this(val, string.Empty)
        {

        }
        
        public string FormatWith(string format)
        {
            if (Value == null)
                FormattedValue = "";
            else if (!string.IsNullOrEmpty(format))
            {
                try
                {
                    var method = Value.GetType().GetMethod("ToString", new Type[] { typeof(string) });
                    if (method != null)
                        FormattedValue = method.Invoke(Value, new object[] { format }) as string;
                }
                catch (FormatException)
                {
                    FormattedValue = Value.ToString();
                }
            }
            else FormattedValue = Value.ToString();
            return FormattedValue;
        }
    }
}
