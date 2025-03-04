using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;

namespace WebApplication1
{
    public partial class ShoppingCart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["uid"] == null || Session["name"] == null || Session["email"] == null || Session["address"] == null || Session["password"] == null || Session["phone"] == null)
                {
                    Response.Redirect("ProductCatalog.aspx");
                }
                grandTotal();
                ListView1.DataBind();
                BindData();
            }
        }

        private void BindData()
        {
            // Check if the DataList has no items
            if (ListView1.Items.Count == 0)
            {
                pnlCart.Visible = false; // Hide the panel containing the DataList
                pnlEmptyCart.Visible = true; // Show the panel with the empty cart message
                scbottom.Visible = false;
            }
            else
            {
                pnlCart.Visible = true; // Show the panel containing the DataList
                pnlEmptyCart.Visible = false; // Hide the panel with the empty cart message
            }
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
            Response.Redirect("Payment.aspx");
        }

        //protected void HistoryButton_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("ShoppingHistory.aspx");
        //}

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@uid"].Value = Session["uid"].ToString();
            e.Command.CommandText = "select sc.*, p.*, sc.qty * p.price as subtotal, pr.qty as stockQuantity " +
                                    "from ShoppingCart sc " +
                                    "inner join Products p on sc.PID = p.PID " +
                                    "inner join Products pr on sc.PID = pr.PID " +
                                    "where sc.uid = @uid and sc.status='In Cart'";
        }
        private void checkStock(ListViewItemEventArgs e)
        {
            string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                conn.Open();

                string query = "SELECT qty FROM Products WHERE pid=@pid";
                SqlCommand comm = new SqlCommand(query, conn);
                Label PID = e.Item.FindControl("PIDLabel") as Label;
                comm.Parameters.AddWithValue("@pid", PID.Text); // Use PID.Text as parameter value
                Label Stock = e.Item.FindControl("lblStock") as Label;

                // Use ExecuteScalar to retrieve a single value from the database
                object result = comm.ExecuteScalar();
                if (result != null)
                {
                    // Convert the retrieved value to an integer
                    int stock;
                    if (int.TryParse(result.ToString(), out stock))
                    {
                        Stock.Text = stock.ToString();
                    }
                    else
                    {
                        Stock.Text = "Error: Unable to retrieve stock quantity.";
                    }
                }
                else
                {
                    Stock.Text = "Stock quantity not found.";
                }
            }
        }

        protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "update")
            {
                Label Stock = e.Item.FindControl("lblStock") as Label;
                TextBox txtQTY = e.Item.FindControl("txtQTY") as TextBox;
                if (int.Parse(Stock.Text) >= int.Parse(txtQTY.Text))
                {
                    //update qty from sc
                    Label PID = e.Item.FindControl("PIDLabel") as Label;
                    string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                    SqlConnection conn = new SqlConnection(connStr);
                    conn.Open();
                    string sqlQuery = "UPDATE shoppingcart SET qty=@qty " +
                        "WHERE uid=@uid AND pid=@pid AND status='In Cart'";
                    SqlCommand comm = new SqlCommand(sqlQuery, conn);
                    comm.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                    comm.Parameters.AddWithValue("@qty", Int32.Parse(txtQTY.Text));
                    comm.Parameters.AddWithValue("@pid", Int32.Parse(PID.Text));
                    int results = comm.ExecuteNonQuery();
                    conn.Close();
                    Response.Redirect("shoppingcart.aspx");
                }
                else
                {
                    txtQTY.Text = Stock.Text;
                    Label StockMessage = e.Item.FindControl("stkMessage") as Label;
                    StockMessage.Visible = true;
                    Response.Redirect("shoppingcart.aspx");
                }
            }
            else if (e.CommandName == "delete")
            {
                //remove item from sc
                Label PID = e.Item.FindControl("PIDLabel") as Label;
                TextBox txtQTY = e.Item.FindControl("txtQTY") as TextBox;
                string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection conn = new SqlConnection(connStr);
                conn.Open();
                string sqlQuery = "DELETE FROM shoppingcart WHERE uid=@uid AND pid=@pid AND status='In Cart'";
                SqlCommand comm = new SqlCommand(sqlQuery, conn);
                comm.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                comm.Parameters.AddWithValue("@qty", Int32.Parse(txtQTY.Text));
                comm.Parameters.AddWithValue("@pid", Int32.Parse(PID.Text));
                int results = comm.ExecuteNonQuery();
                conn.Close();
                Response.Redirect("ShoppingCart.aspx");
            }
        }

        protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem || e.Item.ItemType == ListViewItemType.EmptyItem)
            {
                checkStock(e);
            }
        }

    }
}