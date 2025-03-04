<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GuestFeedback.aspx.cs" Inherits="WebApplication1.GuestFeedback" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
 <style>
     .rounded-button {
         padding: 10px 20px;
         border: none;
         border-radius: 20px;
         background-color: orange;
         color: white;
         text-decoration: none;
         cursor: pointer;
     }
     .rounded-button:hover {
         background-color: #ff7b00;
     }
     .error-message {
         color: red;
     }
     .jumbotron{
        width: 50vw; 
        margin:0 auto;
        background-color: ghostwhite;
    }
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
         font-size:14px;
     }
 </style>

 <div class="jumbotron">
     <h2 style="align-self:flex-start">Guest Feedback</h2>
     <a style="align-self:flex-start; color:orange" href="ProductCatalog.aspx">< Back to Homepage</a>
     <div class="review" style="text-align:center;">
         <asp:Label runat="server" CssClass="text" Text="Name:"></asp:Label><br />
         <asp:TextBox ID="txtName" runat="server" CssClass="textfield text"></asp:TextBox>
         <br />
         <asp:Label runat="server" CssClass="text" Text="Feedback:"></asp:Label><br />
         <asp:TextBox ID="txtDescription" TextMode="MultiLine" Rows="4" Columns="180" runat="server" CssClass="textfield-big text"></asp:TextBox><br />
         <asp:Button ID="Submit" runat="server" Text="Submit" CssClass="rounded-button text" OnClick="Submit_Click" /><br />
         <asp:Label ID="lblMessage" runat="server" Text="Label" Font-Bold="True" Font-Size="Large" ForeColor="Orange" Visible="False"></asp:Label>
     </div>

 </div>
</asp:Content>
