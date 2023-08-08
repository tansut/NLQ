using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace JDash.WebForms.Demo
{
    public static class DBManager
    {
        private static SqlConnection Connect()
        {
            return new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConStr"].ConnectionString);
        }

        public static void GetTable(DataTable table, string sql)
        {
            using (var conn = Connect())
            {
                var adapter = new SqlDataAdapter(sql, conn);
                adapter.Fill(table);
                conn.Close();
            }
        }
    }
}