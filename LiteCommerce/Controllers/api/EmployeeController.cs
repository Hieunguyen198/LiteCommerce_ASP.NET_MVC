using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using LiteCommerce.BusinessLayers;

namespace LiteCommerce.Controllers.api
{
    public class EmployeeController : ApiController
    {
        public IHttpActionResult GetListEmployee(string searchValue = "",int page=1,string searchCountry="")
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
    }
}
