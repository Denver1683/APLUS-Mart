using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace WebApplication1
{
    public partial class ShoppingHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["uid"] == null || Session["name"] == null || Session["email"] == null || Session["address"] == null || Session["password"] == null || Session["phone"] == null)
                {
                    Response.Redirect("ProductCatalog.aspx");
                }
                ddlDeliveryStatus.SelectedValue = "Pending";
                ListView1.DataBind();
                BindData();
            }
        }
        private void BindData()
        {
            // Your existing code to bind data to the DataList

            // Check if the DataList has no items
            if (ListView1.Items.Count == 0)
            {
                pnlCart.Visible = false; // Hide the panel containing the DataList
                pnlEmptyCart.Visible = true; // Show the panel with the empty cart message
            }
            else
            {
                pnlCart.Visible = true; // Show the panel containing the DataList
                pnlEmptyCart.Visible = false; // Hide the panel with the empty cart message
            }
        }
        protected void ddlDeliveryStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            ListView1.DataBind();
            BindData();
        }
        private void UpdateOrderStatus(string orderID, string status)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Update the delivery status in the ShoppingCart table
                string updateQuery1 = "UPDATE ShoppingCart SET deliveryStatus = @status WHERE orderID = @orderID";

                using (SqlCommand command1 = new SqlCommand(updateQuery1, connection))
                {
                    command1.Parameters.AddWithValue("@status", status);
                    command1.Parameters.AddWithValue("@orderID", orderID);

                    connection.Open();
                    int rowsAffected1 = command1.ExecuteNonQuery();
                    connection.Close();
                }

                // Add stock back to the Products table
                string updateQuery2 = @"UPDATE Products
                                SET Products.qty = Products.qty + ShoppingCart.qty, Products.active = 1
                                FROM Products
                                INNER JOIN ShoppingCart ON Products.pid = ShoppingCart.pid
                                WHERE ShoppingCart.orderID = @orderID;";

                using (SqlCommand command2 = new SqlCommand(updateQuery2, connection))
                {
                    command2.Parameters.AddWithValue("@orderID", orderID);

                    connection.Open();
                    int rowsAffected2 = command2.ExecuteNonQuery();
                    connection.Close();
                }
            }
        }

        protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "feedback")
            {
                Label orderIDLabel = e.Item.FindControl("orderid") as Label;
                if (orderIDLabel != null)
                {
                    string orderID = orderIDLabel.Text;

                    Session["orderID"] = orderID;

                    // Redirect to Feedback Page
                    Response.Redirect("Feedback.aspx");
                }
            }
            else if (e.CommandName == "cancelorder")
            {
                // Get the orderID from the ListView item
                Label orderIDLabel = e.Item.FindControl("orderid") as Label;
                if (orderIDLabel != null)
                {
                    string orderID = orderIDLabel.Text;

                    // Update the status to "Cancelled" in the database
                    UpdateOrderStatus(orderID, "Canceled");

                    // Rebind the ListView to reflect the updated status
                    ListView1.DataBind();
                }
            }
        }

        protected void ListView1_DataBound(object sender, EventArgs e)
        {
            foreach (ListViewItem item in ListView1.Items)
            {
                ImageButton btnFeedback = (ImageButton)item.FindControl("ImageButton1");
                ImageButton btnCancel = (ImageButton)item.FindControl("ImageButton2");

                string deliveryStatus = ddlDeliveryStatus.SelectedValue;
                if (deliveryStatus == "Delivered")
                {
                    if (btnFeedback != null)
                    {
                        btnFeedback.Visible = true;
                    }
                    if (btnCancel != null)
                    {
                        btnCancel.Visible = false; // Disable cancel button for Delivered items
                    }
                }
                else if (deliveryStatus == "Pending")
                {
                    if (btnCancel != null)
                    {
                        btnCancel.Visible = true;
                    }
                    if (btnFeedback != null)
                    {
                        btnFeedback.Visible = false; // Disable feedback button for Pending items
                    }
                }
                else
                {
                    if (btnFeedback != null && btnCancel != null)
                    {
                        btnFeedback.Visible = false;
                        btnCancel.Visible = false; // Hide buttons for other statuses
                    }
                }
            }
        }

    }
}
