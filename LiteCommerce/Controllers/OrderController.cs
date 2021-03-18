using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LiteCommerce.BusinessLayers;

namespace LiteCommerce.Controllers
{
    [Authorize]
    public class OrderController : Controller
    {
        /// <summary>
        /// Trang quản lý đơn đặt hàng
        /// </summary>
        /// <returns></returns>
        //[Authorize(Roles = WebUserRoles.ORDERMANAGEMENT)]
        [Authorize]
        public ActionResult Index(int page = 1, string searchValue = "")
        {
            var model = new Models.OrderPaginationResult
            {
                Page = page,
                PageSize = AppSettings.OrderDefaultPageSize,
                SearchValue = searchValue,
                RowCount = OrderBLL.Count_Order(searchValue),
                Data = OrderBLL.Order_List(page, AppSettings.OrderDefaultPageSize, searchValue)
            };
            return View(model);
        }
        /// <summary>
        /// Get orderdetail by orderID
        /// </summary>
        /// <param name="OrderID"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult GetOrderDetailByID(int OrderID)
        {
            return Json(OrderBLL.GetOrderDetail_By_OrderID(OrderID), JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// Trang tạo mới sản phẩm
        /// </summary>
        /// <returns></returns>

        [HttpPost] 
        public ActionResult Delete(int[] orderIDs = null)
        {
            try
            {
                if (orderIDs != null)
                {
                    OrderBLL.Delete_Order(orderIDs);

                }
                return RedirectToAction("Index");
            }
            catch
            {
                return RedirectToAction("Index");
            }

        }
        [HttpPost]
        public ActionResult Approval(int[] orderIDs)
        {

            try
            {
                if (orderIDs != null)
                {
                    OrderBLL.Order_Approval(orderIDs);

                }
                return RedirectToAction("Index");
            }
            catch
            {
                return RedirectToAction("Index");
            }

        }
    }
}