using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LiteCommerce.DomainModels;

namespace LiteCommerce.Models
{
    public class OrderPaginationResult:PaginationResult
    {
        public List<Order> Data;
    }
}