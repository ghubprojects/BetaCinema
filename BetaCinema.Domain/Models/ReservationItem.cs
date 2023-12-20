namespace BetaCinema.Domain.Models;

public partial class ReservationItem
{
    public string Id { get; set; } = null!;

    public Guid ReservationId { get; set; }

    public Guid SeatId { get; set; }

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual Reservation Reservation { get; set; } = null!;

    public virtual Seat Seat { get; set; } = null!;
}
