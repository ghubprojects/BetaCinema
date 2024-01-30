namespace BetaCinema.Domain.DTOs
{
    public class PaymentEmailModel
    {
        public string OrderDescription { get; set; }

        public string OrderId { get; set; }

        public string PaymentId { get; set; }

        public string PaymentMethod { get; set; }
    }
}