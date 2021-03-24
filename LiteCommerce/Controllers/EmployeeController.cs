using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LiteCommerce.BusinessLayers;
using LiteCommerce.DomainModels;

namespace LiteCommerce.Controllers
{
    /// <summary>
    /// 
    /// </summary>
    [Authorize(Roles = "administrator")]
    public class EmployeeController : Controller
    {
        /// <summary>
        /// Trang quản lý nhân viên
        /// </summary>
        /// <returns></returns>
        public ActionResult Index(int page = 1, string searchValue = "", string searchCountry = "")
        {
            var model = new Models.EmployeePaginationResult()
            {
                Page = page,
                PageSize = AppSettings.DefaultPageSize,
                SearchValue = searchValue,
                searchCountry = searchCountry,
                RowCount = EmployeeBLL.Count_Employee(searchValue, searchCountry),
                Data = EmployeeBLL.Employee_List(page, AppSettings.DefaultPageSize, searchValue, searchCountry)
            };
            if (model.RowCount != 0)
            {
                return View(model);

            }
            else
            {
                ModelState.AddModelError(string.Empty, "404. Can not find any Employees .404");
                return View(model);
            }
        }
        /// <summary>
        /// Trang thêm mới hoặc chỉnh sửa thông tin nhân viên
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Input(String id = "")
        {
            if (string.IsNullOrEmpty(id))
            {
                ViewBag.Title = "ADD NEW EMPLOYEE";
                Employee newEmployee = new Employee();
                newEmployee.EmployeeID = 0;
                return View(newEmployee);
            }
            else
            {
                ViewBag.Title = "EDIT EMPLOYEE";
                Employee editEmployee = EmployeeBLL.Get_Employee(Convert.ToInt32(id));
                if (editEmployee == null)
                    return RedirectToAction("Index");
                return View(editEmployee);
            }
        }
        [HttpPost]
        public ActionResult Input(Employee model, HttpPostedFileBase uploadPhoto)
        {
            try
            {
                //Kiểm tra dữ liệu đầu vào
                if (string.IsNullOrEmpty(model.Address))
                    model.Address = "";
                if (string.IsNullOrEmpty(model.City))
                    model.City = "";
                if (string.IsNullOrEmpty(model.Country))
                    model.Country = "";
                if (string.IsNullOrEmpty(model.Notes))
                    model.Notes = "";
                if (string.IsNullOrEmpty(model.PhotoPath))
                    model.PhotoPath = "";
                if (string.IsNullOrEmpty(model.GroupName))
                {
                    ViewBag.Title = "ADD NEW EMPLOYEE";
                    ModelState.AddModelError("roles", "You need choice roles!");
                    return View(model);
                }
                if (uploadPhoto != null)
                {
                    string path = Path.Combine(Server.MapPath("~/Images/"), Path.GetFileName(uploadPhoto.FileName));
                    uploadPhoto.SaveAs(path);
                    model.PhotoPath = "Images/" + Path.GetFileName(uploadPhoto.FileName);
                }
                //xử lý để đưa dữ liệu vào DB
                Employee data = EmployeeBLL.Check_Email(model.Email);
                if (model.EmployeeID == 0)//add
                {

                    if (data != null)//check email
                    {
                        ViewBag.Method = "Add";
                        ViewBag.Title = "ADD NEW EMPLOYEE";
                        ModelState.AddModelError("Email", "Email already exists!");
                        return View(model);
                    }
                    else
                    {
                        ViewBag.Title = "ADD NEW EMPLOYEE";
                        int employeeID = EmployeeBLL.Add_Employee(model);
                        Employee newE = new Employee();
                        ViewBag.Success = "ADDED!";
                        return View(newE);
                    }
                }
                else //Edit
                {
                    if (data==null)
                    {
                        ViewBag.Title = "EDIT EMPLOYEE";
                        ViewBag.Success = "EDIT SUCCESS!";
                        bool result = EmployeeBLL.Update_Employee(model);
                        return View(model);
                    }
                        if (data.EmployeeID != model.EmployeeID)
                    {
                        ViewBag.Method = "Edit";
                        ViewBag.Title = "EDIT EMPLOYEE";
                        ModelState.AddModelError("Email", "Email already exists!");
                        return View(model);
                    }
                    else
                    {
                        ViewBag.Title = "EDIT EMPLOYEE";
                        ViewBag.Success = "EDIT SUCCESS!";
                        bool result = EmployeeBLL.Update_Employee(model);
                        return View(model);
                    }
                }
            }
            catch
            {
                ViewBag.Title = "ADD NEW EMPLOYEE";
                ModelState.AddModelError("date", "Please check date!");
                return View(model);
            }
        }
        [HttpPost]
        public ActionResult Delete(string method = "", int[] employeeIDs = null)
        {
            try
            {
                if (employeeIDs != null)
                {
                    EmployeeBLL.Delete_Employee(employeeIDs);

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