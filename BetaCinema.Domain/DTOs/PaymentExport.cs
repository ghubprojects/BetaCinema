namespace BetaCinema.Domain.DTOs
{
    public class PaymentExport
    {
        public string UserName { get; set; }

        public string Email { get; set; }

        public string TotalPrice { get; set; }

        public string PaymentTime { get; set; }

        public string DeleteFlag { get; set; }
    }
}
