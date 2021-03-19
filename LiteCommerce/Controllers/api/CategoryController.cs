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
        /// Get all category in database
        /// </summary>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        
        public IHttpActionResult GetListCategory(string searchValue="")
        {
            return Ok(CatalogBLL.Category_List(searchValue));
        }
        /// <summary>
        /// Get a category by category id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public IHttpActionResult GetByID(int id)
        {
            return Ok(CatalogBLL.Get_Category(id));
        }
        /// <summary>
        /// Add new category
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        public IHttpActionResult Add([FromUri]Category data)
        {
            CatalogBLL.Add_Category(data);
            return Ok("Add Success");
        }
        /// <summary>
        /// Update information category
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public IHttpActionResult Edit([FromUri]Category data)
        {
            bool result = CatalogBLL.Update_Category(data);
            if (result == true)
            {
                return Ok("Edit Success");
            }
            else
            {
                return Ok("Failed: CategoryID not exist");
            }  
        }
        /// <summary>
        /// Delete a category
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public IHttpActionResult Delete(int id)
        {
            bool result = CatalogBLL.Delete_Category(id);
            if (result == true)
            {
                return Ok("Deleted");
            }
            else
            {
                return Ok("Failed: CategoryID not exist");
            }
        }
    }
}
