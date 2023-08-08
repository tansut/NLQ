

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using JDash.InMemoryAnalytics.Extensions;
using JDash.InMemoryAnalytics.Modeling;

namespace JDash.InMemoryAnalytics.Engine
{
    [Serializable]
    public class DataItem : ICustomTypeDescriptor
    {
        public DataList OwnerList {get; private set;}
        public List<dynamic> Items { get; private set;}

        public DataItem(DataList list, object[] items)
        {
            this.OwnerList = list;
            this.Items = new List<object>(items);
        }

        public DataItem()
        {

        }

        public AttributeCollection GetAttributes()
        {
            return AttributeCollection.Empty;
        }

        public string GetClassName()
        {
            return this.GetType().Name;
        }

        public string GetComponentName()
        {
            return string.Empty;
        }

        public TypeConverter GetConverter()
        {
            return new TypeConverter();
        }

        public EventDescriptor GetDefaultEvent()
        {
            return null;
        }

        public PropertyDescriptor GetDefaultProperty()
        {
            return null;
        }

        public object GetEditor(Type editorBaseType)
        {
            return null;
        }

        public EventDescriptorCollection GetEvents(Attribute[] attributes)
        {
            return EventDescriptorCollection.Empty;
        }

        public EventDescriptorCollection GetEvents()
        {
            return EventDescriptorCollection.Empty;
        }

        public PropertyDescriptorCollection GetProperties(Attribute[] attributes)
        {
            return this.GetProperties();
        }

        public PropertyDescriptorCollection GetProperties()
        {
            List<PropertyDescriptor> properties = new List<PropertyDescriptor>();

            foreach (var col in OwnerList.Headers)
            {
                PropertyDescriptor pdesc = new DataItemPropertyDescriptor(col.Name, Helper.ToType(col.Type));
                properties.Add(pdesc);
            }

            return new PropertyDescriptorCollection(properties.ToArray());
        }

        public object GetPropertyOwner(PropertyDescriptor pd)
        {
            return this;
        }

        public object GetValue(string name)
        {
            var index = OwnerList.Headers.FindIndex(p => p.Name == name);
            if (index >= 0)
                return Items[index];
            else return 0;
        }

        public int ? GetAsInt(string name)
        {
            var val = GetValue(name);
            if (val == null)
                return null;
            if (val.GetType().IsAssignableFrom(typeof(int)))
                return (int)val;
            else return Convert.ToInt32(val);
        }

        public string GetAsString(string name)
        {
            var val = GetValue(name);
            if (val == null)
                return null;
            if (val.GetType().IsAssignableFrom(typeof(string)))
                return (string)val;
            else return Convert.ToString(val);
        }

        public decimal? GetAsDecimal(string name)
        {
            var val = GetValue(name);
            if (val == null)
                return null;
            if (val.GetType().IsAssignableFrom(typeof(decimal)))
                return (decimal)val;
            else return Convert.ToDecimal(val);
        }

        public bool? GetAsBoolean(string name)
        {
            var val = GetValue(name);
            if (val == null)
                return null;
            if (val.GetType().IsAssignableFrom(typeof(bool)))
                return (bool)val;
            else return Convert.ToBoolean(val);
        }

        public DateTime? GetAsDateTime(string name)
        {
            var val = GetValue(name);
            if (val == null)
                return null;
            if (val.GetType().IsAssignableFrom(typeof(DateTime)))
                return (DateTime)val;
            else return Convert.ToDateTime(val);
        }

    }
}
