namespace BetaCinema.Domain.Models;

public partial class Cinema
{
    public string Id { get; set; } = null!;

    public string CinemaName { get; set; } = null!;

    public string CinemaLocation { get; set; } = null!;

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual ICollection<Showtime> Showtimes { get; set; } = new List<Showtime>();
}
