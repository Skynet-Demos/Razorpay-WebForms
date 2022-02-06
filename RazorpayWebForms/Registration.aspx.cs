using Newtonsoft.Json;
using Razorpay.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RazorpayWebForms
{
    public partial class Registration : System.Web.UI.Page
    {

        private const string _key = "your_key";
        private const string _secret = "your_secret";
        private const decimal registrationAmount = 100;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtAmount.Text = registrationAmount.ToString();
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            decimal amountinSubunits = registrationAmount * 100;
            string currency = "INR";
            string name = "Skynet";
            string description = "Razorpay Payment Gateway Demo";
            string imageLogo = "";
            string profileName = txtName.Text;
            string profileMobile = txtMobile.Text;
            string profileEmail = txtEmail.Text;
            Dictionary<string, string> notes = new Dictionary<string, string>()
            {
                { "note 1", "this is a payment note" }, { "note 2", "here another note, you can add max 15 notes" }
            };

            string orderId = CreateOrder(amountinSubunits, currency, notes);

            string jsFunction = "OpenPaymentWindow('"+ _key +"', '"+ amountinSubunits +"', '"+ currency +"', '"+ name +"', '"+ description +"', '"+ imageLogo +"', '"+ orderId +"', '"+ profileName +"', '"+ profileEmail +"', '"+ profileMobile +"', '"+ JsonConvert.SerializeObject(notes) +"');";
            ClientScript.RegisterStartupScript(this.GetType(), "OpenPaymentWindow", jsFunction, true);
        }

        private string CreateOrder(decimal amountInSubunits, string currency, Dictionary<string, string> notes)
        {
            try
            {
                int paymentCapture = 1;

                RazorpayClient client = new RazorpayClient(_key, _secret);
                Dictionary<string, object> options = new Dictionary<string, object>();
                options.Add("amount", amountInSubunits);
                options.Add("currency", currency);
                options.Add("payment_capture", paymentCapture);
                options.Add("notes", notes);

                System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12;
                System.Net.ServicePointManager.Expect100Continue = false;

                Order orderResponse = client.Order.Create(options);
                var orderId = orderResponse.Attributes["id"].ToString();
                return orderId;
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}