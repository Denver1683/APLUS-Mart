using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Admin
{
    public partial class AdminHomepage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["aid"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void btnCategory_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageProductCategory.aspx");
        }

        protected void btnDelivery_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageDelivery.aspx");
        }

        protected void btnProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageUserProfile.aspx");
        }

        protected void btnProducts_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageProduct.aspx");
        }

        protected void viewCFeedback_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewFeedback.aspx");
        }

        protected void viewGFeedback_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewGuestFeedback.aspx");
        }
    }
}