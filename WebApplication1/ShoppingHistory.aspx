<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ShoppingHistory.aspx.cs" Inherits="WebApplication1.ShoppingHistory" %>
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
        .cartcard {
            margin: 5px; /* Center the container horizontally */
            height: 11rem;
            text-align: left;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .cartTable {
            margin: 0 auto; /* Center the cartTable horizontally */
        }
        .jumbotron{
            width: 70vw; 
            margin:0 auto;
            background-color: ghostwhite;
            min-width:800px;
        }
        .header-shoppinghst{
            display:flex; 
            justify-content: space-between;
        }
        .text{
            font-size:14px;
        }
        
    </style>
    <div class="jumbotron">
        <div class="header-shoppinghst">
            <div>
                <h2>Shopping History</h2>
                <a style="align-self:flex-start; color:orange" href="ShoppingCart.aspx">< Back to Shopping Cart</a>
            </div>
            <div style="display:flex; flex-direction: row; align-items:center">
                <asp:Label runat="server" style="padding-right:5px" Font-Size=16px Text="Delivery Status:"></asp:Label>
                <asp:DropDownList ID="ddlDeliveryStatus" runat="server" Font-Size=16px AutoPostBack="true" OnSelectedIndexChanged="ddlDeliveryStatus_SelectedIndexChanged">
                <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                <asp:ListItem Text="On Delivery" Value="On Delivery"></asp:ListItem>
                <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                <asp:ListItem Text="Canceled" Value="Canceled"></asp:ListItem>
            </asp:DropDownList>
            </div>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT sc.*, p.*, sc.qty * p.price AS subtotal
                           FROM ShoppingCart sc
                           INNER JOIN Products p ON sc.PID = p.PID
                           WHERE sc.uid = @uid AND sc.status = 'PAID' AND sc.deliveryStatus = @deliveryStatus">
            <SelectParameters>
                <asp:SessionParameter Name="uid" SessionField="uid" DefaultValue="1" />
                <asp:ControlParameter Name="deliveryStatus" ControlID="ddlDeliveryStatus" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>

        <div class="cartTable">
            <asp:Panel ID="pnlCart" runat="server">
                <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="ListView1_ItemCommand" OnDataBound="ListView1_DataBound">
                    <ItemTemplate>
                        <asp:LinkButton ID="itemButton" runat="server" CommandName="details" CssClass="product-link">
                            <div class="bg-white p-3 shadow cartcard rounded-3">
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("image") %>' Height="75px" Width="75px" Style="object-fit:contain; " />
                                <br />
                                <asp:Label ID="pidLabel" runat="server" Visible="false" Text='<%# Eval("pid") %>' />
                                <div style="height:50px"><h2>
                                    <asp:Label ID="nameLabel" runat="server" Text='<%# Eval("name") %>' Font-Size="14px" Style="min-height:50px"/></h2>
                                    <p style="color: orange;" font-size="6px">RM
                                    <asp:Label ID="priceLabel" runat="server" Text='<%# Eval("price") %>' /></p>
                                    <asp:Label ID="orderid" runat="server" visible="false" Text='<%# Eval("orderID") %>' /></p>
                                </div>
                                <br />
                                <div style="padding-top:2rem">
                                    <asp:Label runat="server" CssClass="text" Text="Quantity"></asp:Label><br/>
                                    <asp:Label ID="txtQTY" runat="server" Text='<%# Eval("qty") %>' CssClass="text" oninput="validateQuantity(this)"></asp:Label>
                                </div>
                                <br />
                                <div style="padding:2rem">
                                    <asp:Label Font-Size="14px" runat="server" Text="Subtotal:"></asp:Label><br></br>
                                    <asp:Label ID="subtotalLabel" Font-Size="18px" runat="server" style="color:orange" Text='<%# "RM " + Eval("subtotal") %>' />
                                </div>
                                <br />
                                <br />
                                <div style="padding-top:3rem">
                                    <asp:ImageButton ID="ImageButton1" visible="false" CommandName="feedback" runat="server" ImageUrl="images/star-fill.svg" Height="20" Width="20" CssClass="icon-button1"  />
                                    <asp:ImageButton ID="ImageButton2" EnableViewState="false" CausesValidation="false" visible="false" CommandName="cancelorder" runat="server" ForeColor="Red" ImageUrl="images/x-octagon-fill.svg" Height="20" Width="20"  CssClass="icon-button2" />
                                </div>
                                <br />
                            </div>
                        </asp:LinkButton></ItemTemplate></asp:ListView><br /></asp:Panel><asp:Panel ID="pnlEmptyCart" runat="server" Visible="false">
                <p class="empty-cart-message">No item with current delilvery status. Go shopping!!!</p></asp:Panel></div>
           </div></asp:Content>