using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LiteCommerce.DomainModels;

namespace LiteCommerce.DataLayers.SQLServer
{
    public class DashboardDAL : IDashboardDAL
    {
        private string connectionString;
        public DashboardDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public Dashboard OrderStatisticsByYear(int year)
        {
            Dashboard data = null;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Dashboard_OrderQuantity_By_Year";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = connection;
                cmd.Parameters.AddWithValue("@Year", year);
                using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    if (dbReader.Read())
                    {
                        data = new Dashboard()
                        {
                            Year = Convert.ToInt32(dbReader["Year"]),
                            January = Convert.ToInt32(dbReader["January"]),
                            February = Convert.ToInt32(dbReader["February"]),
                            March = Convert.ToInt32(dbReader["March"]),
                            April = Convert.ToInt32(dbReader["April"]),
                            May = Convert.ToInt32(dbReader["May"]),
                            June = Convert.ToInt32(dbReader["June"]),
                            July = Convert.ToInt32(dbReader["July"]),
                            August = Convert.ToInt32(dbReader["August"]),
                            September = Convert.ToInt32(dbReader["September"]),
                            October = Convert.ToInt32(dbReader["October"]),
                            November = Convert.ToInt32(dbReader["November"]),
                            December = Convert.ToInt32(dbReader["December"])
                        };
                    }
                }
                connection.Close();
            }
            return data;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="year"></param>
        /// <returns></returns>
        public Dashboard RevenueStatisticsByYear(int year)
        {
            Dashboard data = null;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Dashboard_Revenue_By_Year";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = connection;
                cmd.Parameters.AddWithValue("@Year", year);
                using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    if (dbReader.Read())
                    {
                        data = new Dashboard()
                        {
                            Year = Convert.ToInt32(dbReader["Year"]),
                            January = Convert.ToInt32(dbReader["January"]),
                            February = Convert.ToInt32(dbReader["February"]),
                            March = Convert.ToInt32(dbReader["March"]),
                            April = Convert.ToInt32(dbReader["April"]),
                            May = Convert.ToInt32(dbReader["May"]),
                            June = Convert.ToInt32(dbReader["June"]),
                            July = Convert.ToInt32(dbReader["July"]),
                            August = Convert.ToInt32(dbReader["August"]),
                            September = Convert.ToInt32(dbReader["September"]),
                            October = Convert.ToInt32(dbReader["October"]),
                            November = Convert.ToInt32(dbReader["November"]),
                            December = Convert.ToInt32(dbReader["December"])
                        };
                    }
                }
                connection.Close();
            }
            return data;
        }
        public Dashboard DiscountStatisticsByYear(int year)
        {
            Dashboard data = null;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Dashboard_Discount_By_Year";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = connection;
                cmd.Parameters.AddWithValue("@Year", year);
                using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    if (dbReader.Read())
                    {
                        data = new Dashboard()
                        {
                            Year = Convert.ToInt32(dbReader["Year"]),
                            January = Convert.ToInt32(dbReader["January"]),
                            February = Convert.ToInt32(dbReader["February"]),
                            March = Convert.ToInt32(dbReader["March"]),
                            April = Convert.ToInt32(dbReader["April"]),
                            May = Convert.ToInt32(dbReader["May"]),
                            June = Convert.ToInt32(dbReader["June"]),
                            July = Convert.ToInt32(dbReader["July"]),
                            August = Convert.ToInt32(dbReader["August"]),
                            September = Convert.ToInt32(dbReader["September"]),
                            October = Convert.ToInt32(dbReader["October"]),
                            November = Convert.ToInt32(dbReader["November"]),
                            December = Convert.ToInt32(dbReader["December"])
                        };
                    }
                }
                connection.Close();
            }
            return data;
        }
    }
}
