using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LiteCommerce.BusinessLayers;

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
                PageSize = AppSettings.defaultPageSize,
                searchValue = searchValue,
                searchPrice = searchPrice,
                searchCategory =searchCategory,
                RowCount = CatalogBLL.Count_Product(searchValue, searchCategory, searchPrice),
                Data = CatalogBLL.Product_List(page, AppSettings.defaultPageSize, searchValue, searchCategory, searchPrice)
            };
            return View(model);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public ActionResult Input()
        {
            return View();
        }
    }
}