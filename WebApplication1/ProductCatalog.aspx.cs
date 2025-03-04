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
    public partial class productCatalog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateCategories();
            }
        }

        protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "details")
            {
                Label pid = e.Item.FindControl("PIDLabel") as Label;
                Response.Write(pid.Text);
                Session["pid"] = pid.Text;
                Response.Redirect("productDetails.aspx");
            }
        }

        private void PopulateCategories()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("SELECT cid, name FROM Category", connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                ddlCategory.DataSource = reader;
                ddlCategory.DataTextField = "name";
                ddlCategory.DataValueField = "cid";
                ddlCategory.DataBind();
                ddlCategory.Items.Insert(0, new ListItem("All Items", ""));
                reader.Close();
            }
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedCategoryId = ddlCategory.SelectedValue;
            if (!string.IsNullOrEmpty(selectedCategoryId))
            {
                SqlDataSource1.SelectCommand = @"
            SELECT p.pid, p.name, p.price, p.image, p.description,
            AVG(f.rating) AS avg_rating,
            STRING_AGG(f.opinion, '; ') AS opinions
            FROM Products p
            LEFT JOIN Feedback f ON p.pid = f.pid
            WHERE p.active = 1 AND p.cid = @categoryId
            GROUP BY p.pid, p.name, p.price, p.image, p.description";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("categoryId", selectedCategoryId);
            }
            else
            {
                SqlDataSource1.SelectCommand = @"
            SELECT p.pid, p.name, p.price, p.image, p.description,
            AVG(f.rating) AS avg_rating,
            STRING_AGG(f.opinion, '; ') AS opinions
            FROM Products p
            LEFT JOIN Feedback f ON p.pid = f.pid
            WHERE p.active = 1
            GROUP BY p.pid, p.name, p.price, p.image, p.description";
                SqlDataSource1.SelectParameters.Clear();
            }
            ListView1.DataBind();
        }


        protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                Label ratingLabel = (Label)e.Item.FindControl("ratingLabel");
                if (ratingLabel != null)
                {
                    object avgRatingObj = DataBinder.Eval(e.Item.DataItem, "avg_rating");
                    if (avgRatingObj != null && avgRatingObj != DBNull.Value)
                    {
                        double avgRating = Convert.ToDouble(avgRatingObj);
                        ratingLabel.Text = $"{avgRating:0.##}/5 Rating";
                    }
                    else
                    {
                        ratingLabel.Text = "No Rating";
                    }
                }
            }
        }

    }
}