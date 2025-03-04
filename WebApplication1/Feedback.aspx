<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="WebApplication1.Feedback" %>
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
        .rating {
          display: flex;
          width: 100%;
          justify-content: center;
          overflow: hidden;
          flex-direction: row-reverse;
          height: 50px;
          position: relative;
        }
        .rating-0 {
          filter: grayscale(100%);
        }
        .rating > input {
          display: none;
        }
        .rating > label {
          cursor: pointer;
          width: 40px;
          height: 40px;
          margin-top: auto;
          background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' width='126.729' height='126.73'%3e%3cpath fill='%23e3e3e3' d='M121.215 44.212l-34.899-3.3c-2.2-.2-4.101-1.6-5-3.7l-12.5-30.3c-2-5-9.101-5-11.101 0l-12.4 30.3c-.8 2.1-2.8 3.5-5 3.7l-34.9 3.3c-5.2.5-7.3 7-3.4 10.5l26.3 23.1c1.7 1.5 2.4 3.7 1.9 5.9l-7.9 32.399c-1.2 5.101 4.3 9.3 8.9 6.601l29.1-17.101c1.9-1.1 4.2-1.1 6.1 0l29.101 17.101c4.6 2.699 10.1-1.4 8.899-6.601l-7.8-32.399c-.5-2.2.2-4.4 1.9-5.9l26.3-23.1c3.8-3.5 1.6-10-3.6-10.5z'/%3e%3c/svg%3e");
          background-repeat: no-repeat;
          background-position: center;
          background-size: 76%;
          transition: .3s;
        }
        .rating > input:checked ~ label,
        .rating > input:checked ~ label ~ label {
          background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' width='126.729' height='126.73'%3e%3cpath fill='%23fcd93a' d='M121.215 44.212l-34.899-3.3c-2.2-.2-4.101-1.6-5-3.7l-12.5-30.3c-2-5-9.101-5-11.101 0l-12.4 30.3c-.8 2.1-2.8 3.5-5 3.7l-34.9 3.3c-5.2.5-7.3 7-3.4 10.5l26.3 23.1c1.7 1.5 2.4 3.7 1.9 5.9l-7.9 32.399c-1.2 5.101 4.3 9.3 8.9 6.601l29.1-17.101c1.9-1.1 4.2-1.1 6.1 0l29.101 17.101c4.6 2.699 10.1-1.4 8.899-6.601l-7.8-32.399c-.5-2.2.2-4.4 1.9-5.9l26.3-23.1c3.8-3.5 1.6-10-3.6-10.5z'/%3e%3c/svg%3e");
        }

        .rating > input:not(:checked) ~ label:hover,
        .rating > input:not(:checked) ~ label:hover ~ label {
          background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' width='126.729' height='126.73'%3e%3cpath fill='%23d8b11e' d='M121.215 44.212l-34.899-3.3c-2.2-.2-4.101-1.6-5-3.7l-12.5-30.3c-2-5-9.101-5-11.101 0l-12.4 30.3c-.8 2.1-2.8 3.5-5 3.7l-34.9 3.3c-5.2.5-7.3 7-3.4 10.5l26.3 23.1c1.7 1.5 2.4 3.7 1.9 5.9l-7.9 32.399c-1.2 5.101 4.3 9.3 8.9 6.601l29.1-17.101c1.9-1.1 4.2-1.1 6.1 0l29.101 17.101c4.6 2.699 10.1-1.4 8.899-6.601l-7.8-32.399c-.5-2.2.2-4.4 1.9-5.9l26.3-23.1c3.8-3.5 1.6-10-3.6-10.5z'/%3e%3c/svg%3e");
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
    <script>
        window.onload = function () {
            var radioButtons = document.querySelectorAll('input[name="rating"]');
            radioButtons.forEach(function (radioButton) {
                radioButton.addEventListener('click', function () {
                    var rating = this.id.split('-')[1];
                    document.getElementById('<%= lblRating.ClientID %>').innerText = rating;
                    document.getElementById('<%= hidRating.ClientID %>').value = rating;
        });
    });
        };

    </script>
    <div class="jumbotron" style="margin: 0 auto;">
        <h2 style="align-self:flex-start">Feedback</h2>
        <a style="align-self:flex-start; color:orange;" href="ShoppingHistory.aspx">< Back to Shopping History</a>
        <br />
        <br />
        <div class="jumbotron-content" style="display:flex; justify-content: space-evenly;">
            <asp:Image ID="imgProduct" Height="100px" Width="100px" runat="server" />
            <div style="display:flex; flex-direction: column;">
                <div class="productnameandprice">
                    <asp:Label ID="lblPID" runat="server" Text="0" Visible="false"></asp:Label>
                    <h3><asp:Label ID="lblPname" runat="server" Text="Product Name"></asp:Label></h3>
                    <p Style="color:orange">RM <asp:Label ID="lblPrice" runat="server" Text="0.00"></asp:Label></p>
                    <asp:Label ID="lblDT" runat="server" Text="Date" Visible="false"></asp:Label>
                </div>
            </div>
        </div>
        <div class="review" style="text-align:center;">
            <asp:HiddenField ID="hidRating" runat="server" Value="0"/>
            <asp:Label runat="server" style="font-size:14px">Rating : <asp:Label ID="lblRating" runat="server"></asp:Label></asp:Label>
            <br />
              <div class="rating">
                <input type="radio" name="rating" id="rating-5">
                <label for="rating-5"></label>
                <input type="radio" name="rating" id="rating-4">
                <label for="rating-4"></label>
                <input type="radio" name="rating" id="rating-3">
                <label for="rating-3"></label>
                <input type="radio" name="rating" id="rating-2">
                <label for="rating-2"></label>
                <input type="radio" name="rating" id="rating-1">
                <label for="rating-1"></label>
              </div>
            <br />
            <asp:Label runat="server" Text="Description" CssClass="text"></asp:Label> <br />
            <asp:TextBox ID="txtDescription" TextMode="MultiLine" Rows="4" Columns="200" CssClass="textfield-big text" 
                runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Submit" runat="server" Text="Submit" OnClick="Submit_Click" CssClass="rounded-button text"/><br />
            <asp:Label ID="lblMessage" runat="server" Text="Label" Font-Bold="True" Font-Size="Large" ForeColor="Orange" Visible="False"></asp:Label>
        </div>
    </div>
</asp:Content>