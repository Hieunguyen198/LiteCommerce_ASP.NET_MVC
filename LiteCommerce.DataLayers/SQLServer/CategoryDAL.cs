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
    public class CategoryDAL : ICategoryDAL
    {
        /// <summary>
        /// connectionString
        /// </summary>
        private string connectionString;
        /// <summary>
        /// 
        /// </summary>
        /// <param name="connectionString"></param>
        public CategoryDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }
        /// <summary>
        /// Add category.
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public int Add_Category(Category data)
        {
            int categoryID = 0;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Category_Add";
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter prm1 = new SqlParameter("CategoryName", SqlDbType.VarChar);
                SqlParameter prm2 = new SqlParameter("Description", SqlDbType.VarChar);
                prm1.Value = data.CategoryName;
                cmd.Parameters.Add(prm1);
                prm2.Value = data.Description;
                cmd.Parameters.Add(prm2);
                cmd.Connection = connection;
                categoryID = Convert.ToInt32(cmd.ExecuteScalar());
                connection.Close();
            }
            return categoryID;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="page"></param>
        /// <param name="pageSize"></param>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        public List<Category> Category_List(string searchValue)
        {
            List<Category> data = new List<Category>();
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = "%" + searchValue + "%";
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = @"Proc_Category_List";
                    cmd.CommandType = CommandType.StoredProcedure; // kiểu câu lệnh 
                    SqlParameter param1 = new SqlParameter("searchValue", SqlDbType.VarChar);
                    param1.Value = searchValue;
                    cmd.Connection = connection;
                    cmd.Parameters.Add(param1);
                    using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        while (dbReader.Read())
                        {
                            data.Add(new Category()
                            {
                                CategoryID = Convert.ToInt32(dbReader["CategoryID"]),
                                CategoryName = Convert.ToString(dbReader["CategoryName"]),
                                Description = Convert.ToString(dbReader["Description"]),

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
        /// <param name="searchValue"></param>
        /// <returns></returns>
        public int Count_Catogory(string searchValue)
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
                    cmd.CommandText = @"Proc_Category_Count";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = connection;
                    SqlParameter param1 = new SqlParameter("searchValue", SqlDbType.VarChar);
                    param1.Value = searchValue;
                    cmd.Parameters.Add(param1);
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
        /// <param name="categoryIDs"></param>
        /// <returns></returns>
        public bool Delete_Category(int[] categoryIDs)
        {
            bool result = true;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Category_Delete_By_ID";
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter prm1 = new SqlParameter("CategoryID", SqlDbType.Int);
                cmd.Connection = connection;
                foreach (int categoryID in categoryIDs)
                {
                    prm1.Value = categoryID;
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
        /// <param name="categoryID"></param>
        /// <returns></returns>
        public Category Get_Category(int categoryID)
        {
            Category data = null;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Category_Get_By_ID";
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter prm1 = new SqlParameter("CategoryID", SqlDbType.Int);
                prm1.Value = categoryID;
                cmd.Parameters.Add(prm1);
                cmd.Connection = connection;
                using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    if (dbReader.Read())
                    {
                        data = new Category()
                        {
                            CategoryID = Convert.ToInt32(dbReader["CategoryID"]),
                            CategoryName = Convert.ToString(dbReader["CategoryName"]),
                            Description = Convert.ToString(dbReader["Description"]),
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
        /// <param name="data"></param>
        /// <returns></returns>
        public bool Update_Category(Category data)
        {
            int rowsAffected = 0;
            using (SqlConnection connection = new SqlConnection(this.connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Category_Edit";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = connection;
                SqlParameter prm1 = new SqlParameter("CategoryName", SqlDbType.NVarChar);
                SqlParameter prm2 = new SqlParameter("Description", SqlDbType.NVarChar);
                SqlParameter prm3 = new SqlParameter("CategoryID", SqlDbType.Int);
                prm1.Value = data.CategoryName;
                prm2.Value = data.Description;
                prm3.Value = data.CategoryID;
                cmd.Parameters.Add(prm1);
                cmd.Parameters.Add(prm2);
                cmd.Parameters.Add(prm3);
                rowsAffected = Convert.ToInt32(cmd.ExecuteNonQuery());
                connection.Close();
            }
            return rowsAffected > 0;
        }
    }

}
