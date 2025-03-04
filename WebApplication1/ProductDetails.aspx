<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="WebApplication1.productDetails" %>
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
        .error-message {
            color: red;
        }
        .jumbotron{
            width:70vh;
            position:relative; 
            margin: 0 auto;
            background-color: ghostwhite;
        }
        .jumbotron-content{
            display:flex;
            justify-content: space-between;
            justify-self:center;
            background-color: ghostwhite;
        }
        .text{
            font-size:14px;
        }
    </style>
        <div class="jumbotron">
            <a style="color:orange" href="productCatalog.aspx">< Back to Product Catalog</a>
            <div class="jumbotron-content">
                <div class="productinfo">
                    <asp:Image ID="imgProduct" Height="200" Width="200" runat="server" /><br />
                    <h2><asp:Label ID="lblPname" runat="server" Text="Product Name"></asp:Label><br /></h2>
                    <h3 Style="color: orange;">RM <asp:Label ID="lblPrice" runat="server" Text="0.00"></asp:Label><br /></h3>
                    <asp:Label runat="server" CssClass="text" Text="Stock: "></asp:Label>
                    <asp:Label ID="lblStock" runat="server" CssClass="text" Text="0"></asp:Label> &nbsp;<asp:Label runat="server" CssClass="text" Text="available"></asp:Label>
                    <br />
                    <asp:Label runat="server" CssClass="text" Text="Description: "></asp:Label>
                    <p><asp:Label ID="lblDesc" runat="server" Text="Lorem Ipsum" Font-Size="12px"></asp:Label><br /></p>
                </div>
                <div class="addtocart" id="addtocart" runat="server" style="justify-content: center; display:flex; align-items:center;">
                    <div class="addtocart-content" style="text-align:center;">
                        <asp:Label runat="server" CssClass="text" Text="Quantity:"></asp:Label>
                        <asp:TextBox ID="txtQuantity" TextMode="Number" runat="server" CssClass="text" oninput="validateQuantity(this)">1</asp:TextBox>
                        <br />
                        <asp:Label ID="stkMessage" runat="server" Text="Insufficient stock, please buy equal or less than stock." Visible="false" CssClass="error-message"></asp:Label>
                        <br />
                        <br />
                        <asp:Button ID="btnAdd" runat="server" Text="Add to Cart" OnClick="btnAdd_Click"  CssClass="rounded-button text"/>
                        <br />
                        <asp:Label ID="lblMessage" runat="server" Visible="false" Text="Label"></asp:Label>
                        <br />
                    </div>
                </div>
            </div>
             <asp:Label ID="PLogin" runat="server" Text="Please Login to Purchase Products" Visible="false" CssClass="error-message text"></asp:Label><br />
            <asp:Label ID="lblReview" runat="server" CssClass="text" Text="Reviews:"></asp:Label>

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
                ShoppingCart sc ON f.orderID = sc.orderID
            WHERE
                p.pid=@pid;
            ">
                    <SelectParameters>
                        <asp:SessionParameter Name="pid" SessionField="pid" />
                    </SelectParameters>
                </asp:SqlDataSource>

            <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                        <div class="bg-white p-3 shadow cartcard rounded-3">
                            <div style="height:20px">
                                <h2><asp:Label ID="lblName" runat="server" Text='<%# Eval("CustomerName") %>' /></h2>
                            </div>
                            <div style="margin: 0 auto; padding-top:2rem">
                                <asp:Label runat="server" CssClass="text" Text="Rating:"></asp:Label>
                                <asp:Label ID="rating" runat="server" Text='<%# Eval("FeedbackRating") %>'></asp:Label><br />
                                <br />
                                <asp:Label runat="server" CssClass="text" Text="Opinion:"></asp:Label><br/>
                                <asp:Label ID="opinion" runat="server" Text='<%# Eval("FeedbackOpinion") %>'></asp:Label>
                                <br></br>
                            </div>
                        </div>
                    </ItemTemplate>
            </asp:ListView>

        </div>
    <script type="text/javascript">
        function validateQuantity(input) {
            var value = parseInt(input.value);
            if (isNaN(value) || value <= 1) {
                input.value = 1;
            }
         }
    </script>
</asp:Content>
