using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LiteCommerce.BusinessLayers;
using LiteCommerce.DomainModels;

namespace LiteCommerce.Controllers
{
    /// <summary>
    /// 
    /// </summary>
    [Authorize]
    public class DashboardController : Controller
    {
        /// <summary>
        /// Trang xem dashboard chung 
        /// </summary>
        /// <returns></returns>
        public ActionResult Index(int year = 2021)
        {
            var model = new Models.DashBoardModel
            {
                OrderDashBoard = DashBoardBLL.OrderStatisticsByYear(year),
                RevenueDashBoard = DashBoardBLL.RevenueStatisticsByYear(year),
                TotalDiscount = DashBoardBLL.DiscountStatisticsByYear(year)
            };
            return View(model);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="year"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult Input(int year)
        {
            Dashboard orderDashboard = DashBoardBLL.RevenueStatisticsByYear(year);
            return Json(new
            {
                result = orderDashboard
            }, JsonRequestBehavior.AllowGet);
        }
    }
}