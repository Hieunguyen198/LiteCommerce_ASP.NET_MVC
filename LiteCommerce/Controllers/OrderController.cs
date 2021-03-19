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
            if (model.RowCount != 0)
            {
                return View(model);

            }
            else
            {
                ModelState.AddModelError(string.Empty, "404. Can not find any Orders .404");
                return View(model);
            }
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

        [HttpGet] 
        public ActionResult Delete(string id=" " )
        {
            try
            {
                if (id != null)
                {
                    OrderBLL.Delete_Order(Convert.ToInt32(id));

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