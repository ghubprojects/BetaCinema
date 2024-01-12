using BetaCinema.Application.Interfaces.Services;
using BetaCinema.Application.Libraries;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Primitives;

namespace BetaCinema.Infrastructure.Services
{
    public class VnPayService : IVnPayService
    {
        private readonly IConfiguration _configuration;

        public VnPayService(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public string CreatePaymentUrl(Payment model, HttpContext context)
        {
            // Đọc thông tin Vnpay config từ appsettings.json
            var vnpayConfig = _configuration.GetSection("Vnpay");

            var timeZoneById = TimeZoneInfo.FindSystemTimeZoneById(_configuration["TimeZoneId"]);
            var timeNow = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, timeZoneById);
            var tick = DateTime.Now.Ticks.ToString();

            var urlCallBack = _configuration["PaymentCallBack:ReturnUrl"];
            var description = "Dat ve xem phim Beta Cinema. So tien";

            var pay = new VnPayLibrary();
            pay.AddRequestData("vnp_Version", vnpayConfig["Version"]);
            pay.AddRequestData("vnp_Command", vnpayConfig["Command"]);
            pay.AddRequestData("vnp_TmnCode", vnpayConfig["TmnCode"]);
            pay.AddRequestData("vnp_Amount", ((int)model.TotalPrice * 100).ToString());
            pay.AddRequestData("vnp_CreateDate", timeNow.ToString("yyyyMMddHHmmss"));
            pay.AddRequestData("vnp_CurrCode", vnpayConfig["CurrCode"]);
            pay.AddRequestData("vnp_IpAddr", pay.GetIpAddress(context));
            pay.AddRequestData("vnp_Locale", vnpayConfig["Locale"]);
            pay.AddRequestData("vnp_OrderInfo", $"{description} {model.TotalPrice}");
            pay.AddRequestData("vnp_OrderType", "Movie Ticket");
            pay.AddRequestData("vnp_ReturnUrl", urlCallBack);
            pay.AddRequestData("vnp_TxnRef", tick);

            var paymentUrl =
                pay.CreateRequestUrl(vnpayConfig["BaseUrl"], vnpayConfig["HashSecret"]);

            return paymentUrl;
        }

        public PaymentResponse PaymentExecute(Dictionary<string, StringValues> collections)
        {
            var pay = new VnPayLibrary();
            var response = pay.GetFullResponseData(collections, _configuration["Vnpay:HashSecret"]);

            return response;
        }
    }
}
