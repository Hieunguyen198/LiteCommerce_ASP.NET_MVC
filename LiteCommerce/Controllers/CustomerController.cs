using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LiteCommerce.BusinessLayers;
using LiteCommerce.DomainModels;

namespace LiteCommerce.Controllers
{
    [Authorize]
    public class CustomerController : Controller
    {
        /// <summary>
        /// Direct to Customer Index
        /// </summary>
        /// <returns></returns>
        public ActionResult Index(int page = 1, string searchValue = "", string searchCountry = "")
        {
            var model = new Models.CustomerPaginationResult()
            {
                Page = page,
                PageSize = AppSettings.DefaultPageSize,
                SearchValue = searchValue,
                RowCount = CatalogBLL.Count_Customer(searchValue),
                Data = CatalogBLL.Customers_List(page, AppSettings.DefaultPageSize, searchValue)
            };
            return View(model);
        }
        [HttpGet]
        public ActionResult Input(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                ViewBag.Title = "ADD NEW CUSTOMER";
                ViewBag.Method = "Add";
                Customer newCustomer = new Customer();
                newCustomer.CustomerID = "";
                return View(newCustomer);
            }
            else
            {
                ViewBag.Title = "EDIT CUSTOMER";
                Customer editCustomer = CatalogBLL.Get_Customer(id);
                if (editCustomer == null)
                    return RedirectToAction("Index");
                return View(editCustomer);
            }
        }
        /// <summary>
        /// Add or edit customer
        /// </summary>
        /// <param name="model"></param>
        /// <param name="method"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Input(Customer model, string method)
        {
            try
            {
                //Kiểm tra dữ liệu đầu vào
                if (string.IsNullOrEmpty(model.ContactTitle))
                    model.ContactTitle = "";
                if (string.IsNullOrEmpty(model.ContactName))
                    model.ContactName = "";
                if (string.IsNullOrEmpty(model.Address))
                    model.Address = "";
                if (string.IsNullOrEmpty(model.City))
                    model.City = "";
                if (string.IsNullOrEmpty(model.Country))
                    model.Country = "";
                if (string.IsNullOrEmpty(model.Phone))
                    model.Phone = "";
                if (string.IsNullOrEmpty(model.Fax))
                    model.Fax = "";
                if (method == "Add")
                {

                    if (CatalogBLL.Get_Customer(model.CustomerID) != null)
                    {
                        ViewBag.Method = "Add";
                        ViewBag.Title = "ADD NEW CUSTOMER";
                        ModelState.AddModelError("", "ID already exists!");
                        return View(model);
                    }
                    else
                    {
                        int resultAddCustomer = CatalogBLL.Add_Customer(model);
                        return RedirectToAction("Index");
                    }

                }
                else
                {
                    ViewBag.Title = "EDIT EMPLOYEE";
                    ViewBag.Success = "EDIT SUCCESS";
                    bool resultUpdateCustomer = CatalogBLL.Update_Customer(model);
                    return View(model);
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", ex.StackTrace);
                return View(model);
            }
        }
        [HttpPost]
        public ActionResult Delete(string method = "", string[] customerIDs = null)
        {
            try
            {
                if (customerIDs != null)
                {
                    CatalogBLL.Delete_Customer(customerIDs);
                }
                return RedirectToAction("Index");
            }
            catch
            {
                return RedirectToAction("Index");
            }

        }
    }
}