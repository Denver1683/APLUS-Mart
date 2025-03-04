using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace WebApplication1
{
    public partial class ManageProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["aid"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                }
                loadCategory();
                GridView1.DataBind();
                //Make sure everything is clear
                clearSelection();
            }
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            if(txtName.Text.Trim()!="" && txtDescription.Text.Trim()!="" && txtPrice.Text.Trim()!="" && txtQTY.Text.Trim() != "")
            {
                if (lblPID.Text == "")
                {
                    // Step 2 - connect to database
                    string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                    SqlConnection conn = new SqlConnection(strConn);
                    conn.Open();

                    // Check if the file already exists in the images folder
                    string filename = fuImage.FileName;
                    string imagePath = "~/images/ProductImage/" + filename;
                    string physicalPath = Server.MapPath(imagePath);
                    if (fuImage.HasFile)
                    {
                        if (File.Exists(physicalPath))
                        {
                            lblMessage.Visible = true;
                            lblMessage.Text = "File already exists. Using existing file.";
                        }
                        else
                        {
                            // Save the physical file to your folder
                            fuImage.SaveAs(physicalPath);
                            lblMessage.Visible = true;
                            lblMessage.Text = "File uploaded successfully.";
                        }
                        // Save it to your database
                        lblFilename.Text = imagePath;
                        lblDTAdded.Text = DateTime.Now.ToString();
                        // Step 3 - create your sql statement INSERT
                        string query = "INSERT INTO Products(name,description,price, qty, image, cid, dtAdded,active) " +
                            "VALUES(@name,@description,@price, @qty, @image, @cid, @dtAdded,@active)";
                        // Step 4 - create the command
                        SqlCommand comm = new SqlCommand(query, conn);
                        comm.Parameters.AddWithValue("@name", txtName.Text.Trim());
                        comm.Parameters.AddWithValue("@description", txtDescription.Text.Trim());
                        comm.Parameters.AddWithValue("@price", txtPrice.Text.Trim());
                        comm.Parameters.AddWithValue("@qty", txtQTY.Text.Trim());
                        comm.Parameters.AddWithValue("@image", lblFilename.Text);
                        comm.Parameters.AddWithValue("@cid", ddlCategory.SelectedValue);
                        comm.Parameters.AddWithValue("@dtAdded", DateTime.Now);
                        comm.Parameters.AddWithValue("@active", "1");
                        // Step 5 - execute your command
                        int result = comm.ExecuteNonQuery();
                        if (result > 0)
                        {
                            lblMessage.Visible = true;
                            lblMessage.Text = "Successfully uploaded new product!";
                            clearSelection();
                        }
                        else
                        {
                            lblMessage.Visible = true;
                            lblMessage.Text = "Product was not successfully inserted, try again";
                        }

                        // Step 6 - close connection
                        conn.Close();
                        GridView1.DataBind();
                    }
                    else
                    {
                        lblMessage.Visible = true;
                        lblMessage.Text = "Please upload product image!";
                    }
                }
                else
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Product editing detected, please use Update button instead";
                }
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Please don't leave any columns blank";
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (txtName.Text.Trim() != "" && txtDescription.Text.Trim() != "" && txtPrice.Text.Trim() != "" && txtQTY.Text.Trim() != "")
            {
                if (lblPID.Text == "")
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "New product detected, please use Insert button instead";
                }
                else
                {
                    string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                    SqlConnection conn = new SqlConnection(strConn);
                    conn.Open();

                    // Check if a file is uploaded
                    if (fuImage.HasFile)
                    {
                        // Check if the file already exists in the images folder
                        string filename = fuImage.FileName;
                        string imagePath = "~/images/ProductImage/" + filename;
                        string physicalPath = Server.MapPath(imagePath);

                        if (File.Exists(physicalPath))
                        {
                            lblMessage.Visible = true;
                            lblMessage.Text = "File already exists. Using existing file.";
                        }
                        else
                        {
                            // Save the physical file to your folder
                            fuImage.SaveAs(physicalPath);
                            lblMessage.Visible = true;
                            lblMessage.Text = "File uploaded successfully.";
                        }

                        // Save the file path to the database
                        lblFilename.Text = imagePath;
                    }

                    // Save other product details to your database
                    lblDTAdded.Text = DateTime.Now.ToString();
                    // Step 3 - create your sql statement UPDATE

                    string query = "UPDATE Products SET name = @name, description = @description, price = @price, " +
                       "qty = @qty, image = @image, cid = @cid, dtAdded = @dtAdded, active = @active " +
                       "WHERE pid = @pid";

                    // Step 4 - create the command
                    SqlCommand comm = new SqlCommand(query, conn);
                    comm.Parameters.AddWithValue("@name", txtName.Text.Trim());
                    comm.Parameters.AddWithValue("@description", txtDescription.Text.Trim());
                    comm.Parameters.AddWithValue("@price", txtPrice.Text.Trim());
                    comm.Parameters.AddWithValue("@qty", txtQTY.Text.Trim());
                    comm.Parameters.AddWithValue("@image", lblFilename.Text);
                    comm.Parameters.AddWithValue("@cid", ddlCategory.SelectedValue);
                    comm.Parameters.AddWithValue("@dtAdded", DateTime.Now);
                    comm.Parameters.AddWithValue("@active", active.SelectedValue);
                    comm.Parameters.AddWithValue("@pid", lblPID.Text);
                    // Step 5 - execute your command
                    int result = comm.ExecuteNonQuery();
                    if (result > 0)
                    {
                        lblMessage.Visible = true;
                        lblMessage.Text = "Product updated successfully!";
                        clearSelection();
                    }
                    else
                    {
                        lblMessage.Visible = true;
                        lblMessage.Text = "Product update failed, please try again.";
                    }
                    // Step 6 - close connection
                    conn.Close();
                    GridView1.DataBind();
                }
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Please do not leave any columns blank";
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clearSelection();
        }

        private void clearSelection()
        {
            txtName.Text = null;
            txtDescription.Text = null;
            txtPrice.Text = null;
            txtQTY.Text = null;
            lblPID.Text = null;
            ddlCategory.ClearSelection();
            lblCID.Text = null;
            lblFilename.Text = null;
            active.ClearSelection();
        }

        private void loadCategory()
        {
            string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(strConn);
            conn.Open();
            SqlConnection con = new SqlConnection(strConn);
            string com = "Select * FROM Category WHERE active=1";
            SqlDataAdapter adpt = new SqlDataAdapter(com, con);
            DataTable dt = new DataTable();
            adpt.Fill(dt);
            
            ddlCategory.DataSource = dt;
            ddlCategory.DataBind();
            ddlCategory.DataTextField = "name";
            ddlCategory.DataValueField = "cid";
            ddlCategory.DataBind();
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblCID.Text = ddlCategory.SelectedValue.ToString();
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtName.Text = GridView1.SelectedRow.Cells[1].Text;
            txtDescription.Text = GridView1.SelectedRow.Cells[2].Text;
            txtPrice.Text = GridView1.SelectedRow.Cells[3].Text;
            txtQTY.Text = GridView1.SelectedRow.Cells[4].Text;
            string categoryId = GridView1.SelectedRow.Cells[6].Text;
            lblPID.Text = GridView1.SelectedRow.Cells[0].Text;

            // Find the corresponding item in the ddlCategory dropdown list and set it as selected
            ListItem categoryItem = ddlCategory.Items.FindByValue(categoryId);
            if (categoryItem != null)
            {
                ddlCategory.ClearSelection(); // Clear any existing selection
                categoryItem.Selected = true; // Set the found item as selected
            }

            lblCID.Text = categoryId;
            HiddenField hfImageURL = GridView1.SelectedRow.FindControl("hfImageURL") as HiddenField;
            if (hfImageURL != null)
            {
                lblFilename.Text = hfImageURL.Value;
            }

            ListItem Active = active.Items.FindByValue(GridView1.SelectedRow.Cells[9].Text);
            if (Active != null)
            {
                active.ClearSelection(); // Clear any existing selection
                Active.Selected = true; // Set the found item as selected
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int pid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["pid"]);
            string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(strConn);
            conn.Open();
            string query = "DELETE FROM Products WHERE pid=@pid";
            SqlCommand comm = new SqlCommand(query, conn);
            comm.Parameters.AddWithValue("@pid", pid);
            int result = comm.ExecuteNonQuery();
            if (result > 0)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Product deleted successfully!";
                clearSelection();
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Delete product failed, please recheck your input and try again";
            }
            conn.Close();
            GridView1.DataBind();
        }
    }
}