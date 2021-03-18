﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LiteCommerce.DomainModels;

namespace LiteCommerce.DataLayers
{
    /// <summary>
    /// 
    /// </summary>
    public interface IOrderDAL
    {
        /// <summary>
        /// Lấy danh sách đơn hàng
        /// </summary>
        /// <param name="page"></param>
        /// <param name="pageSize"></param>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        List<Order> Order_List(int page, int pageSize, string searchValue);
        /// <summary>
        /// Đếm số lượng đơn hàng
        /// </summary>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        int Count_Order(string searchValue);
        /// <summary>
        /// lấy dánh sách chi tiết đơn hàng
        /// </summary>
        /// <returns></returns>
        List<OrderDetail> OrderDetail_List();
        /// <summary>
        /// Xóa đơn hàng sẽ xóa luôn chi tiết đơn hàng đó
        /// </summary>
        /// <param name="orderIDs"></param>
        /// <returns></returns>
        List<OrderDetail> GetOrderDetail_By_OrderID(int orderID);
        bool Delete_Order(int[] orderIDs);
        /// <summary>
        /// Approval Order by orderID
        /// </summary>
        /// <param name="orderIDs"></ param>
        /// <returns></returns>
        bool Order_Approval(int[] orderIDs);
    }
}
