<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewGuestFeedback.aspx.cs" Inherits="WebApplication1.Admin.ViewGuestFeedback" %>
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
                min-width:768px;
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
            .text{
                font-size:14px;
            }
            </style>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="SELECT * FROM [GuestFeedback]">
        </asp:SqlDataSource>
            <div class="jumbotron">
            <div style="display:flex; justify-content:space-between;"">
                <div>
                    <h2>Guest Feedback</h2>
                    <a style="align-self:flex-start; color:orange" href="AdminHomepage.aspx">< Back to Homepage</a>
                </div>
            </div>
            <br />
            <div class="cartTable">
                <asp:Panel ID="pnlCart" runat="server">
                    <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1">
                        <ItemTemplate>
                                <div class="bg-white p-3 shadow cartcard rounded-3">
                                    <div style="height:50px"><h2>
                                        <asp:Label ID="nameLabel" runat="server" CssClass="text" Text='<%# Eval("Name") %>' Font-Size="14px" Style="min-height:50px"/></h2>
                                        <asp:Label CssClass="text" runat="server" Text="Opinion: "></asp:Label><br />
                                        <asp:Label ID="opinion" style="max-width:100%" runat="server" CssClass="text" Text='<%# Eval("Opinion") %>'></asp:Label>
                                    </div>
                                    <br />
                                    <br />
                                </div>
                            </ItemTemplate>
                    </asp:ListView><br />
                </asp:Panel>
            </div>
            </div>
    </asp:Content>
