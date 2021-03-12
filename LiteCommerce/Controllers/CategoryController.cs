using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LiteCommerce.BusinessLayers;
using LiteCommerce.DomainModels;

namespace LiteCommerce.Controllers
{
    [Authorize]
    public class CategoryController : Controller
    {
        /// <summary>
        /// Trang quản lý loại sản phẩm
        /// </summary>
        /// <returns></returns>
        public ActionResult index()
        {
            return View();
        }
        public JsonResult List(string searchValue = "")
        {
            return Json(CatalogBLL.Category_List(searchValue),JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// Trang thêm mới hoặc chính sửa loại sản phẩm
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult Input(string id = "")
        {
            // ViewBag.Title = "Edit Category";
            //Category editCategory = CatalogBLL.Get_Category(Convert.ToInt32(id));
            //if (editCategory == null)
            //  return RedirectToAction("Index");
            //return View(editCategory);
            return Json(CatalogBLL.Get_Category(Convert.ToInt32(id)), JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult Input(Category model)
        {
            try
            {
                ViewBag.Title = "EDIT EMPLOYEE";
                ViewBag.Success = "EDIT SUCCESS";
                bool result = CatalogBLL.Update_Category(model);
                return View(model);
            }
            catch
            {
                return View();
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
 
        public JsonResult Add(Category model)
        {
            return Json(CatalogBLL.Add_Category(model), JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="method"></param>
        /// <param name="categoryIDs"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Delete(string method = "", int[] categoryIDs = null)
        {
            try
            {
                if (categoryIDs != null)
                {
                    CatalogBLL.Delete_Category(categoryIDs);
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