using System;
using System.Collections.Generic;
using System.IO;
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
    public class ProductController : Controller
    {
        /// <summary>
        /// Direct to Product  index 
        /// </summary>
        /// <returns></returns>
        public ActionResult Index(int page =1,string searchValue="",string searchCategory="",string searchPrice="")
        {
            var model = new Models.ProductPaginationResult()
            {
                Page = page,
                PageSize = AppSettings.DefaultPageSize,
                searchValue = searchValue,
                searchPrice = searchPrice,
                searchCategory =searchCategory,
                RowCount = CatalogBLL.Count_Product(searchValue, searchCategory, searchPrice),
                Data = CatalogBLL.Product_List(page, AppSettings.DefaultPageSize, searchValue, searchCategory, searchPrice)
            };
            if (model.RowCount != 0)
            {
                return View(model);

            }
            else
            {
                ModelState.AddModelError(string.Empty, "404. Can not find any Product");
                return View(model);
            }
        }
        /// <summary>
        /// Trang tạo mới chỉnh sứa sản phẩm
        /// </summary>
        /// <param name="id">Nếu có truyền id thì chỉnh sửa ngược lại là thêm mới</param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Input(string id = "")
        {
            if (string.IsNullOrEmpty(id))
            {
                ViewBag.Title = "ADD NEW PRODUCT";
                Product newProduct = new Product();
                newProduct.ProductID = 0;
                return View(newProduct);
            }
            else
            {
                ViewBag.Title = "EDIT PRODUCT";
                Product editProduct = CatalogBLL.Get_Product(Convert.ToInt32(id));
                if (editProduct == null)
                    return RedirectToAction("Index");
                return View(editProduct);
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="model"></param>
        /// <param name="uploadPhoto"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Input(Product model, HttpPostedFileBase uploadPhoto)
        {
            try
            {


                //Kiểm tra dữ liệu đầu vào
                if (string.IsNullOrEmpty(model.Descriptions))
                    model.Descriptions = "";
                if (string.IsNullOrEmpty(model.PhotoPath))
                    model.PhotoPath = "";
                if (uploadPhoto != null)
                {
                    string path = Path.Combine(Server.MapPath("~/Images/"), Path.GetFileName(uploadPhoto.FileName));
                    uploadPhoto.SaveAs(path);
                    model.PhotoPath = "Images/" + Path.GetFileName(uploadPhoto.FileName);
                }
                //xử lý để đưa dữ liệu vào DB
                if (model.ProductID == 0)
                {
                    int productID = CatalogBLL.Add_Product(model);
                    return RedirectToAction("Input");
                }
                else
                {
                    ViewBag.Title = "EDIT PRODUCT";
                    ViewBag.Success = "EDIT SUCCESS";
                    bool result = CatalogBLL.Update_Product(model);
                    return View(model);
                }
            }
            catch
            {
                return RedirectToAction("Index");
            }
            
           
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="method"></param>
        /// <param name="productIDs"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Delete(string method = "", int[] productIDs = null)
        {
            try
            {
                if (productIDs != null)
                {
                    CatalogBLL.Delete_Product(productIDs);

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