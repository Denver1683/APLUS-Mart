<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageProduct.aspx.cs" Inherits="WebApplication1.ManageProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .product-image {
            width: 200px; /* Set the width as desired */
            height: 200px; /* Set the height as desired */
        }
        .jumbotron{
            background-color: ghostwhite; /* Set background to transparent */
            display: flex; /* Use flexbox layout */
            flex-direction: column; /* Arrange child elements vertically */
            align-items: center;
            margin: 0 auto;
            width:70vw;
            min-width:700px;
        }
        .textfield{
            border: none; /* Remove border */
            border-radius: 25px; /* Make the border capsule-shaped */
            width: 100%; /* Take up full width minus padding */
            box-sizing: border-box; /* Include padding and border in width */
            outline: none; /* Remove default focus outline */
            transition: all 0.3s ease; /* Add transition effect */
            max-width: 500px; /* Maximum width for the text fields */
            padding: 10px;
        }
        .textfield-big{
            border: none; /* Remove border */
            border-radius: 10px; /* Make the border capsule-shaped */
            width: 100%; /* Take up full width minus padding */
            box-sizing: border-box; /* Include padding and border in width */
            outline: none; /* Remove default focus outline */
            transition: all 0.3s ease; /* Add transition effect */
            max-width: 500px; /* Maximum width for the text fields */
            padding: 10px;
        }
        .button {
            background-color: orange; /* Button background color */
            color: white; /* Button text color */
            border: none; /* Remove button border */
            border-radius: 25px; /* Make the button capsule-shaped */
            padding: 12px 24px; /* Add padding */
            cursor: pointer; /* Add cursor pointer on hover */
            transition: background-color 0.3s ease; /* Add transition effect */
        }
        .button:hover {
            background-color: #ff7b00; /* Darker shade of orange on hover */
        }
        .mproductcontainer{
            text-align: center; /* Center align the content inside */
            align-content: center;
            justify-content: center;
            background-color: ghostwhite; /* Semi-transparent orange background */
            border-radius: 10px; /* Optional: adds rounded corners */
            position: relative; /* Ensure proper positioning for child elements */
            display: flex;
            width:100%;
        }
        .jumbotron-content{
            background-color: ghostwhite; /* Set background to transparent */
            display: flex; /* Use flexbox layout */
            flex-direction: column; /* Arrange child elements vertically */
            align-items: center; /* Center child elements horizontally */
            width: 40%;
            padding:10px;
        }
        /* GridView Styles */
        .gridview {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid orange; /* Border color */
            margin-top: 20px;
        }
        .gridview th {
            background-color: orange; /* Header background color */
            color: white; /* Header text color */
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid gray; /* Border color */
        }
        .gridview td {
            padding: 8px;
            border-bottom: 1px solid gray; /* Border color */
        }
        .gridview tr:nth-child(even) {
            background-color: #f2f2f2; /* Alternate row background color */
        }
        .gridview select {
            width: 100%;
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
        .gridview .button {
            background-color: orange; /* Button background color */
            color: white; /* Button text color */
            border: none; /* Remove button border */
            border-radius: 5px; /* Make the button capsule-shaped */
            padding: 8px 16px; /* Add padding */
            cursor: pointer; /* Add cursor pointer on hover */
            transition: background-color 0.3s ease; /* Add transition effect */
        }
        .gridview .button:hover {
            background-color: #ff7b00; /* Darker shade of orange on hover */
        }
        .text{
            font-size:16px;
        }
    </style>
    <div class="jumbotron">
        <div style="align-self:flex-start;">
            <h2 style="align-self:flex-start">Admin | Products Management</h2>
            <a style="align-self:flex-start; color:orange" href="AdminHomepage.aspx">< Back to Homepage</a>
        </div>
        <hr />
        <div class="mproductcontainer">
            <div class="jumbotron-content">
                <asp:Label runat="server" CssClass="text" Text="New Image:"></asp:Label>
                <asp:FileUpload ID="fuImage" runat="server" Style="align-self:center"/>
                <asp:Label ID="lblFilename" runat="server" Text="No File Selected" Visible="false"></asp:Label>
                <br />
                <br />
                <asp:Label runat="server" CssClass="text" Text="Name :"></asp:Label>
                <asp:TextBox ID="txtName" runat="server" CssClass="textfield text"></asp:TextBox>
                <br />
                <asp:Label runat="server" CssClass="text" Text="Description:"></asp:Label>
                <asp:TextBox ID="txtDescription"  CssClass="textfield-big text" TextMode="MultiLine" Rows="4" Columns="180" runat="server"></asp:TextBox>
                <br />
            </div>
            <div class="jumbotron-content">
                <asp:Label runat="server" CssClass="text" Text="Price: RM "></asp:Label>
                <asp:TextBox ID="txtPrice" runat="server" TextMode="Number"  CssClass="textfield text"></asp:TextBox>
                <br />
                <asp:Label runat="server" CssClass="text" Text="Stock: "></asp:Label>
                <asp:TextBox ID="txtQTY" runat="server" TextMode="Number" CssClass="textfield text"></asp:TextBox>
                <br />
                <asp:Label runat="server" CssClass="text" Text="Category: "></asp:Label>
                <asp:DropDownList ID="ddlCategory"  CssClass="textfield text" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged"></asp:DropDownList>
                <asp:Label ID="lblCID" runat="server" Text="1" Visible="False"></asp:Label>
                <br />
                <asp:Label runat="server" CssClass="text" Text="Active: "></asp:Label>
                <asp:DropDownList ID="active" runat="server"  CssClass="textfield text">
                    <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Inactive" Value="0"></asp:ListItem>
                </asp:DropDownList><br />
            </div>
        </div>
        <asp:Label ID="lblDTAdded" runat="server" Text="Label" EnableTheming="True" Visible="False"></asp:Label>
        <asp:Label ID="lblPID" runat="server" Text="Label" EnableTheming="True" Visible="False"></asp:Label>
        <br />
        <br />
        <div class="actionbuttons" style="display:flex; justify-content:space-evenly; width:80%">
            <asp:Button ID="btnInsert" runat="server" Text="Insert" CssClass="button text" OnClick="btnInsert_Click"  />
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="button text" OnClick="btnUpdate_Click" />
            <asp:Button ID="btnClear" runat="server" Text="Clear Selection" CssClass="button text" OnClick="btnClear_Click" />
        </div>
        <br />
        <asp:Label ID="lblMessage" runat="server" Text="Label" Font-Bold="True" Font-Size="Large" ForeColor="Orange" Visible="false"></asp:Label>
        
        <hr />
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="pid" DataSourceID="SqlDataSource1" EmptyDataText="There are no data records to display." 
            OnSelectedIndexChanged="GridView1_SelectedIndexChanged" CssClass="gridview" OnRowDeleting="GridView1_RowDeleting" Width="100%" Font-Size="14px">
            <Columns>
                <asp:BoundField DataField="pid" HeaderText="PID" ReadOnly="True" SortExpression="pid" />
                <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" />
                <asp:BoundField DataField="price" HeaderText="Price" SortExpression="price" />
                <asp:BoundField DataField="qty" HeaderText="Stock" SortExpression="qty" />
                <asp:TemplateField HeaderText="Product Image">
                    <ItemTemplate>
                        <asp:HiddenField ID="hfImageURL" runat="server" Value='<%# Eval("image") %>' />
                        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("image") %>' CssClass="product-image" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="cid" HeaderText="CID" SortExpression="cid" />
                <asp:BoundField DataField="dtAdded" HeaderText="Date Added" SortExpression="dtAdded" />
                <asp:BoundField DataField="active" HeaderText="Active (0-False)" SortExpression="active" />
                <asp:CommandField ShowSelectButton="True" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Products] WHERE [pid] = @pid" InsertCommand="INSERT INTO [Products] ([name], [description], [price], [qty], [image], [cid], [dtAdded], [active]) VALUES (@name, @description, @price, @qty, @image, @cid, @dtAdded, @active)" SelectCommand="SELECT [pid], [name], [description], [price], [qty], [image], [cid], [dtAdded], [active] FROM [Products]" UpdateCommand="UPDATE [Products] SET [name] = @name, [description] = @description, [price] = @price, [qty] = @qty, [image] = @image, [cid] = @cid, [dtAdded] = @dtAdded, [active] = @active WHERE [pid] = @pid" >
            <DeleteParameters>
                <asp:Parameter Name="pid" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="txtName" Name="name" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtDescription" Name="description" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtPrice" Name="price" PropertyName="Text" Type="Decimal" />
                <asp:ControlParameter ControlID="txtQTY" Name="qty" PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="fuImage" Name="image" PropertyName="FileBytes" Type="String" />
                <asp:ControlParameter ControlID="lblCID" Name="cid" PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="lblDTAdded" Name="dtAdded" PropertyName="Text" Type="DateTime" />
                <asp:ControlParameter ControlID="lblActive" Name="active" PropertyName="Text" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="description" Type="String" />
                <asp:Parameter Name="price" Type="Decimal" />
                <asp:Parameter Name="qty" Type="Int32" />
                <asp:Parameter Name="image" Type="String" />
                <asp:Parameter Name="cid" Type="Int32" />
                <asp:Parameter Name="dtAdded" Type="DateTime" />
                <asp:Parameter Name="active" Type="Int32" />
                <asp:Parameter Name="pid" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        </div>
</asp:Content>
