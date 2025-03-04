using System;
using System.Configuration;
using System.Data.SqlClient;
using System.EnterpriseServices;
using System.Security.Cryptography;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Feedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                if (Session["uid"] == null || Session["name"] == null || Session["email"] == null || Session["address"] == null || Session["password"] == null || Session["phone"] == null)
                {
                    Response.Redirect("ProductCatalog.aspx");
                } 
                lblRating.Text = "0"; // Default rating
                // Ensure session variables are not null and are properly converted
                if (Session["uid"] != null && Session["orderID"] != null)
                {
                    loadTransactionDetails();
                    //If there is an existing review, load it to the text field
                    string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(strConn))
                    {
                        conn.Open();
                        string oid = Session["orderID"].ToString();
                        string query = "SELECT * FROM Feedback WHERE orderID=@oid";

                        using (SqlCommand comm = new SqlCommand(query, conn))
                        {
                            comm.Parameters.AddWithValue("@oid", oid);
                            using (SqlDataReader reader = comm.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    //Review Exists, set data to column.
                                    lblRating.Text = reader["rating"].ToString();
                                    txtDescription.Text = reader["opinion"].ToString();
                                }
                                // Review not exist, allow user to fill the form
                            }
                        }
                    }
                }
                else
                {
                    // Handle missing session variables
                    Response.Redirect("ProductCatalog.aspx");
                }
            }
        }
        private void loadTransactionDetails()
        {
            string uid = Session["uid"].ToString();
            string orderID = Session["orderID"].ToString();

            string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                conn.Open();

                string query = @"
            SELECT sc.*, p.image, p.name, p.price 
            FROM ShoppingCart sc 
            INNER JOIN Products p ON sc.pid = p.pid
            WHERE sc.uid = @uid AND sc.orderID = @orderID";

                using (SqlCommand comm = new SqlCommand(query, conn))
                {
                    comm.Parameters.AddWithValue("@uid", uid);
                    comm.Parameters.AddWithValue("@orderID", orderID);
                    using (SqlDataReader reader = comm.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            imgProduct.ImageUrl = reader["image"].ToString();
                            lblPname.Text = reader["name"].ToString();
                            lblPrice.Text = reader["price"].ToString();
                            lblDT.Text = reader["dtadded"].ToString();
                            lblPID.Text = reader["pid"].ToString();
                        }
                    }
                }
            }
        }
        protected void Submit_Click(object sender, EventArgs e)
        {
            if (int.Parse(hidRating.Value)>0)
            {
                string uid = Session["uid"].ToString();
                string orderID = Session["orderID"].ToString();

                string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    conn.Open();
                    {
                        string querycheck = "SELECT * FROM Feedback WHERE orderID=@oid";

                        using (SqlCommand comm = new SqlCommand(querycheck, conn))
                        {
                            comm.Parameters.AddWithValue("@oid", orderID);
                            using (SqlDataReader reader = comm.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    reader.Close(); // Close the DataReader before executing the next query

                                    string updateQuery = "UPDATE Feedback SET rating=@rating, opinion=@opinion WHERE orderID = @oid";
                                    using (SqlCommand submit = new SqlCommand(updateQuery, conn))
                                    {
                                        submit.Parameters.AddWithValue("@rating", int.Parse(hidRating.Value));
                                        submit.Parameters.AddWithValue("@opinion", txtDescription.Text);
                                        submit.Parameters.AddWithValue("@oid", orderID);
                                        int rowsAffected = submit.ExecuteNonQuery();
                                        if (rowsAffected > 0)
                                        {
                                            conn.Close();
                                            lblMessage.Visible = true;
                                            lblMessage.Text = "Updated review sucessfully. You may now go back to the shopping history page.";
                                        }
                                        else
                                        {
                                            lblMessage.Visible = true;
                                            lblMessage.Text = "Unknown Error";
                                        }
                                    }
                                }
                                else
                                {
                                    reader.Close(); // Close the DataReader before executing the next query
                                    string insertQuery = "INSERT INTO Feedback (uid, pid, dtadded, rating, opinion, trdate, orderID) VALUES (@uid, @pid, @dtadded, @rating, @opinion, @trdate, @orderID)";
                                    using (SqlCommand submit = new SqlCommand(insertQuery, conn))
                                    {
                                        submit.Parameters.AddWithValue("@uid", uid);
                                        submit.Parameters.AddWithValue("@pid", lblPID.Text); // Assuming lblPID is accessible
                                        submit.Parameters.AddWithValue("@dtadded", DateTime.Now);
                                        submit.Parameters.AddWithValue("@rating", int.Parse(hidRating.Value));
                                        submit.Parameters.AddWithValue("@opinion", txtDescription.Text);
                                        submit.Parameters.AddWithValue("@trdate", DateTime.Parse(lblDT.Text)); // Assuming lblDT is accessible
                                        submit.Parameters.AddWithValue("@orderID", orderID);

                                        int rowsAffected = submit.ExecuteNonQuery();
                                        if (rowsAffected > 0)
                                        {
                                            conn.Close();
                                            lblMessage.Visible = true;
                                            lblMessage.Text = "Submitted review sucessfully. Thank you for your feedback.";
                                        }
                                        else
                                        {
                                            lblMessage.Visible = true;
                                            lblMessage.Text = "Unknown Error";
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Please give at least 1 star";
            }
        }
    }
}

