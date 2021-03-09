using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LiteCommerce.DomainModels;

namespace LiteCommerce.Models
{
    /// <summary>
    /// Model Category
    /// </summary>
    public class CategoryNoPagination
    {
        public List<Category> Data;
        public int RowCount;
    }
}