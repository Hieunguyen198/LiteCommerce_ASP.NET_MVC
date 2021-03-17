using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using LiteCommerce.BusinessLayers;

namespace LiteCommerce.Controllers.api
{
    public class CustomerController : ApiController
    {
        public IHttpActionResult GetListCustomer(string searchValue = "", int page = 1)
        {
            return Ok(CatalogBLL.Customers_List(page, AppSettings.DefaultPageSize, searchValue));
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public IHttpActionResult GetByID(string id)
        {
            return Ok(CatalogBLL.Get_Customer(id));
        }
    }
}
