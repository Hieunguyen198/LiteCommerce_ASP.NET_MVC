﻿using System;
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
            listCities.Add(new SelectListItem() { Value = "Da Nang", Text = "Da Nang" });
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
            listPrices.Add(new SelectListItem() { Value = "10", Text = "More than 10$" });
            listPrices.Add(new SelectListItem() { Value = "20", Text = "More than 20$" });
            listPrices.Add(new SelectListItem() { Value = "30", Text = "More than 30$" });
            listPrices.Add(new SelectListItem() { Value = "40", Text = "More than 40$" });
            listPrices.Add(new SelectListItem() { Value = "50", Text = "More than 50$" });
            return listPrices;
        }
    }
}