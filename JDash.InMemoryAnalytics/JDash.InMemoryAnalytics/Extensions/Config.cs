

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace JDash.InMemoryAnalytics.Extensions
{
    public class Config : Dictionary<string, dynamic>
    {
        public T Get<T>(string key, T defaultValue)
        {
            dynamic val;
            if (this.TryGetValue(key, out val))
                return (T)val;
            else return defaultValue;
        }

        public T Get<T>(string key)
        {
            dynamic val = this[key];
            return Convert.ChangeType(val, typeof(T));
        }
    }
}
