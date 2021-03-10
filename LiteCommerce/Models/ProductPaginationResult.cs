using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LiteCommerce.DomainModels;

namespace LiteCommerce.Models
{
    public class ProductPaginationResult: PaginationResult
    {
        public List<Product> Data;
        public string searchValue;
        public string searchCategory;
        public string searchPrice;

    }
}