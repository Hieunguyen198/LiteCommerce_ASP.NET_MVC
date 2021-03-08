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
    public class OrderDetail
    {
        /// <summary>
        /// 
        /// </summary>
        public int OrderID { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int ProductID { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public double UnitPrice { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int Quantity { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public double Discount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ProductName { get; set; }
        /// <summary>
        /// Return Total 
        /// </summary>
        public double Total()
        {
            return UnitPrice * Quantity - (UnitPrice * Quantity) * Discount;
        }
    }
}
