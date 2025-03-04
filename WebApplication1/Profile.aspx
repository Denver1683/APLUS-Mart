<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="WebApplication1.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
       .login-container {
           text-align: center; /* Center align the content inside */
           align-content: center;
           justify-content: center;
           background-color: ghostwhite; /* Semi-transparent orange background */
           border-radius: 10px; /* Optional: adds rounded corners */
           position: relative; /* Ensure proper positioning for child elements */
           display: flex;
       }
       .reg-box {
           width: 70%; /* Adjust as needed for proportion */
           height: 70vh;
           padding: 20px; /* Add some padding for spacing */
           background-color: ghostwhite; /* Semi-transparent orange background */
           border-radius: 10px; /* Optional: adds rounded corners */
           margin: 0 auto;
       }
       .login-container input[type="text"],
       .login-container input[type="password"] {
           border: none; /* Remove border */
           border-radius: 25px; /* Make the border capsule-shaped */
           width: 80%; /* Take up full width minus padding */
           box-sizing: border-box; /* Include padding and border in width */
           outline: none; /* Remove default focus outline */
           transition: all 0.3s ease; /* Add transition effect */
           max-width: 300px; /* Maximum width for the text fields */
       }
       .login-container input[type="text"]:focus,
       .login-container input[type="password"]:focus {
           border-color: orange; /* Change border color on focus */
       }
       .submission input[type="submit"] {
           background-color: orange; /* Button background color */
           color: white; /* Button text color */
           border: none; /* Remove button border */
           border-radius: 25px; /* Make the button capsule-shaped */
           padding: 12px 24px; /* Add padding */
           cursor: pointer; /* Add cursor pointer on hover */
           transition: background-color 0.3s ease; /* Add transition effect */
           margin: 0px auto;
           align-self: center;
       }
       .submission input[type="submit"]:hover {
           background-color: #ff7b00; /* Darker shade of orange on hover */
       }
       .jumbotron {
           background-color: ghostwhite; /* Set background to transparent */
           display: flex; /* Use flexbox layout */
           flex-direction: column; /* Arrange child elements vertically */
           align-items: center; /* Center child elements horizontally */
           width: 40%;
       }
       .submission{
           display: flex;
           flex-direction: column;
           align-items: center;
       }
       .text{
           font-size:14px;
       }
   </style>
    <div class="reg-box">
        <h1>Profile</h1>
        <a style="align-self:flex-start; color:orange;" href="ProductCatalog.aspx">< Back to Homepage</a>
        <div class="login-container">
                <div class="jumbotron">
                    <div class="mb-3">
                        <label for="Name" class="form-label text">Name</label>
                        <asp:TextBox ID="txtName" required runat="server" CssClass="form-control text" placeholder="John Doe" Style="width:20vw"></asp:TextBox>
                    </div>
                    <br />
                    <div class="mb-3">
                        <label for="Email" class="form-label text">Email address</label>
                        <asp:TextBox ID="txtEmail" required runat="server" CssClass="form-control text" placeholder="someone@example.com" ReadOnly="true" Style="width:20vw"></asp:TextBox>
                    </div>
                    <br />
                    <div class="mb-3">
                        <label for="Password" class="form-label text">Password</label>
                        <asp:TextBox ID="txtPassword" required runat="server" CssClass="form-control text" placeholder="Password" Style="width:20vw"></asp:TextBox>
                    </div>
                    <br />
                </div>
                <div class="jumbotron">
                    <div class="mb-3">
                        <label for="Phone" class="form-label text">Phone</label>
                        <asp:TextBox ID="txtPhone" required runat="server" CssClass="form-control text" placeholder="+60 123 456 78" Style="width:20vw"></asp:TextBox>
                    </div>
                    <br />
                    <div class="mb-3">
                        <label for="Address" class="form-label text">Address</label>
                        <asp:TextBox ID="txtAddress" required runat="server" CssClass="form-control text" placeholder="Endah Villa, Kuala Lumpur, Sri Petaling, 57000" Style="width:20vw"></asp:TextBox>
                    </div>
                </div>
        </div>
        <div class="submission">
            <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="text" OnClick="btnUpdate_Click"/>
            <br />
            <asp:Label ID="lblDTAdded" runat="server" Text="Label" Visible="false" Style="align-self:center"></asp:Label>
            <br />
            <br />
            <asp:Label ID="lblMessage" runat="server" Text="Label" Font-Bold="True" Font-Size="Large" ForeColor="Orange" Visible="false" Style="align-self:center"></asp:Label>
            <br />
            <br />
        </div>
        
        <br />
         <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Customers] WHERE [id] = @id" InsertCommand="INSERT INTO [Customers] ([name], [email], [password], [dtAdded], [active],[address],[phone]) VALUES (@name, @email, @password, @dtAdded, @active, @address, @phone)" SelectCommand="SELECT * FROM [Customers]" UpdateCommand="UPDATE [Customers] SET [name] = @name, [email] = @email, [password] = @password, [address] = @address, [phone] = @phone WHERE [id] = @id">
             <DeleteParameters>
                 <asp:Parameter Name="id" Type="Int32" />
             </DeleteParameters>
             <InsertParameters>
                 <asp:ControlParameter ControlID="txtName" Name="name" PropertyName="Text" Type="String" />
                 <asp:ControlParameter ControlID="txtEmail" Name="email" PropertyName="Text" Type="String" />
                 <asp:ControlParameter ControlID="txtPassword" Name="password" PropertyName="Text" Type="String" />
                 <asp:Parameter Name="dtAdded" Type="DateTime" />
                 <asp:Parameter Name="active" Type="Int32" />
                 <asp:ControlParameter ControlID="txtAddress" Name="address" PropertyName="Text" />
                 <asp:ControlParameter ControlID="txtPhone" Name="phone" PropertyName="Text" />
             </InsertParameters>
             <UpdateParameters>
                 <asp:ControlParameter ControlID="txtName" Name="name" PropertyName="Text" Type="String" />
                 <asp:ControlParameter ControlID="txtEmail" Name="email" PropertyName="Text" />
                 <asp:ControlParameter ControlID="txtPassword" Name="password" PropertyName="Text" />
                 <asp:ControlParameter ControlID="txtAddress" Name="address" PropertyName="Text" />
                 <asp:ControlParameter ControlID="txtPhone" Name="phone" PropertyName="Text" />
                 <asp:SessionParameter Name="id" SessionField="uid" Type="Int32" />
             </UpdateParameters>
         </asp:SqlDataSource>
        <br />
         </div>
</asp:Content>
