using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Primitives;

namespace BetaCinema.Application.Interfaces.Services
{
    public interface IVnPayService
    {
        string CreatePaymentUrl(Payment model, HttpContext context);

        PaymentResponse PaymentExecute(Dictionary<string, StringValues> collections);
    }
}
