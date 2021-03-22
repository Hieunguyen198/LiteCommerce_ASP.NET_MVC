using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Security;
using LiteCommerce.BusinessLayers;
using LiteCommerce.DomainModels;

namespace LiteCommerce.Controllers.api
{
    [Authorize]
    public class AccountController : ApiController
    {
        /// <summary>
        /// Check information login if login success set cookie 
        /// </summary>
        /// <param name="email"></param>
        /// <param name="pwd"></param>
        /// <returns></returns>
        [AllowAnonymous]
        public IHttpActionResult Login(string email, string pwd)
        {
            var userAccount = UserAccountBLL.Authorize(email, MD5.Encrypt(pwd), UserAccountTypes.Employee);
            if (userAccount != null)
            {
                WebUserData cookieData = new WebUserData()
                {
                    UserID = userAccount.UserID,
                    FullName = userAccount.FullName,
                    GroupName = userAccount.GroupName,
                    LoginTime = DateTime.Now,
                    SessionID = null,
                    ClientIP = null,
                    Photo = userAccount.Photo,
                    Title = userAccount.Title,
                    HireDate = userAccount.HireDate
                };
                FormsAuthentication.SetAuthCookie(cookieData.ToCookieString(), false);
                return Ok(cookieData);
            }
            return Ok("Login information not right!");
        }
        /// <summary>
        /// Get user login profile
        /// </summary>
        /// <returns></returns>
        public IHttpActionResult GetProfile()
        {
            WebUserData userData = User.GetUserData();
            return Ok(EmployeeBLL.Get_Employee(Convert.ToInt32(userData.UserID)));
        }
        /// <summary>
        /// Logout and clear cookie
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        public IHttpActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return Ok("Logout success!");
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <param name="newPWd"></param>
        /// <param name="currentPWd"></param>
        /// <returns></returns>
        [AllowAnonymous]
        public IHttpActionResult ChangePassword(string id, string newPWd, string currentPWd)
        {
            string result = "";
            Employee employee = EmployeeBLL.Get_Employee(Convert.ToInt32(id));
            if (employee.Password == MD5.Encrypt(currentPWd))
            {
                 UserAccountBLL.PWd_Update(id, MD5.Encrypt(newPWd));
                result = "Change password successfully";
            }
            else
            {
                result = "Current password not correct";
            }
            return Ok(result);
        }
    }
}
