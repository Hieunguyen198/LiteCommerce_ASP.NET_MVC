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
                cmd.Connection = connection;
                SqlParameter prm1 = new SqlParameter("ProductName", SqlDbType.NVarChar);
                SqlParameter prm2 = new SqlParameter("CategoryID", SqlDbType.NVarChar);
                SqlParameter prm3 = new SqlParameter("QuantityPerUnit", SqlDbType.NVarChar);
                SqlParameter prm4 = new SqlParameter("UnitPrice", SqlDbType.Float);
                SqlParameter prm5 = new SqlParameter("Descriptions", SqlDbType.NVarChar);
                SqlParameter prm6 = new SqlParameter("PhotoPath", SqlDbType.NVarChar);
                prm1.Value = data.ProductName;
                prm2.Value = data.CategoryID;
                prm3.Value = data.QuantityPerUnit;
                prm4.Value = data.UnitPrice;
                prm5.Value = data.Descriptions;
                prm6.Value = data.PhotoPath;
                cmd.Parameters.Add(prm1);
                cmd.Parameters.Add(prm2);
                cmd.Parameters.Add(prm3);
                cmd.Parameters.Add(prm4);
                cmd.Parameters.Add(prm5);
                cmd.Parameters.Add(prm6);
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
                    cmd.Connection = connection;
                    SqlParameter prm1 = new SqlParameter("searchValue", SqlDbType.NVarChar);
                    SqlParameter prm2 = new SqlParameter("searchCategory", SqlDbType.NVarChar);
                    SqlParameter prm3 = new SqlParameter("searchPrice", SqlDbType.NVarChar);
                    prm1.Value = searchValue;
                    prm2.Value = searchCategory;
                    prm3.Value = searchPrice;
                    cmd.Parameters.Add(prm1);
                    cmd.Parameters.Add(prm2);
                    cmd.Parameters.Add(prm3);
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
                SqlParameter prm1 = new SqlParameter("ProductID", SqlDbType.Int);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = connection;
                foreach (int productID in productIDs)
                {
                    prm1.Value = productID;
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
                cmd.Connection = connection;
                SqlParameter prm1 = new SqlParameter("ProductID", SqlDbType.Int);
                prm1.Value = productID;
                cmd.Parameters.Add(prm1);
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
                    cmd.CommandText = @"select CategoryID,CategoryName
                                        from Categories";
                    cmd.CommandType = CommandType.Text;
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
                    cmd.Connection = connection;
                    SqlParameter prm1 = new SqlParameter("searchValue", SqlDbType.NVarChar);
                    SqlParameter prm2 = new SqlParameter("searchCategory", SqlDbType.NVarChar);
                    SqlParameter prm3 = new SqlParameter("searchPrice", SqlDbType.NVarChar);
                    SqlParameter prm4 = new SqlParameter("page", SqlDbType.Int);
                    SqlParameter prm5 = new SqlParameter("pageSize", SqlDbType.Int);
                    prm1.Value = searchValue;
                    prm2.Value = searchCategory;
                    prm3.Value = searchPrice;
                    prm4.Value = page;
                    prm5.Value = pageSize;
                    cmd.Parameters.Add(prm1);
                    cmd.Parameters.Add(prm2);
                    cmd.Parameters.Add(prm3);
                    cmd.Parameters.Add(prm4);
                    cmd.Parameters.Add(prm5);
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
                cmd.Connection = connection;
                SqlParameter prm1 = new SqlParameter("ProductName", SqlDbType.NVarChar);
                SqlParameter prm2 = new SqlParameter("CategoryID", SqlDbType.NVarChar);
                SqlParameter prm3 = new SqlParameter("QuantityPerUnit", SqlDbType.NVarChar);
                SqlParameter prm4 = new SqlParameter("UnitPrice", SqlDbType.Float);
                SqlParameter prm5 = new SqlParameter("Descriptions", SqlDbType.NVarChar);
                SqlParameter prm6 = new SqlParameter("PhotoPath", SqlDbType.NVarChar);
                SqlParameter prm7 = new SqlParameter("ProductID", SqlDbType.Int);
                prm1.Value = data.ProductName;
                prm2.Value = data.CategoryID;
                prm3.Value = data.QuantityPerUnit;
                prm4.Value = data.UnitPrice;
                prm5.Value = data.Descriptions;
                prm6.Value = data.PhotoPath;
                prm7.Value = data.ProductID;
                cmd.Parameters.Add(prm1);
                cmd.Parameters.Add(prm2);
                cmd.Parameters.Add(prm3);
                cmd.Parameters.Add(prm4);
                cmd.Parameters.Add(prm5);
                cmd.Parameters.Add(prm6);
                cmd.Parameters.Add(prm7);
                rowsAffected = Convert.ToInt32(cmd.ExecuteNonQuery());
                connection.Close();
            }
            return rowsAffected > 0;
        }

    }
}
