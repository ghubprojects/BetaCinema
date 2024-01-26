namespace BetaCinema.Domain.Models;

public partial class Showtime
{
    public string Id { get; set; } = null!;

    public string MovieId { get; set; } = null!;

    public string CinemaId { get; set; } = null!;

    public DateTime? StartTime { get; set; }

    public int TicketPrice { get; set; }

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual Cinema Cinema { get; set; } = null!;

    public virtual Movie Movie { get; set; } = null!;

    public virtual ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();
}
