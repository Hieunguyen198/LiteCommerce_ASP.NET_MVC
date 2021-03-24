using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LiteCommerce.BusinessLayers;

namespace LiteCommerce
{
    public static class SelectListHelper
    {
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public static List<SelectListItem> ListOfCountries()
        {
            List<string> listCountry = CatalogBLL.List_Country();
            List<SelectListItem> listCountries = new List<SelectListItem>();
            foreach (string item in listCountry)
            {
                listCountries.Add(new SelectListItem() { Value = item, Text = item });
            }
            return listCountries;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public static List<SelectListItem> ListOfcities()
        {
            List<SelectListItem> listCities = new List<SelectListItem>();
            listCities.Add(new SelectListItem() { Value = "Hue", Text = "Hue" });
            listCities.Add(new SelectListItem() { Value = "Ha Noi", Text = "Ha Noi" });
            listCities.Add(new SelectListItem() { Value = "Ho Chi Minh", Text = "Ho Chi Minh" });
            listCities.Add(new SelectListItem() { Value = "Quang Nam", Text = "Quang Nam" });
            listCities.Add(new SelectListItem() { Value = "Ha Long", Text = "Ha Long" });
            listCities.Add(new SelectListItem() { Value = "Binh Thuan", Text = "Binh Thuan" });
            listCities.Add(new SelectListItem() { Value = "Hai Duong", Text = "Hai Duong" });
            return listCities;
        }
        public static List<SelectListItem> ListOfCategories()
        {
            List<SelectListItem> listCategorys = new List<SelectListItem>();
            foreach (var item in CatalogBLL.List_Category())
            {
                listCategorys.Add(new SelectListItem() { Value = item.Value.ToString(), Text = item.Text });
            }

            return listCategorys;
        }
        /// <summary>
        /// Clean code (refactor)
        /// </summary>
        /// <returns></returns>
        public static List<SelectListItem> ListOfPrices()
        {
            List<SelectListItem> listPrices = new List<SelectListItem>();
            listPrices.Add(new SelectListItem() { Value = "10", Text = "More Than 10$" });
            listPrices.Add(new SelectListItem() { Value = "20", Text = "More Than 20$" });
            listPrices.Add(new SelectListItem() { Value = "30", Text = "More Than 30$" });
            listPrices.Add(new SelectListItem() { Value = "40", Text = "More Than 40$" });
            listPrices.Add(new SelectListItem() { Value = "50", Text = "More Than 50$" });
            return listPrices;
        }
        public static List<SelectListItem> ListRoles()
        {
            List<SelectListItem> Listroles = new List<SelectListItem>();
            Listroles.Add(new SelectListItem() { Value = "administrator", Text = "administrator" });
            Listroles.Add(new SelectListItem() { Value = "Order Management", Text = "Order Management" });
            Listroles.Add(new SelectListItem() { Value = "Catalog Management", Text = "Catalog Management" });
            return Listroles;
        }
    }
}