using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class ManageUserProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["aid"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                }
                GridView1.DataBind();
            }

        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Get the selected row
            GridViewRow row = GridView1.SelectedRow;
            // Set the values to the text boxes
            txtName.Text = row.Cells[1].Text;
            txtPassword.Text = row.Cells[3].Text;
            active.Text = row.Cells[5].Text;
            Session["id"] = row.Cells[0].Text;
            Session["name"] = row.Cells[1].Text;
            Session["password"] = row.Cells[3].Text;
            Session["active"] = row.Cells[5].Text;
            lblSelected.Text = "true";
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if(lblSelected.Text == "true")
            {
                SqlDataSource1.Update();
                lblMessage.Visible = true;
                lblMessage.Text = "Profile has been updated!";
                GridView1.DataBind();
                //Redirect to Admin Homepage
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Please select user from Table";
            }
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int uid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["id"]);
            string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(strConn);
            conn.Open();
            string query = "DELETE FROM Customers WHERE id=@uid";
            SqlCommand comm = new SqlCommand(query, conn);
            comm.Parameters.AddWithValue("@uid", uid);
            int result = comm.ExecuteNonQuery();
            if (result > 0)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Deleted user successfully!";
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Delete user failed, please recheck your input and try again";
            }
            conn.Close();
            GridView1.DataBind();
        }
    }
}