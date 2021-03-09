using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LiteCommerce
{
    public static class UpLoadImage
    {
        public static string ProcessUpload(HttpPostedFileBase file)
        {
            file.SaveAs(HttpContext.Current.Server.MapPath("~/Images/" + file.FileName));
            return "~/Images/" + file.FileName;
        }
    }
}