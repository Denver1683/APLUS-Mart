<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="WebApplication1.Payment" %>
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
        .jumbotron{
            width: 60vh;
            min-width: 768px;
            margin:0 auto;
            background-color: ghostwhite;
        }
        .cartTable {
            margin: 0 auto; /* Center the cartTable horizontally */
        }
        .text{
            font-size:14px;
        }
    </style>
    <div class="jumbotron">
    <h2>Payment Page</h2>
    <a style="align-self:flex-start; color:orange" href="ShoppingCart.aspx">< Back to Shopping Cart</a>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
    SelectCommand="select sc.* , p.* , sc.qty * p.price as subtotal
        from ShoppingCart sc, Products p
        where sc.PID = p.PID
        and sc.uid = @uid and sc.status='In Cart'">
        <SelectParameters>
            <asp:SessionParameter Name="uid" SessionField="uid" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
     <div class="cartTable">
         <asp:DataList ID="DataList1" runat="server" Width="100%" CssClass="cartTable" DataSourceID="SqlDataSource1" CellPadding="10" CellSpacing="10" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Medium" Font-Strikeout="False" Font-Underline="False" ForeColor="Black" GridLines="Vertical" ShowFooter="False" ShowHeader="False">
             <HeaderStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
             <HeaderTemplate>
                 <table class="table table-borderless table-striped table-hover" style="background-color:ghostwhite">
             </HeaderTemplate>
             <ItemTemplate>
                 <tr>
                     <td>
                         <asp:Label ID="PIDLabel" runat="server" Visible="false" Text='<%# Eval("PID") %>' />
                         <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("image") %>'
                             Width="50" Height="50" />
                     </td>
                     <td>
                         <asp:Label ID="nameLabel" runat="server" Text='<%# Eval("name") %>' />
                         <br />
                         <asp:Label ID="priceLabel" runat="server" style="color:orange" Text='<%# "RM " + Eval("price") %>' />
                         <br />
                     </td>
                     <td>
                         Quantity:<br/>
                         <asp:Label ID="qtylabel" runat="server" Text='<%# Eval("qty") %>' />
                         </br>
                     </td>
                     <td>
                         Subtotal:<br />
                         <asp:Label ID="subtotalLabel" runat="server" style="color:orange" Text='<%# "RM " + Eval("subtotal") %>' />
                     </td>
                 </tr>
             </ItemTemplate>
         </asp:DataList>
     </div>
        <br/>
        <br/>
    <div class="payment-bottom" style="display:flex; justify-content:space-between;">
        <div class="payment-amount">
            <h2>Grand Total : RM <asp:Label ID="lblGrandTotal" runat="server" Text="0" Font-Bold="True" Font-Size="X-Large" ForeColor="Orange"></asp:Label></h2>
            <div style="display:flex">
                <asp:Label runat="server" Text="Paid: RM " CssClass="text"></asp:Label>
                <asp:TextBox ID="amtPaid" TextMode="Number" runat="server" CssClass="text form-control" Text="0"></asp:TextBox>
            </div>
            <asp:Label ID="notenough" runat="server" Text="Please Pay in Full Amount" Font-Bold="True" ForeColor="Orange" CssClass="text" Visible="false"></asp:Label>
        </div>
        <asp:Button ID="Checkout" runat="server" Text="Pay" CssClass="rounded-button text" OnClick="Checkout_Click"/>
    </div>
</div>
</asp:Content>
