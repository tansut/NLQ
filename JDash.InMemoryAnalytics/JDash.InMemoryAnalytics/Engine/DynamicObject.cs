

using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Reflection.Emit;
using System.Text;
using System.Threading;

namespace JDash.InMemoryAnalytics.Engine
{
    public class DynamicObject
    {
        private static AssemblyBuilder myAssembly;
        private static ModuleBuilder myModuleBuilder;

        static DynamicObject()
        {
            var currentDomain = Thread.GetDomain();
            AssemblyName myAssemblyName = new AssemblyName();
            myAssemblyName.Name = "JDash.InMemoryAnalytics.DynamicTypes";
            myAssembly = currentDomain.DefineDynamicAssembly(myAssemblyName, AssemblyBuilderAccess.Run);
            myModuleBuilder = myAssembly.DefineDynamicModule("DynamicModule");
        }

        public static Type CreateGenericList(Type t)
        {
            Type listOf = typeof(List<>);
            Type listOfTFirst = listOf.MakeGenericType(t);
            return listOfTFirst;
        }

        public static IEnumerable CreateList(IEnumerable source, string[] fields)
        {
            Dictionary<string, Type> fieldMap = null;
            Type objType = null;
            IList returnList = null;

            //var newType = CreateType(fields);
            //var list = Activator.CreateInstance(CreateGenericList(newType)) as IList; 
            var enume = source.GetEnumerator();
            while (enume.MoveNext())
            {
                var obj = enume.Current;
                if (fieldMap == null)
                {
                    fieldMap = new Dictionary<string, Type>();
                    foreach (var f in fields)
                    {
                        var prop = obj.GetType().GetProperty(f);
                        if (prop == null)
                        {
                            var field = obj.GetType().GetField(f);
                            if (field != null)
                                fieldMap.Add(f, field.FieldType);
                        }
                        else
                        {
                            fieldMap.Add(f, prop.PropertyType);
                        }
                    }
                    objType = CreateType(fieldMap);
                    returnList = Activator.CreateInstance(CreateGenericList(objType)) as IList;
                }
                object instance = Activator.CreateInstance(objType);
                foreach (var f in fields)
                {
                    var prop = obj.GetType().GetProperty(f);
                    object val = null;
                    if (prop == null)
                    {
                        var field = obj.GetType().GetField(f);
                        if (field != null)
                            val = field.GetValue(obj);
                        else
                        {

                        }
                    }
                    else val = prop.GetValue(obj, null);
                    var objF = objType.GetField(f);
                    objF.SetValue(instance,val);
                }
                returnList.Add(instance);
            }
            return returnList;
        }


        public static IEnumerable ListFromDataTable(DataTable table)
        {
            var types = new Dictionary<string, Type>();
            foreach (DataColumn col in table.Columns)
            {
                types.Add(DataEngine.Identifier(col.ColumnName), col.DataType);
            }
            Type myType = CreateType(types);
            var listType = CreateGenericList(myType);
            var list = Activator.CreateInstance(listType) as IList;

            foreach (DataRow row in table.Rows)
            {
                object instance = Activator.CreateInstance(myType);
                var fields = myType.GetFields();
                var colIndex = 0;
                foreach (var field in fields)
                {
                    var fieldVal = row[colIndex++];
                    if (fieldVal is System.DBNull)
                        fieldVal = null;
                    field.SetValue(instance, fieldVal);
                }
                list.Add(instance);
            }

            return list;
        }

        public static Type CreateType(Dictionary<string, Type> fields)
        {
            TypeBuilder myTypeBuilder = myModuleBuilder.DefineType(Guid.NewGuid().ToString(), TypeAttributes.Public);
            foreach (var item in fields)
            {
                myTypeBuilder.DefineField(DataEngine.Identifier(item.Key), item.Value, FieldAttributes.Public);
            }
            return myTypeBuilder.CreateType();
        }

    }
}
