using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using LiteCommerce.BusinessLayers;

namespace LiteCommerce.Controllers.api
{
    public class OrderController : ApiController
    {
        public IHttpActionResult GetListOrder(string searchValue = "", int page = 1)
        {
            return Ok(OrderBLL.Order_List(page, AppSettings.OrderDefaultPageSize, searchValue));
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public IHttpActionResult GetListOrderDetail()
        {
            return Ok(OrderBLL.OrderDetail_List());
        }
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public IHttpActionResult GetDetailByOrderID(int id)
        {
            return Ok(OrderBLL.GetOrderDetail_By_OrderID(id));
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="orderIDs"></param>
        /// <returns></returns>
        public IHttpActionResult Delete(int id)
        {
            if (OrderBLL.GetOrderByID(id) == null)
            {
                return Ok("This order is not exists!");
            }
            else
            {
                OrderBLL.Delete_Order(Convert.ToInt32(id));
                return Ok("Delete success!");
            }

        }
        public IHttpActionResult Approval([FromUri]int[] ids)
        {

            foreach (int id in ids)
            {
                if (OrderBLL.GetOrderByID(id) == null)
                {
                    return Ok("This Order is not exists!");
                }
            }
            OrderBLL.Order_Approval(ids);
            return Ok("Approved!");

        }

    }
}
