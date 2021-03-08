﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using LiteCommerce.BusinessLayers;

namespace LiteCommerce.App_Start
{
    ///
    public static class BusinessLayerConfig
    {
        /// <summary>
        /// 
        /// </summary>
        public static void Initialize()
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["LiteCommerce"].ConnectionString;
            UserAccountBLL.Initialize(connectionString);
            EmployeeBLL.Initialize(connectionString);
        }
    }
}