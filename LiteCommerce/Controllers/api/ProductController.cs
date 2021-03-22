using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using LiteCommerce.BusinessLayers;
using LiteCommerce.DomainModels;

namespace LiteCommerce.Controllers.api
{
    public class ProductController : ApiController
    {
        public IHttpActionResult GetListProduct(string searchValue = "", int page = 1, int pageSize = 5, string searchCountry = "", string searchCategory = "", string searchPrice = "")
        {
            return Ok(CatalogBLL.Product_List(page, pageSize, searchValue, searchCategory, searchPrice));
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
        /// <summary>
        /// 
        /// </summary>
        /// <param name="data"></param>
        /// <param name="uploadPhoto"></param>
        /// <returns></returns>
        public IHttpActionResult Add([FromUri]Product data, HttpPostedFileBase uploadPhoto)
        {
            if (string.IsNullOrEmpty(data.Descriptions))
                data.Descriptions = "";
            if (string.IsNullOrEmpty(data.PhotoPath))
                data.PhotoPath = "";
            if (uploadPhoto != null)
            {
                string path = Path.Combine(HttpContext.Current.Server.MapPath("~/Images/"), Path.GetFileName(uploadPhoto.FileName));
                uploadPhoto.SaveAs(path);
                data.PhotoPath = "Images/" + Path.GetFileName(uploadPhoto.FileName);
            }
            int productID = CatalogBLL.Add_Product(data);
            if (productID > 0)
            {
                return Ok("Add success");
            }
            else
            {
                return Ok("CategoryID is not exists!");
            }

        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="data"></param>
        /// <param name="uploadPhoto"></param>
        /// <returns></returns>
        public IHttpActionResult Edit([FromUri]Product data, HttpPostedFileBase uploadPhoto)
        {
            if (string.IsNullOrEmpty(data.Descriptions))
                data.Descriptions = "";
            if (string.IsNullOrEmpty(data.PhotoPath))
                data.PhotoPath = "";
            if (uploadPhoto != null)
            {
                string path = Path.Combine(HttpContext.Current.Server.MapPath("~/Images/"), Path.GetFileName(uploadPhoto.FileName));
                uploadPhoto.SaveAs(path);
                data.PhotoPath = "Images/" + Path.GetFileName(uploadPhoto.FileName);
            }
            bool result = CatalogBLL.Update_Product(data);
            if (result == true)
            {
                return Ok("Edit success");
            }
            else
            {
                return Ok("ProductId is not exists!");
            }

        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public IHttpActionResult Delete([FromUri]int[] ids)
        {
            foreach (int id in ids)
            {
                if (CatalogBLL.Get_Product(id) == null)
                {
                    return Ok("ProductID is not exists");
                }
            }
            CatalogBLL.Delete_Product(ids);
            return Ok("Delete successfully!");
        }

    }
}
