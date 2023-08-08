using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Xml.Serialization;


namespace JDash.WebForms.Demo.Helpers
{
    public static class Util
    {
        public static string Request(string url, int retryCount = 1)
        {
            int counter = 0;

            while (counter < retryCount)
            {
                try
                {
                    HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
                    HttpWebResponse wr = (HttpWebResponse)request.GetResponse();
                    Stream receiveStream = wr.GetResponseStream();
                    StreamReader reader = new StreamReader(receiveStream, Encoding.UTF8);
                    return (reader.ReadToEnd()).ToString();
                }
                catch (Exception)
                {
                    counter++;
                    if (counter >= retryCount)
                        throw;
                }
            }

            return string.Empty;
        }

        public static int GetEntityID(object entity)
        {
            PropertyInfo userIdentifierProperty = entity.GetType().GetProperty("Id");
            if (userIdentifierProperty == null)
                return -1;
            else return (int)userIdentifierProperty.GetValue(entity, null);
        }

        public static byte[] SerializeObjectAsZip(Type t, object target)
        {
            XmlSerializer formatter = new XmlSerializer(t);
            MemoryStream ms = new MemoryStream();
            formatter.Serialize(ms, target);
            ms.Position = 0;
            MemoryStream zipStream = new MemoryStream();
            GZipStream zip = new GZipStream(zipStream, CompressionMode.Compress);
            ms.CopyTo(zip);
            zip.Close();
            return zipStream.ToArray();
        }

        public static object DeSerializeObjectFromZip(Type t, byte[] buffer)
        {
            XmlSerializer formatter = new XmlSerializer(t);
            MemoryStream ms = new MemoryStream(buffer);
            ms.Position = 0;
            MemoryStream zipStream = new MemoryStream();
            GZipStream zip = new GZipStream(ms, CompressionMode.Decompress);
            zip.CopyTo(zipStream);
            zip.Close();
            zipStream.Position = 0;
            return formatter.Deserialize(zipStream);
        }

        public static string GetEnumDescription(Type enumType, string enumItem)
        {
            string result = string.Empty;
            MemberInfo[] member = enumType.GetMember(enumItem);
            if (member != null && member.Length > 0)
            {
                object[] att = member[0].GetCustomAttributes(typeof(DescriptionAttribute), false);
                if (att != null)
                {
                    DescriptionAttribute desc = att.Where(p => p.GetType() == (typeof(DescriptionAttribute))).Select(u => (DescriptionAttribute)u).SingleOrDefault();
                    if (desc != null) result = desc.Description;
                }
            }
            return result;

        }

        public static Dictionary<string, string> GetDescriptionalEnumInfo(Type enumType, Func<KeyValuePair<string, string>, bool> filter = null)
        {
            Dictionary<string, string> result = new Dictionary<string, string>();
            string[] names = Enum.GetNames(enumType);
            foreach (string item in names)
            {
                string desc;
                desc = GetEnumDescription(enumType, item);
                if (desc != string.Empty)
                {
                    result.Add(item, desc);
                }
                else
                {
                    result.Add(item, item);
                }
            }
            if (filter != null)
                result = result.Where(filter).ToDictionary(p => p.Key, p => p.Value);
            return result;
        }


        public static bool CheckUserInRole(string auth)
        {
            bool authorized = true;

            if (!string.IsNullOrWhiteSpace(auth))
            {
                if (Thread.CurrentPrincipal.Identity.IsAuthenticated)
                {
                    var roles = auth.Split(",".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);

                    foreach (var role in roles)
                    {
                        authorized = Thread.CurrentPrincipal.IsInRole(role.Trim());
                        if (authorized)
                        {
                            break;
                        }
                    }
                }
                else return false;
            }
            return authorized;
        }
    }
}
