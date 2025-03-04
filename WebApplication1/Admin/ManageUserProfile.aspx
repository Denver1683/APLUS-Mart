<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUserProfile.aspx.cs" Inherits="WebApplication1.ManageUserProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .jumbotron {
            background-color: ghostwhite; /* Set background to transparent */
            display: flex; /* Use flexbox layout */
            flex-direction: column; /* Arrange child elements vertically */
            align-items: center;
            margin: 0 auto;
            width: 50vw;
            min-width: 630px;
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
        .textfield {
            border: none; /* Remove border */
            border-radius: 25px; /* Make the border capsule-shaped */
            width: 100%; /* Take up full width minus padding */
            box-sizing: border-box; /* Include padding and border in width */
            outline: none; /* Remove default focus outline */
            transition: all 0.3s ease; /* Add transition effect */
            max-width: 500px; /* Maximum width for the text fields */
            padding: 10px;
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
            <h2 style="align-self:flex-start">Admin | Manage Customer Profile</h2>
            <a style="align-self:flex-start; color:orange" href="AdminHomepage.aspx">< Back to Homepage</a>
        </div>
        <asp:Label runat="server" CssClass="text" Text="Name:"></asp:Label>
        <asp:TextBox ID="txtName" runat="server" CssClass="textfield"></asp:TextBox><br />
        <asp:Label runat="server" CssClass="text" Text="Password:"></asp:Label>
        <asp:TextBox ID="txtPassword" CssClass="textfield" runat="server"></asp:TextBox><br />
        <asp:Label runat="server" CssClass="text" Text="Active:"></asp:Label>
        <asp:DropDownList ID="active" runat="server" CssClass="textfield">
                    <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Inactive" Value="0"></asp:ListItem>
                </asp:DropDownList><br />
        <asp:Label ID="lblSelected" runat="server" Text="false" Visible="false"></asp:Label>
         <br />
        <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" OnClick="btnUpdate_Click" CssClass="button text" />
        <br />
        <asp:Label ID="lblMessage" runat="server" Text="Label" Font-Bold="True" Font-Size="Large" ForeColor="Orange" >Please select user from table</asp:Label>
        <br />

         <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1" 
             EmptyDataText="There is no registered user" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AutoPostBack="true" 
             CssClass="gridview" Width="100%" style="align-self:center;" Font-Size="14px" OnRowDeleting="GridView1_RowDeleting">
            <Columns>
                <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" SortExpression="id" />
                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                <asp:BoundField DataField="email" HeaderText="email" ReadOnly="True" SortExpression="email" />
                <asp:BoundField DataField="password" HeaderText="password" SortExpression="password" />
                <asp:BoundField DataField="dtadded" HeaderText="dtadded" ReadOnly="True" SortExpression="dtadded" />
                <asp:BoundField DataField="active" HeaderText="active" SortExpression="active" />
                <asp:CommandField ShowSelectButton="True" />
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" />
            </Columns>
            <SelectedRowStyle BackColor="#FFFF99" ForeColor="#333333" />
        </asp:GridView>

         <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
             DeleteCommand="DELETE FROM [Customers] WHERE [id] = @id" 
             InsertCommand="INSERT INTO [Customers] ([name], [email], [password], [dtAdded], [active]) VALUES (@name, @email, @password, @dtAdded, @active)" 
             SelectCommand="SELECT * FROM [Customers]" 
             UpdateCommand="UPDATE [Customers] SET [name] = @name, [password] = @password, [active] = @active WHERE [id] = @id">
             <DeleteParameters>
                 <asp:Parameter Name="id" Type="Int32" />
             </DeleteParameters>
             <InsertParameters>
                 <asp:ControlParameter ControlID="txtName" Name="name" PropertyName="Text" Type="String" />
                 <asp:Parameter Name="email" Type="String" />
                 <asp:ControlParameter ControlID="txtPassword" Name="password" PropertyName="Text" Type="String" />
                 <asp:Parameter Name="dtAdded" Type="DateTime" />
                 <asp:ControlParameter ControlID="active" Name="active" PropertyName="SelectedValue" Type="Int32" />
             </InsertParameters>
             <UpdateParameters>
                 <asp:ControlParameter ControlID="txtName" Name="name" PropertyName="Text" Type="String" />
                 <asp:ControlParameter ControlID="txtPassword" Name="password" PropertyName="Text" Type="String" />
                 <asp:ControlParameter ControlID="active" Name="active" PropertyName="SelectedValue" Type="Int32" />
                 <asp:SessionParameter Name="id" SessionField="id" Type="Int32" />
             </UpdateParameters>
         </asp:SqlDataSource>
        <br />
        
         </div>
</asp:Content>
