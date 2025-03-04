using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication1
{
    public partial class ManageProductCategory : System.Web.UI.Page
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
                clearSelection();
            }
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            // Step 1 - connect to database
            string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                if (txtName.Text.Trim() != "" && txtDescription.Text.Trim() != "")
                {
                    if (lblCID.Text != "none")
                    {
                        //Update Category
                        conn.Close();
                        conn.Open();
                        string query = "UPDATE Category SET name=@name, description=@description, active=@active WHERE cid=@cid";
                        SqlCommand comm = new SqlCommand(query, conn);
                        comm.Parameters.AddWithValue("@name", txtName.Text.Trim());
                        comm.Parameters.AddWithValue("@description", txtDescription.Text.Trim());
                        comm.Parameters.AddWithValue("@cid", int.Parse(lblCID.Text));
                        comm.Parameters.AddWithValue("@active", active.SelectedValue);
                        int result = comm.ExecuteNonQuery();
                        if (result > 0)
                        {
                            lblMessage.Visible = true;
                            lblMessage.Text = "Category updated successfully!";
                            clearSelection();
                        }
                        else
                        {
                            lblMessage.Visible = true;
                            lblMessage.Text = "Category was not successfully updated, try again";
                        }
                        conn.Close();
                        GridView1.DataBind();
                        //Redirect to Admin Homepage
                    }
                    else if (lblCID.Text == "none")
                    {
                        // Step 3 - create your sql statement INSERT
                        string query3 = "INSERT INTO Category(name,description,dtAdded,active) " +
                            "VALUES(@name,@description,@dtAdded,@active)";
                        // Step 4 - create the command
                        using (SqlCommand comm3 = new SqlCommand(query3, conn))
                        {
                            conn.Open();
                            comm3.Parameters.AddWithValue("@name", txtName.Text.Trim());
                            comm3.Parameters.AddWithValue("@description", txtDescription.Text.Trim());
                            comm3.Parameters.AddWithValue("@dtAdded", DateTime.Now);
                            comm3.Parameters.AddWithValue("@active", active.SelectedValue);
                            // Step 5 - execute your command
                            int result = comm3.ExecuteNonQuery();
                            if (result > 0)
                            {
                                lblMessage.Visible = true;
                                lblMessage.Text = "Inserted new category successfully";
                                conn.Close();
                                clearSelection();
                            }
                            else
                            {
                                lblMessage.Visible = true;
                                lblMessage.Text = "Insert new category failed, please try again.";
                                conn.Close();
                            }
                        }
                    }
                }
                else
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Please do not leave any column blank";
                }
            } 
            GridView1.DataBind();
        }



        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtName.Text = GridView1.SelectedRow.Cells[1].Text;
            txtDescription.Text = GridView1.SelectedRow.Cells[2].Text;
            active.SelectedValue = GridView1.SelectedRow.Cells[4].Text;
            lblCID.Text = GridView1.SelectedRow.Cells[0].Text;
        }

        private void clearSelection()
        {
            txtName.Text = null;
            txtDescription.Text = null;
            active.SelectedValue = null;
            lblCID.Text = "none";
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int cid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["cid"]);
            string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(strConn);
            conn.Open();
            string query = "DELETE FROM Category WHERE cid=@cid";
            SqlCommand comm = new SqlCommand(query, conn);
            comm.Parameters.AddWithValue("@cid", cid);
            int result = comm.ExecuteNonQuery();
            if (result > 0)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Category deleted successfully!";
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Delete category failed, please recheck your input and try again";
            }
            conn.Close();
            GridView1.DataBind();
        }
    }
}