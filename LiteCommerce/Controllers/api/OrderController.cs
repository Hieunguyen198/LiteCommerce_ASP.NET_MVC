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
    }
}
