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
    public class EmployeeDAL:IEmployeeDAL
    {
        private string connectionString;
        /// <summary>
        /// 
        /// </summary>
        /// <param name="connectionString"></param>
        public EmployeeDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }
        /// <summary>
        /// Check email when add or edit employees
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        public Employee Check_Email(string email)
        {
            Employee data = null;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Employee_Get_By_Email";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Email", email);

                cmd.Connection = connection;   
                using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    if (dbReader.Read())
                    {
                        data = new Employee()
                        {
                            EmployeeID = Convert.ToInt32(dbReader["EmployeeID"]),
                            FirstName = Convert.ToString(dbReader["FirstName"]),
                            LastName = Convert.ToString(dbReader["LastName"]),
                            BirthDate = Convert.ToDateTime(dbReader["BirthDate"]),
                            Address = Convert.ToString(dbReader["Address"]),
                            City = Convert.ToString(dbReader["City"]),
                            Country = Convert.ToString(dbReader["Country"]),
                            HomePhone = Convert.ToString(dbReader["HomePhone"]),
                            Notes = Convert.ToString(dbReader["Notes"]),
                            Email = Convert.ToString(dbReader["Email"]),
                            HireDate = Convert.ToDateTime(dbReader["HireDate"]),
                            PhotoPath = Convert.ToString(dbReader["PhotoPath"]),
                            Title = Convert.ToString(dbReader["Title"]),
                            Password = Convert.ToString(dbReader["Password"])
                        };
                    }
                }
                connection.Close();
            }
            return data;

        }
        /// <summary>
        /// Add employee
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public int Add_Employee(Employee data)
        {
            int employeeID = 0;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = @"Proc_Employee_Add";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@LastName", data.LastName);
                cmd.Parameters.AddWithValue("@FirstName", data.FirstName);
                cmd.Parameters.AddWithValue("@Title", data.Title);
                cmd.Parameters.AddWithValue("@BirthDate", data.BirthDate);
                cmd.Parameters.AddWithValue("@HireDate", data.HireDate);
                cmd.Parameters.AddWithValue("@Email", data.Email);
                cmd.Parameters.AddWithValue("@Address", data.Address);
                cmd.Parameters.AddWithValue("@City", data.City);
                cmd.Parameters.AddWithValue("@Country", data.Country);
                cmd.Parameters.AddWithValue("@Notes", data.Notes);
                cmd.Parameters.AddWithValue("@PhotoPath", data.PhotoPath);
                cmd.Parameters.AddWithValue("@HomePhone", data.HomePhone);
                cmd.Parameters.AddWithValue("@Password", "e10adc3949ba59abbe56e057f20f883e");

                cmd.Connection = connection;

                employeeID = Convert.ToInt32(cmd.ExecuteScalar());

                connection.Close();
            }

            return employeeID;
        }
        /// <summary>
        /// Count empoyees
        /// </summary>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        public int Count_Employee(string searchValue, string searchCountry)
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
                    cmd.CommandText = @"Proc_Employee_Count";
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@SearchValue", searchValue);
                    cmd.Parameters.AddWithValue("@SearchCountry", searchCountry);

                    cmd.Connection = connection;


                    rowCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
                connection.Close();
            }

            return rowCount;
        }
        /// <summary>
        /// Delete employees
        /// </summary>
        /// <param name="EmployeeIDs"></param>
        /// <returns></returns>
        public bool Delete_Employee(int[] employeeIDs)
        {
            bool result = true;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Employee_Delete_By_ID";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Connection = connection;
                foreach (int employeeID in employeeIDs)
                {
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeID);
                    cmd.ExecuteNonQuery();
                }
                connection.Close();
            }
            return result;
        }
        /// <summary>
        /// Lấy danh sách nhân viên có phân trang và tìm kiếm
        /// </summary>
        /// <param name="page">số trang</param>
        /// <param name="pageSize">số dòng </param>
        /// <param name="searchValue">giá trị tìm kiếm</param>
        /// <returns></returns>
        public List<Employee> Employee_List(int page, int pageSize, string searchValue, string searchCountry)
        {
            List<Employee> data = new List<Employee>();
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = "%" + searchValue + "%";
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = @"Proc_Employee_List"; 
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SearchValue", searchValue);
                    cmd.Parameters.AddWithValue("@SearchCountry", searchCountry);
                    cmd.Parameters.AddWithValue("@Page", page);
                    cmd.Parameters.AddWithValue("@PageSize", pageSize);

                    cmd.Connection = connection;

                    using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        while (dbReader.Read())
                        {
                            data.Add(new Employee()
                            {
                                EmployeeID = Convert.ToInt32(dbReader["EmployeeID"]),
                                FirstName = Convert.ToString(dbReader["FirstName"]),
                                LastName = Convert.ToString(dbReader["LastName"]),
                                BirthDate = Convert.ToDateTime(dbReader["BirthDate"]),
                                Address = Convert.ToString(dbReader["Address"]),
                                City = Convert.ToString(dbReader["City"]),
                                Country = Convert.ToString(dbReader["Country"]),
                                HomePhone = Convert.ToString(dbReader["HomePhone"]),
                                Notes = Convert.ToString(dbReader["Notes"]),
                                Email = Convert.ToString(dbReader["Email"]),
                                HireDate = Convert.ToDateTime(dbReader["HireDate"]),
                                PhotoPath = Convert.ToString(dbReader["PhotoPath"]),
                                Title = Convert.ToString(dbReader["Title"]),
                                Password = Convert.ToString(dbReader["Password"])
                            });
                        }
                    }

                }
                connection.Close();
            }
            return data;
        }
        /// <summary>
        /// Lấy ra 1 nhân viên theo ID
        /// </summary>
        /// <param name="EmployeeID"></param>
        /// <returns></returns>
        public Employee Get_Employee(int employeeID)
        {
            Employee data = null;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"Proc_Employee_Get_By_ID";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmployeeID", employeeID);

                cmd.Connection = connection;

                using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    if (dbReader.Read())
                    {
                        data = new Employee()
                        {
                            EmployeeID = Convert.ToInt32(dbReader["EmployeeID"]),
                            FirstName = Convert.ToString(dbReader["FirstName"]),
                            LastName = Convert.ToString(dbReader["LastName"]),
                            BirthDate = Convert.ToDateTime(dbReader["BirthDate"]),
                            Address = Convert.ToString(dbReader["Address"]),
                            City = Convert.ToString(dbReader["City"]),
                            Country = Convert.ToString(dbReader["Country"]),
                            HomePhone = Convert.ToString(dbReader["HomePhone"]),
                            Notes = Convert.ToString(dbReader["Notes"]),
                            Email = Convert.ToString(dbReader["Email"]),
                            HireDate = Convert.ToDateTime(dbReader["HireDate"]),
                            PhotoPath = Convert.ToString(dbReader["PhotoPath"]),
                            Title = Convert.ToString(dbReader["Title"]),
                            Password = Convert.ToString(dbReader["Password"])
                        };
                    }
                }
                connection.Close();
            }
            return data;
        }
        /// <summary>
        /// Cập nhật thông tin nhân viên
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public bool Update_Employee(Employee data)
        {
            int rowsAffected = 0;
            using (SqlConnection connection = new SqlConnection(this.connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = @"Proc_Employee_Edit";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@LastName", data.LastName);
                cmd.Parameters.AddWithValue("@FirstName", data.FirstName);
                cmd.Parameters.AddWithValue("@Title", data.Title);
                cmd.Parameters.AddWithValue("@BirthDate", data.BirthDate);
                cmd.Parameters.AddWithValue("@HireDate", data.HireDate);
                cmd.Parameters.AddWithValue("@Email", data.Email);
                cmd.Parameters.AddWithValue("@Address", data.Address);
                cmd.Parameters.AddWithValue("@City", data.City);
                cmd.Parameters.AddWithValue("@Country", data.Country);
                cmd.Parameters.AddWithValue("@Notes", data.Notes);
                cmd.Parameters.AddWithValue("@PhotoPath", data.PhotoPath);
                cmd.Parameters.AddWithValue("@HomePhone", data.HomePhone);
                cmd.Parameters.AddWithValue("@EmployeeID", data.EmployeeID);

                cmd.Connection = connection;

                rowsAffected = Convert.ToInt32(cmd.ExecuteNonQuery());

                connection.Close();
            }

            return rowsAffected > 0; ;
        }
    }
}
