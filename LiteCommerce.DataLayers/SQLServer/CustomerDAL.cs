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
    public class CustomerDAL : ICustomerDAL
    {
        /// <summary>
        /// String connection
        /// </summary>
        private string connectionString;
        /// <summary>
        /// 
        /// </summary>
        /// <param name="connectionString"></param>
        public CustomerDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }
        /// <summary>
        /// Add customer to database
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public int Add_Customer(Customer data)
        {
            int rowsAffected = 0;
            using (SqlConnection connection = new SqlConnection(this.connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Customer_Add";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = connection;
                cmd.Parameters.AddWithValue("@CustomerID", data.CustomerID);
                cmd.Parameters.AddWithValue("@CompanyName", data.CompanyName);
                cmd.Parameters.AddWithValue("@ContactName", data.ContactName);
                cmd.Parameters.AddWithValue("@ContactTitle", data.ContactTitle);
                cmd.Parameters.AddWithValue("@Address", data.Address);
                cmd.Parameters.AddWithValue("@City", data.City);
                cmd.Parameters.AddWithValue("@Country", data.Country);
                cmd.Parameters.AddWithValue("@Phone", data.Phone);
                cmd.Parameters.AddWithValue("@Fax", data.Fax);
                cmd.Connection = connection;

                rowsAffected = Convert.ToInt32(cmd.ExecuteNonQuery());
                connection.Close();
            }
            return rowsAffected;
        }
        /// <summary>
        /// Count Customer in database by seacrchValue
        /// </summary>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        public int Count_Customer(string searchValue)
        {
            int rowCount = 0;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = "%" + searchValue + "%";
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = @"Proc_Customer_Count";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SearchValue", searchValue);
                    cmd.Connection = connection;
                    rowCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
                connection.Close();
            }

            return rowCount;
        }
        /// <summary>
        /// Get list Customer by searchValue, page and pagesize
        /// </summary>
        /// <param name="page"></param>
        /// <param name="pageSize"></param>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        public List<Customer> Customer_List(int page, int pageSize, string searchValue)
        {
            List<Customer> data = new List<Customer>();
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = "%" + searchValue + "%";
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = @"Proc_Customer_List";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SearchValue", searchValue);
                    cmd.Parameters.AddWithValue("@Page", page);
                    cmd.Parameters.AddWithValue("@PageSize", pageSize);
                    cmd.Connection = connection;
                    using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        while (dbReader.Read())
                        {
                            data.Add(new Customer()
                            {
                                CustomerID = Convert.ToString(dbReader["CustomerID"]),
                                CompanyName = Convert.ToString(dbReader["CompanyName"]),
                                ContactName = Convert.ToString(dbReader["ContactName"]),
                                ContactTitle = Convert.ToString(dbReader["ContactTitle"]),
                                Address = Convert.ToString(dbReader["Address"]),
                                City = Convert.ToString(dbReader["City"]),
                                Country = Convert.ToString(dbReader["Country"]),
                                Phone = Convert.ToString(dbReader["Phone"]),
                                Fax = Convert.ToString(dbReader["Fax"]),
                            });
                        }
                    }

                }
                connection.Close();
            }
            return data;
        }
        /// <summary>
        /// Xóa nhiều khách hàng theo danh sách CustomerID
        /// </summary>
        /// <param name="CustomerIDs"></param>
        /// <returns></returns>
        public bool Delete_Customer(string[] customerIDs)
        {
            bool result = true;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Customer_Delete";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = connection;

                foreach (string customerID in customerIDs)
                {
                    cmd.Parameters.AddWithValue("@CustomerID", customerID);
                    cmd.ExecuteNonQuery();
                }
                connection.Close();
            }
            return result;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="CustomerID"></param>
        /// <returns></returns>
        public Customer Get_Customer(string customerID)
        {
            Customer data = null;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Customer_Get_By_ID";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CustomerID", customerID);
                cmd.Connection = connection;

                using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    if (dbReader.Read())
                    {
                        data = new Customer()
                        {
                            CustomerID = Convert.ToString(dbReader["CustomerID"]),
                            CompanyName = Convert.ToString(dbReader["CompanyName"]),
                            ContactName = Convert.ToString(dbReader["ContactName"]),
                            ContactTitle = Convert.ToString(dbReader["ContactTitle"]),
                            Address = Convert.ToString(dbReader["Address"]),
                            City = Convert.ToString(dbReader["City"]),
                            Country = Convert.ToString(dbReader["Country"]),
                            Phone = Convert.ToString(dbReader["Phone"]),
                            Fax = Convert.ToString(dbReader["Fax"])
                        };
                    }
                }
                connection.Close();
            }
            return data;
        }
        /// <summary>
        /// update a customer
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public bool Update_Customer(Customer data)
        {
            int rowsAffected = 0;
            using (SqlConnection connection = new SqlConnection(this.connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Customer_Edit";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CustomerID", data.CustomerID);
                cmd.Parameters.AddWithValue("@CompanyName", data.CompanyName);
                cmd.Parameters.AddWithValue("@ContactName", data.ContactName);
                cmd.Parameters.AddWithValue("@ContactTitle", data.ContactTitle);
                cmd.Parameters.AddWithValue("@Address", data.Address);
                cmd.Parameters.AddWithValue("@City", data.City);
                cmd.Parameters.AddWithValue("@Country", data.Country);
                cmd.Parameters.AddWithValue("@Phone", data.Phone);
                cmd.Parameters.AddWithValue("@Fax", data.Fax);
                cmd.Connection = connection;

                rowsAffected = Convert.ToInt32(cmd.ExecuteNonQuery());

                connection.Close();
            }
            return rowsAffected > 0;
        }
    }
}
