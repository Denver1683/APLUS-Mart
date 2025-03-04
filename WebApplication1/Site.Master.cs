using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using static System.Net.Mime.MediaTypeNames;

namespace WebApplication1
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["uid"] != null)
                {
                    btnprofile.Visible = true;
                    btnshoppingcart.Visible = true;
                    btnlogout.Visible = true;
                    lblUserName.Text = "Hello," + Session["name"].ToString();
                    lblUserName.Visible = true;
                }
                else if (Session["aid"] != null)
                {
                    btnlogout.Visible = true;
                }
                else
                {
                    btnfeedback.Visible = true;
                    btnlogin.Visible = true;
                    btnregister.Visible = true;
                }
            }
           
        }
        protected void BrandImage_Click(object sender, ImageClickEventArgs e)
        {
            if (Session["aid"] != null)
            {
                Response.Redirect("~/Admin/AdminHomepage.aspx");
            }
            else
            {
                Response.Redirect("~/ProductCatalog.aspx");
            }
        }
    }
}