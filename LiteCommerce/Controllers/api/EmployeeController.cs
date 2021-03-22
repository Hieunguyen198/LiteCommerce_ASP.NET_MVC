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
    public class EmployeeController : ApiController
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="searchValue"></param>
        /// <param name="page"></param>
        /// <param name="searchCountry"></param>
        /// <returns></returns>
        public IHttpActionResult GetListEmployee(string searchValue = "", int page = 1, string searchCountry = "")
        {
            return Ok(EmployeeBLL.Employee_List(page, AppSettings.DefaultPageSize, searchValue, searchCountry));
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public IHttpActionResult GetByID(int id)
        {
            return Ok(EmployeeBLL.Get_Employee(id));
        }
        public IHttpActionResult Add([FromUri]Employee data, HttpPostedFileBase uploadPhoto)
        {

            if (string.IsNullOrEmpty(data.Address))
                data.Address = "";
            if (string.IsNullOrEmpty(data.City))
                data.City = "";
            if (string.IsNullOrEmpty(data.Country))
                data.Country = "";
            if (string.IsNullOrEmpty(data.Notes))
                data.Notes = "";
            if (string.IsNullOrEmpty(data.PhotoPath))
                data.PhotoPath = "";
            if (uploadPhoto != null)
            {
                string path = Path.Combine(HttpContext.Current.Server.MapPath("~/Images/"), Path.GetFileName(uploadPhoto.FileName));
                uploadPhoto.SaveAs(path);
                data.PhotoPath = "Images/" + Path.GetFileName(uploadPhoto.FileName);
            }
            //Check email
            if (EmployeeBLL.Check_Email(data.Email) != null)
            {
                return Ok("Email is already exists!");
            }
            EmployeeBLL.Add_Employee(data);
            return Ok("Add success!");
        }
        public IHttpActionResult Edit([FromUri]Employee data, HttpPostedFileBase uploadPhoto)
        {

            if (string.IsNullOrEmpty(data.Address))
                data.Address = "";
            if (string.IsNullOrEmpty(data.City))
                data.City = "";
            if (string.IsNullOrEmpty(data.Country))
                data.Country = "";
            if (string.IsNullOrEmpty(data.Notes))
                data.Notes = "";
            if (string.IsNullOrEmpty(data.PhotoPath))
                data.PhotoPath = "";
            if (uploadPhoto != null)
            {
                string path = Path.Combine(HttpContext.Current.Server.MapPath("~/Images/"), Path.GetFileName(uploadPhoto.FileName));
                uploadPhoto.SaveAs(path);
                data.PhotoPath = "Images/" + Path.GetFileName(uploadPhoto.FileName);
            }
            //check EmployeeID
            if (EmployeeBLL.Get_Employee(data.EmployeeID) == null)
            {
                return Ok("EmployeID is not exists");
            }
            //Check email
            if (EmployeeBLL.Check_Email(data.Email).EmployeeID != data.EmployeeID)
            {
                return Ok("Email is already exists!");
            }
            else
            {
                EmployeeBLL.Update_Employee(data);
                return Ok("Edit success!");
            }

        }
        public IHttpActionResult Delete([FromUri]int[] ids)
        {
            int i = 0;
            foreach (int id in ids)
            {
                if (EmployeeBLL.Get_Employee(id) == null)
                {
                    return Ok("EmployeID is not exists");
                }
                i++;
            }
            EmployeeBLL.Delete_Employee(ids);
            return Ok("Deleted ("+i+") successfully!");
        }

    }
}
