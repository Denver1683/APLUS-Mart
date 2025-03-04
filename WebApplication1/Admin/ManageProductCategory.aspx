<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageProductCategory.aspx.cs" Inherits="WebApplication1.ManageProductCategory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .textfield {
            border: none; /* Remove border */
            border-radius: 25px; /* Make the border capsule-shaped */
            width: 100%; /* Take up full width minus padding */
            box-sizing: border-box; /* Include padding and border in width */
            outline: none; /* Remove default focus outline */
            transition: all 0.3s ease; /* Add transition effect */
            max-width: 400px; /* Maximum width for the text fields */
            padding: 10px;
        }
        .jumbotron {
            background-color: ghostwhite; /* Set background to transparent */
            display: flex; /* Use flexbox layout */
            flex-direction: column; /* Arrange child elements vertically */
            align-items: center;
            margin: 0 auto;
            width: 50vw;
            min-width: 500px;
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
        .textfield-big{
            border: none; /* Remove border */
            border-radius: 10px; /* Make the border capsule-shaped */
            width: 100%; /* Take up full width minus padding */
            box-sizing: border-box; /* Include padding and border in width */
            outline: none; /* Remove default focus outline */
            transition: all 0.3s ease; /* Add transition effect */
            max-width: 400px; /* Maximum width for the text fields */
            padding: 10px;
        }
        .text{
            font-size:16px;
        }
    </style>
    <div class="jumbotron">
        <div style="align-self:flex-start;">
            <h2 style="align-self:flex-start">Admin | Category Management</h2>
            <a style="align-self:flex-start; color:orange" href="AdminHomepage.aspx">< Back to Homepage</a>
        </div>
        <hr />
        <asp:Label runat="server" CssClass="text" Text="Name:"></asp:Label>
        <asp:TextBox ID="txtName" runat="server" CssClass="textfield text"></asp:TextBox>
        <br />
        <asp:Label runat="server" CssClass="text" Text="Description:"></asp:Label>
        <asp:TextBox ID="txtDescription" TextMode="MultiLine" Rows="4" Columns="180" runat="server" CssClass="textfield-big text"></asp:TextBox>
        <br />
        <asp:Label runat="server" CssClass="text" Text="Active:"></asp:Label>
        <asp:DropDownList ID="active" runat="server" CssClass="textfield text">
            <asp:ListItem Text="Active" Value="1"></asp:ListItem>
            <asp:ListItem Text="Inactive" Value="0"></asp:ListItem>
        </asp:DropDownList><br />
        <asp:Label ID="lblCID" runat="server" Visible="false"></asp:Label>
        <asp:Label ID="lblDTAdded" runat="server" Text="Label" Visible="False"></asp:Label>
        <br />
        <br />
        <div style="display:flex; justify-content:space-evenly; width:100%">
            <asp:Button ID="btnInsert" runat="server" Text="Insert/Update" OnClick="btnInsert_Click" CssClass="button text" />
        </div>
        <asp:Label ID="lblMessage" runat="server" Text="Label" Font-Bold="True" Font-Size="Large" ForeColor="Orange" Visible="False"></asp:Label>
        <hr />
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="cid" DataSourceID="SqlDataSource1" 
            EmptyDataText="There are no data records to display." ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" 
            Width="100%" BackColor="#FF9900" CssClass="gridview" OnRowDeleting="GridView1_RowDeleting" Font-Size="14px">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="cid" HeaderText="cid" ReadOnly="True" SortExpression="cid" InsertVisible="False" />
                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                <asp:BoundField DataField="description" HeaderText="description" SortExpression="description" />
                <asp:BoundField DataField="dtAdded" HeaderText="dtAdded" SortExpression="dtAdded" />
                <asp:BoundField DataField="active" HeaderText="active" SortExpression="active" />
                <asp:CommandField ShowSelectButton="True" />
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Category] WHERE [cid] = @cid" InsertCommand="INSERT INTO [Category] ([name], [description], [dtAdded], [active]) VALUES (@name, @description, @dtAdded, @active)" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [Category]" UpdateCommand="UPDATE [Category] SET [name] = @name, [description] = @description, [dtAdded] = @dtAdded, [active] = @active WHERE [cid] = @cid">
            <DeleteParameters>
                <asp:Parameter Name="cid" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="description" Type="String" />
                <asp:Parameter Name="dtAdded" Type="DateTime" />
                <asp:Parameter Name="active" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="description" Type="String" />
                <asp:Parameter Name="dtAdded" Type="DateTime" />
                <asp:Parameter Name="active" Type="Int32" />
                <asp:Parameter Name="cid" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
