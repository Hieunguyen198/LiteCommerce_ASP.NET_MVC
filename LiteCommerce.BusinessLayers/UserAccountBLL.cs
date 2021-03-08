using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LiteCommerce.DataLayers;
using LiteCommerce.DataLayers.SQLServer;
using LiteCommerce.DomainModels;

namespace LiteCommerce.BusinessLayers
{
    public class UserAccountBLL
    {
        /// <summary>
        /// 
        /// </summary>
        private static IUserAccountDAL userAccountDB { get; set; }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="connectionString"></param>
        public static void Initialize(string connectionString)
        {
            userAccountDB = new EmployeeUserAccountDAL(connectionString);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public static UserAccount Authorize(string userName, string password)
        {
            return userAccountDB.Authorize(userName, password);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <param name="newPWd"></param>
        /// <returns></returns>
        public static bool PWd_Update(string id, string newPWd)
        {
            return userAccountDB.PWd_Update(id, newPWd);
        }
    }
}
