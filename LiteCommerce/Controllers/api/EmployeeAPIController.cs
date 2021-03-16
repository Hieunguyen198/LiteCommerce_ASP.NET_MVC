using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using LiteCommerce.BusinessLayers;
using LiteCommerce.DomainModels;

namespace LiteCommerce.Controllers
{
    public class EmployeeAPIController : ApiController
    {
        public IHttpActionResult Get(int id)
        { 
            return Ok(EmployeeBLL.Get_Employee(Convert.ToInt32(id)));
        }
        public IHttpActionResult Get
    }
}
