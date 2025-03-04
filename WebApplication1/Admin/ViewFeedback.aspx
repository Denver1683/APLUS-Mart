<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewFeedback.aspx.cs" Inherits="WebApplication1.Admin.ViewFeedback" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .rounded-button {
            padding: 10px 0px;
            border: none;
            border-radius: 20px;
            background-color: orange;
            color: white;
            text-decoration: none;
            cursor: pointer;
        }
        .product-link {
            text-decoration: none; /* Remove underline */
            color: black; /* Keep the text black */
        }

        .product-link:hover {
            text-decoration: none;
            color: black;
        }
        .jumbotron{
            width: 70vw; 
            margin:0 auto;
            background-color: ghostwhite;
            min-width:700px;
        }
        .cartTable {
            margin: 0 auto; /* Center the cartTable horizontally */
        }
        .cartcard {
            margin: 5px; /* Center the container horizontally */
            height: 11rem;
            text-align: left;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        </style>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT DISTINCT
    f.uid AS FeedbackUserID,
    f.pid AS FeedbackProductID,
    f.dtadded AS FeedbackDateAdded,
    f.rating AS FeedbackRating,
    f.opinion AS FeedbackOpinion,
    f.trdate AS FeedbackTransactionDate,
    f.orderID AS FeedbackOrderID,
    p.name AS ProductName,
    p.price AS ProductPrice,
    p.image AS ProductImage,
    c.id AS CustomerID,
    c.name AS CustomerName,
    sc.pid AS ShoppingCartProductID,
    sc.qty AS ShoppingCartQuantity
FROM
    Feedback f
LEFT JOIN
    Products p ON f.pid = p.pid
LEFT JOIN
    Customers c ON f.uid = c.id
LEFT JOIN
    ShoppingCart sc ON f.orderID = sc.orderID;
">
    </asp:SqlDataSource>
        <div class="jumbotron">
        <div style="display:flex; justify-content:space-between;"">
            <div>
                <h2>Customer Feedback</h2>
                <a style="align-self:flex-start; color:orange" href="AdminHomepage.aspx">< Back to Homepage</a>
            </div>
        </div>
        <br />
        <div class="cartTable">
            <asp:Panel ID="pnlCart" runat="server">
                <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1">
                    <ItemTemplate>
                            <div class="bg-white p-3 shadow cartcard rounded-3">
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("ProductImage") %>' Height="75px" Width="75px" Style="object-fit:contain; " />
                                <br />
                                <div style="height:50px"><h2>
                                    <asp:Label ID="nameLabel" runat="server" Text='<%# Eval("ProductName") %>' Font-Size="14px" Style="min-height:50px"/></h2>
                                    <p style="color: orange;" font-size="6px">RM
                                    <asp:Label ID="priceLabel" runat="server" Text='<%# Eval("ProductPrice") %>' /></p>
                                    <asp:Label ID="lblStock" runat="server" style="font-size:14px" Text='<%# "Customer: " + Eval("CustomerName") %>' />
                                </div>
                                <br />
                                <div style="margin: 0 auto; padding-top:2rem">
                                    <asp:Label ID="rating" style="font-size:14px" runat="server" Text='<%# "Rating: " + Eval("FeedbackRating") %>'></asp:Label><br />
                                    <asp:Label style="font-size:14px" runat="server" Text="Opinion: "></asp:Label><br />
                                    <asp:Label ID="opinion" style="font-size:14px; max-width:100%" runat="server" Text='<%# Eval("FeedbackOpinion") %>'></asp:Label>
                                    <br></br>
                                </div>
                                <br />
                                <br />
                            </div>
                        </ItemTemplate>
                </asp:ListView><br />
            </asp:Panel></div>
        </div>
</asp:Content>