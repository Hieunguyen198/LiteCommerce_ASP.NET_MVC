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
    /// <summary>
    /// 
    /// </summary>
    public static class DashBoardBLL
    {
        /// <summary>
        /// 
        /// </summary>
        private static IDashboardDAL DashBoardDB { get; set; }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="connectionString"></param>
        public static void Initialize(string connectionString)
        {
            DashBoardDB = new DashboardDAL(connectionString);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="year"></param>
        /// <returns></returns>
        public static Dashboard OrderStatisticsByYear(int year)
        {
            return DashBoardDB.OrderStatisticsByYear(year);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="year"></param>
        /// <returns></returns>
        public static Dashboard RevenueStatisticsByYear(int year)
        {
            return DashBoardDB.RevenueStatisticsByYear(year);
        }
        /// <summary>
        /// Discount Statistics
        /// </summary>
        /// <param name="year"></param>
        /// <returns></returns>
        public static Dashboard DiscountStatisticsByYear(int year)
        {
            return DashBoardDB.DiscountStatisticsByYear(year);
        }
    }
}
