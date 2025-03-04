<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminHomepage.aspx.cs" Inherits="WebApplication1.Admin.AdminHomepage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .button-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top: 50px;
        }
        .button-container .btn {
            margin-bottom: 10px;
        }
        .jumbotron{
            background-color: ghostwhite; /* Set background to transparent */
            display: flex; /* Use flexbox layout */
            flex-direction: column; /* Arrange child elements vertically */
            align-items: center;
            margin: 0 auto;
            width:30vw;
            min-width:500px;
            border-color:orange;
        }
    </style>
    <div class="jumbotron">
        <h2>Admin Menu</h2>
        <div class="button-container">
            <asp:Button ID="btnCategory" runat="server" Text="Manage Categories" OnClick="btnCategory_Click" CssClass="btn btn-warning" Style="color:white; width:200px;"/>
            <asp:Button ID="btnDelivery" runat="server" Text="Manage Delivery" OnClick="btnDelivery_Click" CssClass="btn btn-warning" Style="color:white; width:200px;"/>
            <asp:Button ID="btnProfile" runat="server" Text="Manage Profile" OnClick="btnProfile_Click" CssClass="btn btn-warning" Style="color:white; width:200px;"/>
            <asp:Button ID="btnProducts" runat="server" Text="Manage Products" OnClick="btnProducts_Click" CssClass="btn btn-warning" Style="color:white; width:200px;"/>
            <asp:Button ID="viewCFeedback" runat="server" Text="View Customer's Feedback" CssClass="btn btn-warning" Style="color:white; width:200px;" OnClick="viewCFeedback_Click"/>
            <asp:Button ID="viewGFeedback" runat="server" Text="View Guest's Feedback" CssClass="btn btn-warning" Style="color:white; width:200px;" OnClick="viewGFeedback_Click"/>
        </div>
    </div>
    
</asp:Content>
