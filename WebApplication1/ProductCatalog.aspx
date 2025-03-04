<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductCatalog.aspx.cs" Inherits="WebApplication1.productCatalog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .product-link {
            text-decoration: none; /* Remove underline */
            color: black; /* Keep the text black */
        }

        .product-link:hover {
            text-decoration: none;
            color: orange;
        }

        .itemcard {
            margin: 5px; /* Center the container horizontally */
            height: 30rem;
            text-align: left;
        }

        .datalist-borderless {
            border: none;
            text-align: left;
            display: flex;
        }

        .jumbotron {
            border: none;
            background-color: transparent;
            margin: 0 auto;
        }
    </style>
    <%--Product Carousell--%>
    <div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner" style="max-height: 400px">
            <div class="carousel-item active" data-bs-interval="10000">
                <img src="~/images/Carousell/IMG_0604.PNG" class="d-block w-100" alt="Image 1" runat="server">
            </div>
            <div class="carousel-item" data-bs-interval="2000">
                <img src="~/images/Carousell/IMG_0600.PNG" class="d-block w-100" alt="Image 2" runat="server">
            </div>
            <div class="carousel-item">
                <img src="~/images/Carousell/IMG_0602.PNG" class="d-block w-100" alt="Image 3" runat="server">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="prev" runat="server">
            <span class="carousel-control-prev-icon" aria-hidden="true" runat="server"></span>
            <span class="visually-hidden" runat="server">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="next" runat="server">
            <span class="carousel-control-next-icon" aria-hidden="true" runat="server"></span>
            <span class="visually-hidden" runat="server">Next</span>
        </button>
    </div>
    <%--Product Catalog Table--%>
    <div class="jumbotron">
        <div style="display:flex; flex-direction: row; align-items:center">
            <asp:Label runat="server" style="padding-right:5px" Font-Size=16px Text="Show by Category:"></asp:Label>
                <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true" Font-Size=16px 
                    OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" style="height: 24px;">
                <asp:ListItem Text="All" Value=""></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="row">
            <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1"
                OnItemCommand="ListView1_ItemCommand" OnItemDataBound="ListView1_ItemDataBound">
                <ItemTemplate>
                    <div class="col-12 col-md-4 col-lg-2">
                        <asp:LinkButton ID="itemButton" runat="server" CommandName="details" CssClass="product-link">
                            <div class="bg-white p-3 shadow itemcard rounded-3">
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("image") %>' Height="150px" Width="100%" Style="align-self: center; object-fit:contain; " />
                                <br />
                                <asp:Label ID="pidLabel" runat="server" Visible="false" Text='<%# Eval("pid") %>' />
                                <div style="height:50px"><h2>
                                    <asp:Label ID="nameLabel" runat="server" Text='<%# Eval("name") %>' Font-Size="18px" Style="min-height:50px"/>

                                </h2></div>
                                <p style="color: orange;" font-size="10px">RM
                                    <asp:Label ID="priceLabel" runat="server" Text='<%# Eval("price") %>' /></p>
                                <p>
                                    <asp:Label ID="ratingLabel" runat="server" Font-Size="14px" Text='<%# Eval("avg_rating") + "/5 Rating" %>' /></p>
                                <br />
                            </div>
                        </asp:LinkButton></div></ItemTemplate></asp:ListView><br />
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="
            SELECT p.pid, p.name, p.price, p.image, p.description,
       AVG(f.rating) AS avg_rating,
       STRING_AGG(f.opinion, '; ') AS opinions
        FROM Products p
        LEFT JOIN Feedback f ON p.pid = f.pid
        WHERE p.active = 1
        GROUP BY p.pid, p.name, p.price, p.image, p.description
        "></asp:SqlDataSource>
    </div>
</asp:Content>
