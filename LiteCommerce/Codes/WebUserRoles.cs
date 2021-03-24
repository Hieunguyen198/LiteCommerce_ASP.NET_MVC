using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LiteCommerce
{
    /// <summary>
    /// Định nghĩa danh sách các Role của user
    /// </summary>
    public class WebUserRoles
    {
        /// <summary>
        /// Không xác định
        /// </summary>
        public const string ANONYMOUS = "anonymous";
        /// <summary>
        /// Nhân viên
        /// </summary>
        public const string STAFF = "staff";
        /// <summary>
        /// Quản trị hệ thống
        /// </summary>
        public const string ADMINISTRATOR = "administrator";
        /// <summary>
        /// Quản lý đơn hàng
        /// </summary>
        public const string ORDERMANAGEMENT = "Order Management";
        /// <summary>
        /// Quản lý dữ liệu 
        /// </summary>
        public const string CATALOGMANAGEMENT = "Catalog Management";
    }
}