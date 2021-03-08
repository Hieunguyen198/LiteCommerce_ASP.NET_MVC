using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LiteCommerce.DomainModels;

namespace LiteCommerce.DataLayers
{
    /// <summary>
    /// 
    /// </summary>
    public interface IUserAccountDAL
    {
        /// <summary>
        /// Kiểm tra thông tin đăng nhập của user 
        /// - Nếu hợp lệ hàm trả về thông tin của user 
        /// - Nếu không hợp lệ trả về null
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        UserAccount Authorize(string userName, string password);
        /// <summary>
        /// Change PWd  
        /// </summary>
        bool PWd_Update(string id, string newPWd);
    }
}
