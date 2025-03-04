using Antlr.Runtime.Misc;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace WebApplication1
{
    public partial class manageDelivery : System.Web.UI.Page
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
            
        }

        protected void saveButton_Click(object sender, EventArgs e)
        {
            // Get the clicked button
            Button saveButton = (Button)sender;

            // Find the DropDownList in the corresponding row
            GridViewRow row = (GridViewRow)saveButton.NamingContainer;
            DropDownList ddlDeliveryStatus = (DropDownList)row.FindControl("ddlDeliveryStatus");

            // Get the UID from the CommandArgument of the clicked button
            int orderid = Convert.ToInt32(row.Cells[1].Text);

            // Get the PID from the fourth cell (index 3) in the current row
            int pid = Convert.ToInt32(row.Cells[3].Text);

            // Get the order time from the sixth cell (index 5) in the current row
            string orderTimeString = row.Cells[5].Text;
            DateTime orderTime;
            if (DateTime.TryParseExact(orderTimeString, "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture, DateTimeStyles.None, out orderTime))
            {

                string deliveryStatus = ddlDeliveryStatus.SelectedValue;

                // Here you can update the delivery status in your database using the UID and the new delivery status
                // For example:
                string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    conn.Open();

                    string query = "UPDATE ShoppingCart SET deliverystatus=@ds WHERE status='PAID' AND orderID=@oid";
                    using (SqlCommand comm = new SqlCommand(query, conn))
                    {
                        comm.Parameters.AddWithValue("@oid", orderid);
                        comm.Parameters.AddWithValue("@ds", deliveryStatus);


                        int rowsAffected = comm.ExecuteNonQuery();
                        try
                        {
                            if (rowsAffected > 0)
                            {
                                GridView1.DataBind();
                                conn.Close();
                                if (deliveryStatus.Trim() == "Canceled")
                                {
                                    // Add stock back to the Products table
                                    string updateQuery2 = @"UPDATE Products
                                SET Products.qty = Products.qty + ShoppingCart.qty Products.active = 1
                                FROM Products
                                INNER JOIN ShoppingCart ON Products.pid = ShoppingCart.pid
                                WHERE ShoppingCart.orderID = @orderID;";

                                    using (SqlCommand command2 = new SqlCommand(updateQuery2, conn))
                                    {
                                        command2.Parameters.AddWithValue("@orderID", orderid);
                                        conn.Open();
                                        int rowsAffected2 = command2.ExecuteNonQuery();
                                        conn.Close();
                                    }
                                }
                            }
                            else
                            {
                                Response.Write(orderTime.ToString());
                                Response.Write("Failed to update delivery status.");
                            }
                        }
                        catch (Exception ex)
                        {
                            // Print out any exceptions that occur during the update operation
                            System.Diagnostics.Debug.WriteLine("Error updating delivery status: " + ex.Message);
                            Response.Write("SYSTEM ERROR");
                        }

                        
                    }
                }
            }
            else
            {
                // Handle parsing failure
                Response.Write("Failed to parse order time.");
            }     
        }
    }
}