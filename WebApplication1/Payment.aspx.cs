using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["uid"] == null || Session["name"] == null || Session["email"] == null || Session["address"] == null || Session["password"] == null || Session["phone"] == null)
            {
                Response.Redirect("ProductCatalog.aspx");
            }
            grandTotal();
        }

        private void grandTotal()
        {
            string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(strConn);
            conn.Open();

            string query = "SELECT SUM(subtotal) AS grand_total  " +
                "FROM(SELECT ShoppingCart.qty * Products.price AS subtotal " +
                "from ShoppingCart, Products " +
                "WHERE ShoppingCart.pid = Products.pid " +
                "and ShoppingCart.uid = @uid AND ShoppingCart.status = 'In Cart') AS subquery ";
            SqlCommand comm = new SqlCommand(query, conn);
            comm.Parameters.AddWithValue("@uid", Session["uid"].ToString());
            SqlDataReader reader = comm.ExecuteReader();
            if (reader.Read())
            {
                lblGrandTotal.Text = reader["grand_total"].ToString();
            }
            conn.Close();
        }

        protected void Checkout_Click(object sender, EventArgs e)
        {
            decimal grandTotal, amountPaid;

            if (decimal.TryParse(lblGrandTotal.Text, out grandTotal) && decimal.TryParse(amtPaid.Text, out amountPaid))
            {
                // Check if the amount paid is sufficient
                if (grandTotal <= amountPaid)
                {
                    string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(strConn))
                    {
                        conn.Open();

                        string query = "UPDATE ShoppingCart SET status='PAID', dtadded=@dt, deliveryStatus='Pending' WHERE uid=@uid AND status='In Cart'";
                        using (SqlCommand comm = new SqlCommand(query, conn))
                        {
                            comm.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                            comm.Parameters.AddWithValue("@dt", DateTime.Now);
                            int rowsAffected = comm.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                // Payment successful, deducting stock
                                foreach (DataListItem item in DataList1.Items)
                                {
                                    Label PID = item.FindControl("PIDLabel") as Label;
                                    Label txtQty = item.FindControl("qtylabel") as Label; // Assuming this is a Label showing the quantity
                                    int purchasedQty = Convert.ToInt32(txtQty.Text);

                                    // Deduct purchased quantity from the Products table
                                    string updateQuery = @"
                                UPDATE Products 
                                SET 
                                    qty = CASE 
                                                WHEN qty > @purchasedQty THEN qty - @purchasedQty 
                                                ELSE 0 
                                            END,
                                    active = CASE 
                                                    WHEN qty > @purchasedQty THEN active 
                                                    ELSE 0 
                                                END
                                WHERE pid = @pid";
                                    using (SqlCommand updateComm = new SqlCommand(updateQuery, conn))
                                    {
                                        updateComm.Parameters.AddWithValue("@purchasedQty", purchasedQty);
                                        updateComm.Parameters.AddWithValue("@pid", PID.Text);
                                        updateComm.ExecuteNonQuery();
                                    }
                                }
                                conn.Close();
                                Response.Redirect("ShoppingHistory.aspx");
                            }
                            else
                            {
                                Response.Write("Failed to update payment status.");
                            }

                        }
                    }
                }
                else
                {
                    notenough.Visible = true;
                }
            }
            else
            {
                Response.Write("Invalid input format for grand total or amount paid.");
            }
        }
    }
}