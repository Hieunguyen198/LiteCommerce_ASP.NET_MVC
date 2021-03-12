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
    public class EmployeeUserAccountDAL:IUserAccountDAL
    {
        private string connectionString;
        /// <summary>
        /// 
        /// </summary>
        /// <param name="connectionstring"></param>
        public EmployeeUserAccountDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }
        /// <summary>
        /// Authorize login infomation
        /// </summary>
        /// <param name="email"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public UserAccount Authorize(string email, string password)
        {
            UserAccount data = null;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = @"Proc_UserAccount_Authorize";
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@PWd", password);

                    cmd.Connection = connection;
                   
                    using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        while (dbReader.Read())
                        {
                            data = new UserAccount()
                            {
                                UserID = Convert.ToString(dbReader["EmployeeID"]),
                                FullName = Convert.ToString(dbReader["FirstName"]) + " " + Convert.ToString(dbReader["LastName"]),
                                Photo = Convert.ToString(dbReader["PhotoPath"]),
                                GroupName = Convert.ToString(dbReader["GroupName"]),
                                Title = Convert.ToString(dbReader["Title"]),
                                HireDate=Convert.ToString(dbReader["HireDate"])
                            };
                        }
                    }

                }
                connection.Close();
            }
            return data;
        }
        /// <summary>
        /// change Pwd
        /// </summary>
        /// <param name="id"></param>
        /// <param name="newPWd"></param>
        /// <returns></returns>
        public bool PWd_Update(string id, string newPWd)
        {
            int rowsAffected = 0;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    connection.Open();
                    cmd.CommandText = @"Proc_UserAccount_Change_PWd";
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@EmployeeID", id);
                    cmd.Parameters.AddWithValue("@Password", newPWd);

                    cmd.Connection = connection;

                    rowsAffected = Convert.ToInt32(cmd.ExecuteNonQuery());
                    connection.Close();
                }
            }
            return rowsAffected > 0;
        }

    }
}
