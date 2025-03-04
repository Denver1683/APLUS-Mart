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
    public partial class registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMessage.Text = "";
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if(txtEmail.Text.Trim().Length > 0 && txtPassword.Text.Trim().Length > 0 && txtName.Text.Trim().Length > 0 && txtPhone.Text.Trim().Length > 0 && txtAddress.Text.Trim().Length > 0) {
                //Check if existing customer exists
                string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection conn = new SqlConnection(strConn);
                conn.Open();
                string query = "SELECT * FROM Customers WHERE email=@email";
                SqlCommand comm = new SqlCommand(query, conn);
                comm.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                SqlDataReader reader = comm.ExecuteReader();
                if (reader.Read())
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "User with same email exists, please try to login or contact admin.";
                }
                else
                {
                    //Close reader for customer user
                    reader.Close();
                    //Check if it is an existing admin
                    string aquery = "SELECT * FROM Admin WHERE email=@email";
                    SqlCommand acomm = new SqlCommand(aquery, conn);
                    acomm.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                    SqlDataReader areader = acomm.ExecuteReader();
                    if (areader.Read())
                    {
                        lblMessage.Visible = true;
                        lblMessage.Text = "User with same email exists, please try to login or contact admin.";
                    }
                    else
                    {
                        //New user detected, allow customer to register
                        lblDTAdded.Text = DateTime.Now.ToString();
                        SqlDataSource1.Insert();
                        lblMessage.Visible = true;
                        lblMessage.Text = "Registration successful. You may now login.";
                    }
                } 
            
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Please do not leave any column blank.";
            }
        }

    }
}