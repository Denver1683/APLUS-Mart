using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//step 1
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication1
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //step 2 - connect to database
            string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(strConn);
            conn.Open();
            //step 3 - create your command - select, insert, update, delete
//            string x = "select * from tblcustomers where email='" + txtEmail.Text + "'";
            string query = "SELECT * FROM Customers WHERE email=@email AND password=@password AND active=1";
            SqlCommand comm = new SqlCommand(query, conn);
            comm.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
            comm.Parameters.AddWithValue("@password", txtPassword.Text.Trim());
            //step 4 - execute your command/read your command
            SqlDataReader reader = comm.ExecuteReader();
            if (reader.Read())
            {
                //redirect the user to product catalog
                Session["uid"] = reader["id"];
                Session["name"] = reader["name"];
                Session["email"] = reader["email"];
                Session["address"] = reader["address"];
                Session["password"] = reader["password"];
                Session["phone"] = reader["phone"];
                reader.Close();
                Response.Redirect("productCatalog.aspx");
            }
            else
            {
                //Close reader for customer user
                reader.Close();
                //Check if admin is trying to log in
                string aquery = "SELECT * FROM Admin WHERE email=@email AND password=@password AND active=1";
                SqlCommand acomm = new SqlCommand(aquery, conn);
                acomm.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                acomm.Parameters.AddWithValue("@password", txtPassword.Text.Trim());
                //step 4 - execute your command/read your command
                SqlDataReader areader = acomm.ExecuteReader();
                if (areader.Read())
                {
                    //redirect the admin to main page
                    Session["aid"] = areader["id"];
                    Session["name"] = areader["name"];
                    Session["email"] = areader["email"];
                    areader.Close();
                    Response.Redirect("/Admin/AdminHomepage.aspx");
                }
                else
                {
                    LoginLabel.Visible = true;
                }  
            }
            //step 6 - close connection
            //reader.Close();
            conn.Close();
        }
    }
}