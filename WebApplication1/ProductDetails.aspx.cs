using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services.Description;


namespace WebApplication1
{
    public partial class productDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["uid"] == null)
            {
               addtocart.Visible = false;
                PLogin.Visible = true;
            }
            
            if (Session["pid"] == null)
            {
                Response.Redirect("ProductCatalog.aspx");
            }
            loadProductDetails();
        }

        private void loadProductDetails()
        {
            string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(strConn);
            conn.Open();
            string query = "SELECT * FROM Products WHERE pid=@pid";
            SqlCommand comm = new SqlCommand(query, conn);
            comm.Parameters.AddWithValue("@pid", Session["pid"].ToString());
            SqlDataReader reader = comm.ExecuteReader();
            if (reader.Read())
            {
                imgProduct.ImageUrl = reader["image"].ToString() ;
                lblPname.Text = reader["name"].ToString();
                lblDesc.Text = reader["description"].ToString();
                lblPrice.Text = reader["price"].ToString();
                lblStock.Text = reader["qty"].ToString() ;
            }
            reader.Close();
            conn.Close();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(strConn);
            conn.Open();

            string queryCheck = "select * from shoppingcart where uid=@uid and pid=@pid and status='In Cart'";
            SqlCommand commCheck = new SqlCommand(queryCheck, conn);
            commCheck.Parameters.AddWithValue("@uid", Session["uid"].ToString());
            commCheck.Parameters.AddWithValue("@pid", Session["pid"].ToString());
            SqlDataReader readerCheck = commCheck.ExecuteReader();
            if (readerCheck.Read())
            {
                Session["qty"] = readerCheck["qty"];
                updateCart();
            }
            else
            {
                insertCart();
            }
            readerCheck.Close();
            conn.Close();
        }

        private void updateCart() {
            if (int.Parse(lblStock.Text) >= (int.Parse(txtQuantity.Text) + int.Parse(Session["qty"].ToString())))
            {
                string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection conn = new SqlConnection(strConn);
                conn.Open();
                string query= "UPDATE shoppingcart SET qty=@qty " +
                    "WHERE uid=@uid AND pid=@pid AND status='In Cart'";
                SqlCommand comm = new SqlCommand(query, conn);
                comm.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                comm.Parameters.AddWithValue("@pid", Session["pid"].ToString());
                comm.Parameters.AddWithValue("@qty", int.Parse(txtQuantity.Text) + int.Parse(Session["qty"].ToString()));
                int resultUpdate = comm.ExecuteNonQuery();
                if (resultUpdate > 0)
                {
                    Session["uid"] = Session["uid"].ToString();
                    Response.Redirect("ShoppingCart.aspx");
                }
                else
                {
                    lblMessage.Text = "Error adding the item, please try again.";
                }
                conn.Close();
            }
            else
            {
                stkMessage.Visible = true;
            }
        }

        private void insertCart()
        {
            if (int.Parse(lblStock.Text) >= int.Parse(txtQuantity.Text))
            {
                string strConn2 = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection conn2 = new SqlConnection(strConn2);
                conn2.Open();
                string queryInsert = "INSERT INTO shoppingcart(uid,pid,qty,dtadded,status)" +
                "VALUES(@uid,@pid,@qty,@dtadded,@status)";
                SqlCommand commInsert = new SqlCommand(queryInsert, conn2);
                commInsert.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                commInsert.Parameters.AddWithValue("@pid", Session["pid"].ToString());
                commInsert.Parameters.AddWithValue("@qty", int.Parse(txtQuantity.Text));
                commInsert.Parameters.AddWithValue("@dtadded", DateTime.Now);
                commInsert.Parameters.AddWithValue("@status", "In Cart");
                int resultInsert = commInsert.ExecuteNonQuery();
                if (resultInsert > 0)
                {
                    Session["uid"] = Session["uid"].ToString();
                    Response.Redirect("ShoppingCart.aspx");
                }
                else
                {
                    lblMessage.Text = "error adding the item, please try again.";
                }
            }
            else
            {
                stkMessage.Visible = true;
            }
        }
    }
}