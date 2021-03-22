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
        /// <summary>
        /// 
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public IHttpActionResult Add([FromUri]Customer data)
        {
            string result = "";
            if (CatalogBLL.Get_Customer(data.CustomerID) != null)
            {
                result = "CustomerID is already exists!";
            }
            else
            {
                CatalogBLL.Add_Customer(data);
                result = "Add success!";
            }
            return Ok(result);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public IHttpActionResult Edit([FromUri]Customer data)
        {
            string result = "";
            if (CatalogBLL.Get_Customer(data.CustomerID) == null)
            {
                result = "CustomerID is not exists!";
            }
            else
            {
                CatalogBLL.Update_Customer(data);
                result = "Edit success!";
            }
            return Ok(result);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public IHttpActionResult Delete([FromUri]string[] ids)
        {
            int i = 0;
            foreach(string id in ids)
            {
                if (CatalogBLL.Get_Customer(id) == null)
                {
                    return Ok("CustomerID is not exists");
                }
                i++;
            }
            CatalogBLL.Delete_Customer(ids);
            return Ok("Deleted (" + i + ") successfully!");
        }

    }
}
