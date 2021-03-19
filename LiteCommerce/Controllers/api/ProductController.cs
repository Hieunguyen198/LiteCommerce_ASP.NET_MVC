using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using LiteCommerce.BusinessLayers;

namespace LiteCommerce.Controllers.api
{
    public class ProductController : ApiController
    {
        public IHttpActionResult GetListProduct(string searchValue = "", int page = 1,int pageSize= 5, string searchCountry = "",string searchCategory="",string searchPrice="")
        {
            return Ok(CatalogBLL.Product_List(page, pageSize, searchValue,searchCategory,searchPrice));
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public IHttpActionResult GetByID(int id)
        {
            return Ok(CatalogBLL.Get_Product(id));
        }
    }
}
