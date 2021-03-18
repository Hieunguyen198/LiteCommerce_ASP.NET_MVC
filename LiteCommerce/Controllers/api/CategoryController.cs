using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using LiteCommerce.BusinessLayers;
using LiteCommerce.DomainModels;

namespace LiteCommerce.Controllers.api
{
    public class CategoryController : ApiController
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        public IHttpActionResult GetListCategory(string searchValue="")
        {
            return Ok(CatalogBLL.Category_List(searchValue));
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public IHttpActionResult GetByID(int id)
        {
            return Ok(CatalogBLL.Get_Category(id));
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        public IHttpActionResult AddNewCategory([FromUri]Category data)
        { 
            return Ok(CatalogBLL.Add_Category(data));
        }
    }
}
