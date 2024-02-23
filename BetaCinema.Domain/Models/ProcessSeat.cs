namespace BetaCinema.Domain.Models;

public partial class ProcessSeat
{
    public string Id { get; set; } = null!;

    public string ShowtimeId { get; set; } = null!;

    public string SeatId { get; set; } = null!;

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public bool DeleteFlag { get; set; }

    public virtual Seat Seat { get; set; } = null!;

    public virtual Showtime Showtime { get; set; } = null!;
}
