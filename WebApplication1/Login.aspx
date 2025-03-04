<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication1.login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .login-container {
            width: 40%; /* Adjust as needed for proportion */
            margin: 150px auto; /* Center the container horizontally */
            padding: 20px; /* Add some padding for spacing */
            text-align: center; /* Center align the content inside */
            background-color: ghostwhite; /* Semi-transparent orange background */
            border-radius: 10px; /* Optional: adds rounded corners */
            position: relative; /* Ensure proper positioning for child elements */
        }
        .login-container input[type="text"],
        .login-container input[type="password"] {
            border: none; /* Remove border */
            border-radius: 25px; /* Make the border capsule-shaped */
            width: 100%; /* Take up full width minus padding */
            box-sizing: border-box; /* Include padding and border in width */
            outline: none; /* Remove default focus outline */
            transition: all 0.3s ease; /* Add transition effect */
            max-width: 600px; /* Maximum width for the text fields */
        }
        .login-container input[type="text"]:focus,
        .login-container input[type="password"]:focus {
            border-color: orange; /* Change border color on focus */
        }
        .login-container input[type="submit"] {
            background-color: orange; /* Button background color */
            color: white; /* Button text color */
            border: none; /* Remove button border */
            border-radius: 25px; /* Make the button capsule-shaped */
            padding: 12px 24px; /* Add padding */
            cursor: pointer; /* Add cursor pointer on hover */
            transition: background-color 0.3s ease; /* Add transition effect */
        }
        .login-container input[type="submit"]:hover {
            background-color: #ff7b00; /* Darker shade of orange on hover */
        }
        .jumbotron {
            background-color: ghostwhite; /* Set background to transparent */
            display: flex; /* Use flexbox layout */
            flex-direction: column; /* Arrange child elements vertically */
            align-items: center; /* Center child elements horizontally */
        }
        .text{
            font-size:14px;
        }
    </style>
    <div class="login-container">
        <h1>Login</h1>
        <div class="jumbotron">
            <div class="mb-3">
                <label for="Email" class="form-label text">Email address</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control text" placeholder="someone@example.com" Style="width:20vw"></asp:TextBox>
            </div>
            <br />
            <div class="mb-3">
                <label for="Password" class="form-label text">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control text" placeholder="Password" Style="width:20vw"></asp:TextBox>
            </div>
            <br />
            <asp:Label ID="LoginLabel" runat="server" Text="Incorrect Username/Password" Visible="False" style="color:red; font-size:14px;"></asp:Label>
            <br />
            <a style="font-size:14px; color:blue;" href="Register.aspx">Not a customer yet? Register here.</a>
            <br />
            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
        </div>
    </div>
</asp:Content>
