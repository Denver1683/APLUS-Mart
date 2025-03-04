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
    public partial class GuestFeedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void Submit_Click(object sender, EventArgs e)
        {
            if(txtName.Text.Trim().Length > 0 && txtDescription.Text.Trim().Length > 0)
            {
                string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    conn.Open();
                    string updateQuery = "INSERT INTO GuestFeedback (name,opinion) VALUES (@name,@opinion)";
                    using (SqlCommand submit = new SqlCommand(updateQuery, conn))
                    {
                        submit.Parameters.AddWithValue("@name", txtName.Text);
                        submit.Parameters.AddWithValue("@opinion", txtDescription.Text);
                        int rowsAffected = submit.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            conn.Close();
                            lblMessage.Visible = true;
                            lblMessage.Text = "Thank you for your feedback! You may how go back to homepage";
                        }
                        else
                        {
                            lblMessage.Visible = true;
                            lblMessage.Text = "Feedback submission failed! Please call for assistance.";
                        }
                    }
                }
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Please do not leave a blank feedback.";
            }
        }
    }
}