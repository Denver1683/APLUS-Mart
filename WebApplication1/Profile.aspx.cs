using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["uid"] == null || Session["name"] == null || Session["email"] == null || Session["address"] == null || Session["password"] == null || Session["phone"] == null)
                {
                    Response.Redirect("ProductCatalog.aspx");
                }
                txtName.Text = Session["name"].ToString();
                txtEmail.Text = Session["email"].ToString();
                txtAddress.Text = Session["address"].ToString();
                txtPassword.Text = Session["password"].ToString();
                txtPhone.Text = Session["phone"].ToString();
            }

        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (txtName.Text.Trim().Length>0 && txtPhone.Text.Trim().Length>0 && 
                txtAddress.Text.Trim().Length>0 && txtPassword.Text.Trim().Length > 0)
            {
                SqlDataSource1.Update();
                lblMessage.Visible = true;
                lblMessage.Text = "Profile has been updated!";
                Session["name"] = txtName.Text;
                Session["email"] = txtEmail.Text;
                Session["address"] = txtAddress.Text;
                Session["password"] = txtPassword.Text;
                Session["phone"] = txtPhone.Text;
            }
        }
    }
}