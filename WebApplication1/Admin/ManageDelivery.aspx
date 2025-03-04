<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageDelivery.aspx.cs" Inherits="WebApplication1.manageDelivery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .jumbotron {
            background-color: ghostwhite; /* Set background to transparent */
            display: flex; /* Use flexbox layout */
            flex-direction: column; /* Arrange child elements vertically */
            align-items: center;
            margin: 0 auto;
            width: 60vw;
            min-width: 500px;
        }
        /* Style for the GridView */
        .gridview {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid #ddd; /* Border color */
        }
        
        /* Style for the header row */
        .gridview th {
            background-color: #f5bf42; /* Header background color */
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd; /* Border color */
        }
        
        /* Style for the data rows */
        .gridview td {
            padding: 8px;
            border-bottom: 1px solid #ddd; /* Border color */
        }
        
        /* Style for alternate rows */
        .gridview tr:nth-child(even) {
            background-color: #f2f2f2; /* Alternate row background color */
        }
        
        /* Style for the dropdownlist */
        .gridview select {
            width: 100%;
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
        
        /* Style for the save button */
        .gridview .saveButton {
            padding: 5px 10px;
            background-color: orange; /* Button background color */
            color: white; /* Button text color */
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        
        /* Style for the save button on hover */
        .gridview .saveButton:hover {
            background-color: darkorange; /* Hover background color */
        }
    </style>
    <div class="jumbotron">
        <div style="align-self:flex-start;">
            <h2 style="align-self:flex-start">Admin | Manage Delivery</h2>
            <a style="align-self:flex-start; color:orange" href="AdminHomepage.aspx">< Back to Homepage</a>
        </div>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EmptyDataText="There is currently no order" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AutoPostBack="true" CssClass="gridview">
            <Columns>
                <asp:BoundField DataField="UserName" HeaderText="Customer's Name" />
                <asp:BoundField DataField="orderID" HeaderText="Order ID" />
                <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                <asp:BoundField DataField="pid" HeaderText="Product ID" />
                <asp:BoundField DataField="qty" HeaderText="Quantity" />
                <asp:BoundField DataField="dtadded" HeaderText="Date Ordered" />
                <asp:BoundField DataField="address" HeaderText="Address" />
                <asp:BoundField DataField="phone" HeaderText="Phone Number" />
                <asp:BoundField DataField="status" HeaderText="Status" />
                <asp:TemplateField HeaderText="Delivery Status">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlDeliveryStatus" runat="server" SelectedValue='<%# Bind("deliveryStatus") %>' CssClass="ddlDeliveryStatus">
                            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                            <asp:ListItem Text="On Delivery" Value="On Delivery"></asp:ListItem>
                            <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                            <asp:ListItem Text="Canceled" Value="Canceled"></asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:Button ID="saveButton" runat="server" Text="Save" CommandName="Save" CommandArgument='<%# Eval("orderID") %>' OnClick="saveButton_Click" CssClass="saveButton" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="SELECT c.id AS uid, c.name AS UserName, c.address AS address, c.phone AS phone, p.pid AS pid, p.name AS ProductName, sc.qty, 
            sc.dtadded, sc.status, sc.deliveryStatus ,sc.orderID
                           FROM ShoppingCart sc 
                           INNER JOIN Customers c ON sc.uid = c.id 
                           INNER JOIN Products p ON sc.pid = p.pid 
                           WHERE (sc.deliveryStatus = 'Pending' OR sc.deliveryStatus = 'On Delivery') AND sc.status = 'PAID'">
        </asp:SqlDataSource>
    </div>
</asp:Content>
