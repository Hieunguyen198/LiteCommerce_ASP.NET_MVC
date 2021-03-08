using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LiteCommerce.BusinessLayers;
using LiteCommerce.DomainModels;

namespace LiteCommerce.Controllers
{
    public class CategoryController : Controller
    {
        public ActionResult Index()
        {
            return (View());
        }
      
    }
}