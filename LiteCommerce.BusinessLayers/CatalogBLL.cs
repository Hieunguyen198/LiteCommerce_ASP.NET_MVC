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
    public static class CatalogBLL
    {
        /// <summary>
        /// 
        /// </summary>
        private static ICategoryDAL CategoryDB { get; set; }
        /// <summary>
        /// 
        /// </summary>
        private static ICountryDAL CountryDB { get; set; }
        /// <summary>
        /// 
        /// </summary>
        private static ICustomerDAL CustomerDB { get; set; }
        private static IProductDAL ProductDB { get; set; }
        /// <summary>
        /// function  initialization 
        /// </summary>
        /// <param name="connectionString"></param>
        public static void Initialize(string connectionString)
        {
            CategoryDB = new CategoryDAL(connectionString);
            CountryDB = new CountryDAL(connectionString);
            CustomerDB = new CustomerDAL(connectionString);
            ProductDB = new ProductDAL(connectionString);
        }
        /// <summary>
        /// get list Countries
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
        /// <summary>
        /// Add customer
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static int Add_Customer(Customer data)
        {
            return CustomerDB.Add_Customer(data);
        }
        /// <summary>
        /// Update Customer
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static bool Update_Customer(Customer data)
        {
            return CustomerDB.Update_Customer(data);
        }
        /// <summary>
        /// Delete Customers
        /// </summary>
        /// <param name="CustomerIDs"></param>
        /// <returns></returns>
        public static bool Delete_Customer(string[] CustomerIDs)
        {
            return CustomerDB.Delete_Customer(CustomerIDs);
        }
        /// <summary>
        /// Get customer list by page, pageSieze and searchValue
        /// </summary>
        /// <param name="page"></param>
        /// <param name="pageSize"></param>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        public static List<Customer> Customers_List(int page, int pageSize, string searchValue)
        {
            return CustomerDB.Customer_List(page, pageSize, searchValue);
        }
        /// <summary>
        /// Get a Customer by CustomerID
        /// </summary>
        /// <param name="CustomerID"></param>
        public static Customer Get_Customer(string CustomerID)
        {
            return CustomerDB.Get_Customer(CustomerID);
        }
        /// <summary>
        /// Count customer in database by searchValue
        /// </summary>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        public static int Count_Customer(string searchValue)
        {
            return CustomerDB.Count_Customer(searchValue);
        }
        /// <summary>
        /// Add a product to database
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static int Add_Product(Product data)
        {
            return ProductDB.Add_Product(data);
        }
        /// <summary>
        /// Count product by searchName,searchCategory and searchPrice
        /// </summary>
        /// <param name="searchValue"></param>
        /// <param name="searchCategory"></param>
        /// <param name="searchPrice"></param>
        /// <returns></returns>
        public static int Count_Product(string searchValue, string searchCategory, string searchPrice)
        {
            return ProductDB.Count_Product(searchValue, searchCategory, searchPrice);
        }
        /// <summary>
        /// Delete one or more products
        /// </summary>
        /// <param name="productIDs"></param>
        /// <returns></returns>
        public static bool Delete_Product(int[] productIDs)
        {
            return ProductDB.Delete_Product(productIDs);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="productID"></param>
        /// <returns></returns>
        public static Product Get_Product(int productID)
        {
            return ProductDB.Get_Product(productID);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="page"></param>
        /// <param name="pageSize"></param>
        /// <param name="searchValue"></param>
        /// <param name="searchCategory"></param>
        /// <param name="searchPrice"></param>
        /// <returns></returns>
        public static List<Product> Product_List(int page,int pageSize, string searchValue, string searchCategory,string searchPrice)
        {
            return ProductDB.Product_List(page,pageSize,searchValue,searchCategory,searchPrice);
        }
        /// <summary>
        /// List Category Name in database
        /// </summary>
        /// <returns></returns>
        public static List<SelectList> List_Category()
        {
            return ProductDB.List_Category();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static bool Update_Product(Product data)
        {
            return ProductDB.Update_Product(data);
        }
    }

}
