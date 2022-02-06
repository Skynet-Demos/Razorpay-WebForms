<%@ Page Title="Registration" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="RazorpayWebForms.Registration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .row {
            margin-bottom: 10px;
        }
    </style>

    <h1>Registration</h1>
    <div>
        <div class="row">
            <div class="col-md-offset-1 col-md-2">
                <asp:Label runat="server" Text="Name" />
            </div>
            <div class="col-md-4">
                <asp:TextBox runat="server" ID="txtName" CssClass="form-control" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-offset-1 col-md-2">
                <asp:Label runat="server" Text="Mobile" />
            </div>
            <div class="col-md-4">
                <asp:TextBox runat="server" ID="txtMobile" CssClass="form-control" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-offset-1 col-md-2">
                <asp:Label runat="server" Text="Email" />
            </div>
            <div class="col-md-4">
                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-offset-1 col-md-2">
                <asp:Label runat="server" Text="Amount" />
            </div>
            <div class="col-md-4">
                <asp:TextBox runat="server" ID="txtAmount" CssClass="form-control" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 text-right">
                <asp:Button runat="server" ID="btnRegister" Text="Register" CssClass="btn btn-primary" 
                    OnClick="btnRegister_Click"/>
            </div>
        </div>
    </div>

    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <script>
        function OpenPaymentWindow(key, amountInSubunits, currency, name, descritpion, imageLogo, orderId, profileName, profileEmail, profileMobile, notes) {
            notes = $.parseJSON(notes);
            var options = {
                "key": key, // Enter the Key ID generated from the Dashboard
                "amount": amountInSubunits, // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise
                "currency": currency,
                "name": name,
                "description": descritpion,
                "image": imageLogo,
                "order_id": orderId, //This is a sample Order ID. Pass the `id` obtained in the response of Step 1
                "handler": function (response) {
                    window.location.href = "Success.aspx?orderId=" + response.razorpay_order_id + "&paymentId=" + response.razorpay_payment_id;
                    //alert(response.razorpay_payment_id);
                    //alert(response.razorpay_order_id);
                    //alert(response.razorpay_signature)
                },
                "prefill": {
                    "name": profileName,
                    "email": profileEmail,
                    "contact": profileMobile
                },
                "notes": notes,
                "theme": {
                    "color": "#F37254"
                }
            };
            var rzp1 = new Razorpay(options);
            rzp1.open();
            rzp1.on('payment.failed', function (response) {
                console.log(response.error);
                alert("Oops, something went wrong and payment failed. Please try again later");
            });
        }

    </script>
</asp:Content>
