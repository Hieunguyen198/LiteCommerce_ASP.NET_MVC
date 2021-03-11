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
                SqlParameter prm1 = new SqlParameter("CustomerID",SqlDbType.NChar);
                SqlParameter prm2 = new SqlParameter("CompanyName", SqlDbType.NVarChar);
                SqlParameter prm3 = new SqlParameter("ContactName", SqlDbType.NVarChar);
                SqlParameter prm4 = new SqlParameter("ContactTitle", SqlDbType.NVarChar);
                SqlParameter prm5 = new SqlParameter("Address", SqlDbType.NVarChar);
                SqlParameter prm6 = new SqlParameter("City", SqlDbType.NVarChar);
                SqlParameter prm7 = new SqlParameter("Country", SqlDbType.NVarChar);
                SqlParameter prm8 = new SqlParameter("Phone", SqlDbType.NVarChar);
                SqlParameter prm9 = new SqlParameter("Fax", SqlDbType.NVarChar);
                prm1.Value = data.CustomerID;
                prm2.Value = data.CompanyName;
                prm3.Value = data.ContactName;
                prm4.Value = data.ContactTitle;
                prm5.Value = data.Address;
                prm6.Value = data.City;
                prm7.Value = data.Country;
                prm8.Value = data.Phone;
                prm9.Value = data.Fax;
                cmd.Parameters.Add(prm1);
                cmd.Parameters.Add(prm2);
                cmd.Parameters.Add(prm3);
                cmd.Parameters.Add(prm4);
                cmd.Parameters.Add(prm5);
                cmd.Parameters.Add(prm6);
                cmd.Parameters.Add(prm7);
                cmd.Parameters.Add(prm8);
                cmd.Parameters.Add(prm9);

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
                    cmd.Connection = connection;
                    SqlParameter prm1 = new SqlParameter("SearchValue", SqlDbType.NVarChar);
                    prm1.Value = searchValue;
                    cmd.Parameters.Add(prm1);
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
                    cmd.Connection = connection;
                    SqlParameter prm1 = new SqlParameter("SearchValue", SqlDbType.NVarChar);
                    SqlParameter prm2 = new SqlParameter("Page", SqlDbType.Int);
                    SqlParameter prm3 = new SqlParameter("PageSize", SqlDbType.Int);
                    prm1.Value = searchValue;
                    prm2.Value = page;
                    prm3.Value = pageSize;
                    cmd.Parameters.Add(prm1);
                    cmd.Parameters.Add(prm2);
                    cmd.Parameters.Add(prm3);
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
                SqlParameter prm1 = new SqlParameter("CustomerID", SqlDbType.NChar);
                foreach (string CustomerID in customerIDs)
                {
                    prm1.Value = CustomerID;
                    cmd.Parameters.Add(prm1);
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
        public Customer Get_Customer(string CustomerID)
        {
            Customer data = null;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Customer_Get_By_ID";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = connection;
                SqlParameter prm1 = new SqlParameter("CustomerID", SqlDbType.NChar);
                prm1.Value = CustomerID;
                cmd.Parameters.Add(prm1);
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
                cmd.Connection = connection;
                SqlParameter prm1 = new SqlParameter("CustomerID", SqlDbType.NChar);
                SqlParameter prm2 = new SqlParameter("CompanyName", SqlDbType.NVarChar);
                SqlParameter prm3 = new SqlParameter("ContactName", SqlDbType.NVarChar);
                SqlParameter prm4 = new SqlParameter("ContactTitle", SqlDbType.NVarChar);
                SqlParameter prm5 = new SqlParameter("Address", SqlDbType.NVarChar);
                SqlParameter prm6 = new SqlParameter("City", SqlDbType.NVarChar);
                SqlParameter prm7 = new SqlParameter("Country", SqlDbType.NVarChar);
                SqlParameter prm8 = new SqlParameter("Phone", SqlDbType.NVarChar);
                SqlParameter prm9 = new SqlParameter("Fax", SqlDbType.NVarChar);
                prm1.Value = data.CustomerID;
                prm2.Value = data.CompanyName;
                prm3.Value = data.ContactName;
                prm4.Value = data.ContactTitle;
                prm5.Value = data.Address;
                prm6.Value = data.City;
                prm7.Value = data.Country;
                prm8.Value = data.Phone;
                prm9.Value = data.Fax;
                cmd.Parameters.Add(prm1);
                cmd.Parameters.Add(prm2);
                cmd.Parameters.Add(prm3);
                cmd.Parameters.Add(prm4);
                cmd.Parameters.Add(prm5);
                cmd.Parameters.Add(prm6);
                cmd.Parameters.Add(prm7);
                cmd.Parameters.Add(prm8);
                cmd.Parameters.Add(prm9);

                rowsAffected = Convert.ToInt32(cmd.ExecuteNonQuery());

                connection.Close();
            }
            return rowsAffected > 0;
        }
    }
}
