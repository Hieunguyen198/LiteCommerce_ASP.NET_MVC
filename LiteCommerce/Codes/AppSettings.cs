using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace LiteCommerce
{
    public static class AppSettings
    {
        public static int defaultPageSize
        {
            get
            {
                return Convert.ToInt32(ConfigurationManager.AppSettings["DefaultPageSizeValue"]);
            }
        }

    }
}