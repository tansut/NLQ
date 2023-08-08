using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace JDash.WebForms.Official{

    public class LicenseInfo
    {
        public string Model { get; set; }
        public string Title { get; set; }
        public int LicensePrice { get; set; }
        public int SupportPrice { get; set; }
        public int TotalPrice { get; set; }
        public string LicenseLink { get; set; }
        public string SupportLink { get; set; }
        public string TotalLink { get; set; }
        public string BuyNow { get; set; }
        public string SubsDesc { get; set; }

        private static List<LicenseInfo> prices ;

        static LicenseInfo ()
        {
            var filePath = HttpContext.Current.Server.MapPath("~/App_Data/Prices.xml");
            var fileContent = File.ReadAllText(filePath);
            var reader = new StringReader(fileContent);
            System.Xml.Serialization.XmlSerializer s = new System.Xml.Serialization.XmlSerializer(typeof(List<LicenseInfo>));
            var result = (List<LicenseInfo>)s.Deserialize(reader);
            prices = result;
        
        }

        public static List<LicenseInfo> GetList()
        {
            return prices;
        }

    }

    public partial class Purchase : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindPrices();
            }
        }

        public bool SeperatedPurchase
        {
            get
            {
                return ctlSeperate.Checked;
            }
        }

        private void BindPrices()
        {
            var prices = LicenseInfo.GetList();
            ctlLicenseRep.DataSource = prices;
            ctlLicenseRep.DataBind();
        }

        protected void ctlSeperate_CheckedChanged(object sender, EventArgs e)
        {
            BindPrices();
        }

        protected void ctlLicenseRep_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                var a1 = e.Item.FindControl("byLink") as HtmlControl;
                var link1 = DataBinder.Eval(e.Item.DataItem, "TotalLink") as string;
                a1.Attributes["onclick"] = string.Format("_gaq.push(['_link','{0}']); return false;", link1);

                var a2 = e.Item.FindControl("byLicenseLink") as HtmlControl;
                var link2 = DataBinder.Eval(e.Item.DataItem, "LicenseLink") as string;
                a2.Attributes["onclick"] = string.Format("_gaq.push(['_link','{0}']); return false;", link2);

            }
        }
    }
}