using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LiteCommerce.DomainModels;

namespace LiteCommerce.DataLayers
{
    /// <summary>
    /// 
    /// </summary>
    public interface ICategoryDAL
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        int Add_Category(Category data);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        bool Update_Category(Category data);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="CategoryIDs"></param>
        /// <returns></returns>
        bool Delete_Category(int[] categoryIDs);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="CategoryID"></param>
        /// <returns></returns>
        Category Get_Category(int categoryID);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="page"></param>
        /// <param name="pageSize"></param>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        List<Category> Category_List(string searchValue);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="searchValue"></param>
        /// <returns></returns>
        int Count_Catogory(string searchValue);

    }
}
