using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using LiteCommerce.BusinessLayers;
using LiteCommerce.Codes;

namespace LiteCommerce.Controllers
{
    //[Authorize]
    public class AccountController : Controller
    {
        // GET: Account
        public ActionResult Index()
        {
            return View();
        }
        /// <summary>
        /// Check Login 
        /// </summary>
        /// <param name="email"></param>
        /// <param name="pwd"></param>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult Login(string email, string pwd)
        {
            if (Request.HttpMethod == "GET")
            {
                return View();
            }
            else
            {
                var userAccount = UserAccountBLL.Authorize(email, pwd);

                if (userAccount != null)
                {
                    WebUserData cookieData = new WebUserData()
                    {
                        UserID = userAccount.UserID,
                        FullName = userAccount.FullName,
                        GroupName = userAccount.GroupName,
                        LoginTime = DateTime.Now,
                        SessionID = Session.SessionID,
                        ClientIP = Request.UserHostAddress,
                        Photo = userAccount.Photo,
                        Title = userAccount.Title
                    };
                    FormsAuthentication.SetAuthCookie(cookieData.ToCookieString(), false);
                    return RedirectToAction("Index", "Dashboard");
                }
                else
                {
                    ModelState.AddModelError("", "Login information not right");//lưu lại thông báo lỗi vào ""
                    ViewBag.Email = email;
                    return View();
                }

            }
        }
        /// <summary>
        /// Thay đổi mật khẩu
        /// </summary>
        /// <returns></returns>
        public ActionResult ChangePWd()
        {
            return View();
        }
        /// <summary>
        /// Singout
        /// </summary>
        /// <returns></returns>
        public ActionResult Signout()
        {
            Session.Abandon();
            Session.Clear();
            FormsAuthentication.SignOut();
            return RedirectToAction("Login", "Account");
        }
    }
}