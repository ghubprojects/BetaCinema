namespace BetaCinema.Domain.Models;

public partial class Reservation
{
    public string Id { get; set; } = null!;

    public string ShowtimeId { get; set; }

    public string UserId { get; set; }

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();

    public virtual ICollection<ReservationItem> ReservationItems { get; set; } = new List<ReservationItem>();

    public virtual Showtime Showtime { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
