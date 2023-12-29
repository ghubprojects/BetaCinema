namespace BetaCinema.Domain.Models;

public partial class Payment
{
    public string Id { get; set; } = null!;

    public string ReservationId { get; set; }

    public int TotalPrice { get; set; }

    public string PaymentMethod { get; set; } = null!;

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual Reservation Reservation { get; set; } = null!;
}
