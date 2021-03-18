using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LiteCommerce.DomainModels
{
    /// <summary>
    /// 
    /// </summary>
    public class Order
    {
        /// <summary>
        /// 
        /// </summary>
        public int OrderID { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string CustomerID { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int EmployeeID { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public DateTime OrderDate { get; set; }
        /// <summary>
        /// Buying Customer
        /// </summary>
        public string CustomerName { get; set; }
        /// <summary>
        /// Billing Employee
        /// </summary>
        public string EmployeeName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public Boolean Status { get; set; }
    }
}
