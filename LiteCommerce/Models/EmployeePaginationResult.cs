using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LiteCommerce.DomainModels;

namespace LiteCommerce.Models
{
    public class EmployeePaginationResult : PaginationResult
    {
        public List<Employee> Data;
        public string searchCountry;
    }
}