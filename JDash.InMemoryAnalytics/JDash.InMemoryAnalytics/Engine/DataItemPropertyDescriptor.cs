
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace JDash.InMemoryAnalytics.Engine
{
    public class DataItemPropertyDescriptor : PropertyDescriptor
    {
        
        //private string propertyName;
        private Type propertyType;

        public DataItemPropertyDescriptor(string propName, Type type)
            : base(propName, new Attribute[] { })
        {
            this.propertyType = type;
        }

        public override bool CanResetValue(object component)
        {
            return false;
        }

        public override Type ComponentType
        {
            get { return typeof(DataItem); }
        }

        public override object GetValue(object component)
        {
            DataItem entity = component as DataItem;
            return entity.GetValue(Name);
        }

        public override bool IsReadOnly
        {
            get { return true; }
        }

        public override Type PropertyType
        {
            get { return this.propertyType; }
        }

        public override void ResetValue(object component)
        {
            
        }

        public override void SetValue(object component, object value)
        {
            
        }

        public override bool ShouldSerializeValue(object component)
        {
            return true;
        }
    
    }
}
