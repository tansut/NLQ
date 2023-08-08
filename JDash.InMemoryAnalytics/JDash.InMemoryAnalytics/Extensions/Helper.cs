

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JDash.InMemoryAnalytics.Modeling;

namespace JDash.InMemoryAnalytics.Extensions
{
    public static class Helper
    {
        private static Dictionary<Type, DataType> map = new Dictionary<Type, DataType>();

        static Helper()
        {
            map.Add(typeof(int), DataType.Integer);
            map.Add(typeof(bool), DataType.Boolean);
            map.Add(typeof(DateTime), DataType.Date);
            map.Add(typeof(double), DataType.Decimal);
            map.Add(typeof(float), DataType.Decimal);
            map.Add(typeof(string), DataType.Text);
            map.Add(typeof(decimal), DataType.Decimal);
        }

        public static DataType ToDataType(Type t)
        {
            var type = DataType.Text;
            if (map.TryGetValue(t, out type))
                return type;
            else return DataType.Text;
        }

        public static bool IsMeasure(DataType t) {
            return (t == DataType.Integer || t == DataType.Decimal);
        }

        public static Type ToType(DataType dataType)
        {
            foreach (var item in map)
            {
                if (item.Value == dataType)
                    return item.Key;
            }
            return typeof(string);
        }
    }
}
