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
    public static class CatalogBLL
    {
        private static ICategoryDAL CategoryDB { get; set; }
        private static ICountryDAL CountryDB { get; set; }
        /// <summary>
        /// function  initialization 
        /// </summary>
        /// <param name="connectionString"></param>
        public static void Initialize(string connectionString)
        {
            CategoryDB = new CategoryDAL(connectionString);
            CountryDB = new CountryDAL(connectionString);
        }
        /// <summary>
        /// get Countries
        /// </summary>
        /// <param name="categoryID"></param>
        /// <returns></returns>
        public static List<String> List_Country()
        {
            return CountryDB.List_Country();
        }
        /// <summary>
        /// Get an category by id
        /// </summary>
        /// <returns></returns>
        public static Category Get_Category(int categoryID)
        {
            return CategoryDB.Get_Category(categoryID);
        }
        /// <summary>
        /// get list category
        /// </summary>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        public static List<Category> Category_List(string searchValue)
        {
            return CategoryDB.Category_List(searchValue);
        }
        /// <summary>
        /// Count categories
        /// </summary>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        public static int Count_Category(string searchValue)
        {
            return CategoryDB.Count_Catogory(searchValue);
        }
        /// <summary>
        /// add an category
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static int Add_Category(Category data)
        {
            return CategoryDB.Add_Category(data);
        }
        /// <summary>
        /// update an category
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static bool Update_Category(Category data)
        {
            return CategoryDB.Update_Category(data);
        }
        /// <summary>
        /// Delete Categories
        /// </summary>
        /// <param name="categoryIDs"></param>
        /// <returns></returns>
        public static bool Delete_Category(int[] categoryIDs)
        {
            return CategoryDB.Delete_Category(categoryIDs);
        }
    }

}
