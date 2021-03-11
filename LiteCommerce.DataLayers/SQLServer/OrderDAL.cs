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
    public class OrderDAL : IOrderDAL
    {
        /// <summary>
        /// Chuỗi kết nối với database
        /// </summary>
        private string connectionString;
        /// <summary>
        /// Hàm dựng
        /// </summary>
        public OrderDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }
        /// <summary>
        /// Lấy danh sách hóa đơn
        /// </summary>
        /// <param name="page"></param>
        /// <param name="pageSize"></param>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        public List<Order> Order_List(int page, int pageSize, string searchValue)
        {
            List<Order> data = new List<Order>();
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = "%" + searchValue + "%";
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = @"SELECT *
                                        FROM
                                        (
                                        SELECT *,
		                                        ROW_NUMBER() over(order by OrderID) AS RowNumber
                                        FROM View_Orders
                                        WHERE (@searchValue=N'')
                                               OR(FirstName like @searchValue) OR (LastName like @searchValue)
                                        ) AS T
                                        WHERE  (t.RowNumber between (@page*@pageSize)-@pageSize+1 and @page*@pageSize)";
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = connection;
                    cmd.Parameters.AddWithValue("@page", page);
                    cmd.Parameters.AddWithValue("@pageSize", pageSize);
                    cmd.Parameters.AddWithValue("@searchValue", searchValue);
                    using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        while (dbReader.Read())
                        {
                            data.Add(new Order()
                            {
                                OrderID = Convert.ToInt32(dbReader["OrderID"]),
                                CustomerID = Convert.ToString(dbReader["CustomerID"]),
                                EmployeeID = Convert.ToInt32(dbReader["EmployeeID"]),
                                CustomerName = Convert.ToString(dbReader["ContactName"]),
                                EmployeeName = Convert.ToString(dbReader["FirstName"]) + " " + Convert.ToString(dbReader["LastName"]),
                                OrderDate = Convert.ToDateTime(dbReader["OrderDate"]),
                            });
                        }
                    }

                }
                connection.Close();
            }
            return data;
        }
        /// <summary>
        /// Count orders
        /// </summary>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        public int Count_Order(string searchValue)
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
                    cmd.CommandText = @"SELECT COUNT(*)
                                        FROM View_Orders
                                        WHERE      (@searchValue=N'')
                                               OR  (FirstName like @searchValue) OR (LastName like @searchValue)";
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = connection;
                    cmd.Parameters.AddWithValue("@searchValue", searchValue);
                    rowCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
                connection.Close();
            }

            return rowCount;
        }
        /// <summary>
        /// Get all orderdetails
        /// </summary>
        /// <returns></returns>
        public List<OrderDetail> OrderDetail_List()
        {
            List<OrderDetail> data = new List<OrderDetail>();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = @"select OrderID,ProductID,ProductName,Quantity,UnitPrice,Discount
                                        from View_OrderDetails";
                    cmd.CommandType = CommandType.Text; 
                    cmd.Connection = connection;
                    using (SqlDataReader dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        while (dbReader.Read())
                        {
                            data.Add(new OrderDetail()
                            {
                                OrderID = Convert.ToInt32(dbReader["OrderID"]),
                                ProductID = Convert.ToInt32(dbReader["ProductID"]),
                                ProductName = Convert.ToString(dbReader["ProductName"]),
                                Quantity = Convert.ToInt32(dbReader["Quantity"]),
                                UnitPrice = Convert.ToDouble(dbReader["UnitPrice"]),
                                Discount = Convert.ToDouble(dbReader["Discount"])
                            });
                        }
                    }

                }
                connection.Close();
            }
            return data;
        }
        /// <summary>
        /// Delete Order and orderdetails of these
        /// </summary>
        /// <param name="orderIDs"></param>
        /// <returns></returns>
        public bool Delete_Order(int[] orderIDs)
        {
            bool result = true;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = @"DELETE 
                                    FROM     Orders
                                    WHERE   (OrderID = @OrderID)";
                cmd.CommandType = CommandType.Text;
                cmd.Connection = connection;
                cmd.Parameters.Add("@OrderID", SqlDbType.Int);
                foreach (int orderID in orderIDs)
                {
                    cmd.Parameters["@OrderID"].Value = orderID;
                    cmd.ExecuteNonQuery();
                }
                connection.Close();
            }
            return result;
        }
    }
}
