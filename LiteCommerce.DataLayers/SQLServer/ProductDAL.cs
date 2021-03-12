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
    public class ProductDAL : IProductDAL
    {
        /// <summary>
        /// 
        /// </summary>
        private string connectionString;
        /// <summary>
        /// 
        /// </summary>
        /// <param name="connectionString"></param>
        public ProductDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public int Add_Product(Product data)
        {
            int productID = 0;
            using (SqlConnection connection = new SqlConnection(this.connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Product_Add";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProductName", data.ProductName);
                cmd.Parameters.AddWithValue("@CategoryID", data.CategoryID);
                cmd.Parameters.AddWithValue("@QuantityPerUnit", data.QuantityPerUnit);
                cmd.Parameters.AddWithValue("@UnitPrice", data.UnitPrice);
                cmd.Parameters.AddWithValue("@Descriptions", data.Descriptions);
                cmd.Parameters.AddWithValue("@PhotoPath", data.PhotoPath);

                cmd.Connection = connection;
                
                productID = Convert.ToInt32(cmd.ExecuteScalar());

                connection.Close();
            }

            return productID;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="searchValue"></param>
        /// <param name="searchSupplier"></param>
        /// <param name="searchCategory"></param>
        /// <param name="searchPrice"></param>
        /// <returns></returns>
        public int Count_Product(string searchValue, string searchCategory, string searchPrice)
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
                    cmd.CommandText = @"Proc_Product_Count";
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@SearchValue", searchValue);
                    cmd.Parameters.AddWithValue("@SearchCategory", searchCategory);
                    cmd.Parameters.AddWithValue("@SearchPrice", searchPrice);

                    cmd.Connection = connection;
                   
                    rowCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
                connection.Close();
            }
            return rowCount;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="ProductIDs"></param>
        /// <returns></returns>
        public bool Delete_Product(int[] productIDs)
        {
            bool result = true;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = @"Proc_Product_Delete";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Connection = connection;
                foreach (int productID in productIDs)
                {
                    cmd.Parameters.AddWithValue("@ProductID", productID);
                    cmd.ExecuteNonQuery();
                }
                connection.Close();
            }
            return result;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="ProductID"></param>
        /// <returns></returns>
        public Product Get_Product(int productID)
        {
            Product data = null;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = @"Proc_Product_Get_By_ID";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProductID", productID);

                cmd.Connection = connection;
                using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    if (dbReader.Read())
                    {
                        data = new Product()
                        {
                            ProductID = Convert.ToInt32(dbReader["ProductID"]),
                            ProductName = Convert.ToString(dbReader["ProductName"]),
                            CategoryName = Convert.ToString(dbReader["CategoryName"]),
                            CategoryID = Convert.ToInt32(dbReader["CategoryID"]),
                            UnitPrice = Convert.ToDouble(dbReader["UnitPrice"]),
                            Descriptions = Convert.ToString(dbReader["Descriptions"]),
                            QuantityPerUnit = Convert.ToString(dbReader["QuantityPerUnit"]),
                            PhotoPath = Convert.ToString(dbReader["PhotoPath"])
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
        /// <returns></returns>
        public List<SelectList> List_Category()
        {
            List<SelectList> data = new List<SelectList>();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = @"Proc_Product_List_Category";
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Connection = connection;

                    using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        while (dbReader.Read())
                        {
                            data.Add(new SelectList
                            {
                                Value = Convert.ToInt32(dbReader["CategoryID"]),
                                Text = Convert.ToString(dbReader["CategoryName"])
                            });
                        }
                    }

                }
                connection.Close();
            }
            return data;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="page"></param>
        /// <param name="pageSize"></param>
        /// <param name="searchValue"></param>
        /// <param name="searchSupplier"></param>
        /// <param name="searchCategory"></param>
        /// <param name="searchPrice"></param>
        /// <returns></returns>
        public List<Product> Product_List(int page, int pageSize, string searchValue, string searchCategory, string searchPrice)
        {
            List<Product> data = new List<Product>();
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = "%" + searchValue + "%";
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = @"Proc_Product_List";
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@SearchValue", searchValue);
                    cmd.Parameters.AddWithValue("@SearchCategory", searchCategory);
                    cmd.Parameters.AddWithValue("@SearchPrice", searchPrice);
                    cmd.Parameters.AddWithValue("@Page", page);
                    cmd.Parameters.AddWithValue("@PageSize", pageSize);

                    cmd.Connection = connection;
                    
                    using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        while (dbReader.Read())
                        {
                            data.Add(new Product()
                            {
                                ProductID = Convert.ToInt32(dbReader["ProductID"]),
                                ProductName = Convert.ToString(dbReader["ProductName"]),
                                CategoryName = Convert.ToString(dbReader["CategoryName"]),
                                CategoryID = Convert.ToInt32(dbReader["CategoryID"]),
                                UnitPrice = Convert.ToDouble(dbReader["UnitPrice"]),
                                Descriptions = Convert.ToString(dbReader["Descriptions"]),
                                QuantityPerUnit = Convert.ToString(dbReader["QuantityPerUnit"]),
                                PhotoPath = Convert.ToString(dbReader["PhotoPath"])
                            });
                        }
                    }

                }
                connection.Close();
            }
            return data;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public bool Update_Product(Product data)
        {
            int rowsAffected = 0;
            using (SqlConnection connection = new SqlConnection(this.connectionString))
            {
                connection.Open();

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Product_Edit";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProductName", data.ProductName);
                cmd.Parameters.AddWithValue("@CategoryID", data.CategoryID);
                cmd.Parameters.AddWithValue("@QuantityPerUnit", data.QuantityPerUnit);
                cmd.Parameters.AddWithValue("@UnitPrice", data.UnitPrice);
                cmd.Parameters.AddWithValue("@Descriptions", data.Descriptions);
                cmd.Parameters.AddWithValue("@PhotoPath", data.PhotoPath);
                cmd.Parameters.AddWithValue("@ProductID", data.ProductID);

                cmd.Connection = connection;
                
                rowsAffected = Convert.ToInt32(cmd.ExecuteNonQuery());

                connection.Close();
            }
            return rowsAffected > 0;
        }

    }
}
