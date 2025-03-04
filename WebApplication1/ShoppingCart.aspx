<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ShoppingCart.aspx.cs" Inherits="WebApplication1.ShoppingCart" %>
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
        min-width:800px;
    }
    .cartTable {
        margin: 0 auto; /* Center the cartTable horizontally */
    }
    .icon-button img {
        color:green
    }
    .icon-button2 img {
        color:red
    }
    .empty-cart-message {
        text-align: center;
        font-size: 20px;
        color: red;
    }
    .cartcard {
        margin: 5px; /* Center the container horizontally */
        height: 11rem;
        text-align: left;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
    }
    .text{
        font-size:14px;
    }
    </style>
    <div class="jumbotron">
        <div style="display:flex; justify-content:space-between;"">
            <div>
                <h2>Shopping Cart</h2>
                <a style="align-self:flex-start; color:orange" href="ProductCatalog.aspx">< Back to Product Catalog</a>
            </div>
             <a href="ShoppingHistory.aspx" runat="server" id="history" style="font-size:24px; color:orange" class="d-none d-md-inline-block"><i class="bi bi-clock-history"></i></a>
        </div>
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="select sc.* , p.* , sc.qty * p.price as subtotal
            from ShoppingCart sc, Products p
            where sc.PID = p.PID
            and sc.uid = @uid and sc.status='In Cart'" OnSelecting="SqlDataSource1_Selecting">
            <SelectParameters>
                <asp:SessionParameter Name="uid" SessionField="uid" DefaultValue="" />
            </SelectParameters>
        </asp:SqlDataSource>
        <div class="cartTable">
            <asp:Panel ID="pnlCart" runat="server">
                <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="ListView1_ItemCommand" OnItemDataBound="ListView1_ItemDataBound">
                    <ItemTemplate>
                        <asp:LinkButton ID="itemButton" runat="server" CommandName="update" CssClass="product-link">
                            <div class="bg-white p-3 shadow cartcard rounded-3">
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("image") %>' Height="75px" Width="75px" Style="object-fit:contain; " />
                                <br />
                                <asp:Label ID="pidLabel" runat="server" Visible="false" Text='<%# Eval("pid") %>' />
                                <div style="height:50px"><h2>
                                    <asp:Label ID="nameLabel" runat="server" Text='<%# Eval("name") %>' Font-Size="14px" Style="min-height:50px"/></h2>
                                    <p style="color: orange;" font-size="6px">RM
                                    <asp:Label ID="priceLabel" runat="server" Text='<%# Eval("price") %>' /></p>
                                    Available: <asp:Label ID="lblStock" runat="server" Text='<%# Eval("stockQuantity") %>' />
                                </div>
                                <br />
                                <div style="margin: 0 auto; padding-top:2rem">
                                    <asp:Label runat="server" CssClass="text" Text="Quantity"></asp:Label><br/>
                                    <asp:TextBox ID="txtQTY" TextMode="Number" CssClass="text" runat="server" Text='<%# Eval("qty") %>' oninput="validateQuantity(this)"></asp:TextBox>
                                    <br></br>
                                    <asp:Label ID="stkMessage" runat="server" CssClass="text" Visible="false" Style="color:red" Text='Insufficient stock, please buy equal or less than the available stock'/>
                                </div>
                                <br />
                                <div style="padding:2rem">
                                    <asp:Label Font-Size="14px" runat="server" Text="Subtotal:"></asp:Label><br></br>
                                    <asp:Label ID="subtotalLabel" Font-Size="18px" runat="server" style="color:orange" Text='<%# "RM " + Eval("subtotal") %>' />
                                </div>
                                <br />
                                <br />
                                <div style="padding-top:3rem">
                                    <asp:ImageButton ID="ImageButton2" CommandName="delete" runat="server" ForeColor="Red" ImageUrl="images/trash.svg" Height="20" Width="20"  CssClass="icon-button2" />
                                </div>
                                <br />
                            </div>
                        </asp:LinkButton></ItemTemplate></asp:ListView><br /></asp:Panel><asp:Panel ID="pnlEmptyCart" runat="server" Visible="false">
                <p class="empty-cart-message">Shopping Cart is Empty</p></asp:Panel></div><div class="shoppingcart-bottom" id="scbottom" runat="server" style="display:flex; justify-content:space-between;">
            <h2>Grand Total : RM <asp:Label ID="lblGrandTotal" runat="server" Text="Label" Font-Bold="True" Font-Size="X-Large" ForeColor="Orange"></asp:Label></h2>
            <asp:Button ID="Checkout" runat="server" Text="Checkout" OnClick="Checkout_Click" CssClass="rounded-button"/>
        </div>
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
