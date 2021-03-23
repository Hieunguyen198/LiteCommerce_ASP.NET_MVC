using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using LiteCommerce.BusinessLayers;

namespace LiteCommerce.Controllers.api
{
    public class DashboardController : ApiController
    {
        /// <summary>
        /// Get monthly revenue by year
        /// </summary>
        /// <param name="year"></param>
        /// <returns></returns>
        public IHttpActionResult GetRevenueByYear(int year)
        {
            return Ok(DashBoardBLL.RevenueStatisticsByYear(year));
        }
        /// <summary>
        /// Get mothly Orderstatic by year
        /// </summary>
        /// <param name="year"></param>
        /// <returns></returns>
        public IHttpActionResult GetOrderStaticByYear(int year)
        {
            return Ok(DashBoardBLL.OrderStatisticsByYear(year));
        }
        public IHttpActionResult GetDiscountStatisticsByYear(int year)
        {
            return Ok(DashBoardBLL.DiscountStatisticsByYear(year));
        }
    }
}
