namespace BetaCinema.Domain.Models;

public partial class Movie
{
    public string Id { get; set; } = null!;

    public string MovieName { get; set; } = null!;

    public string? Poster { get; set; }

    public int Duration { get; set; }

    public DateTime? ReleaseDate { get; set; }

    public string? Director { get; set; }

    public string? Actor { get; set; }

    public string? Description { get; set; }

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual ICollection<MovieCategory> MovieCategories { get; set; } = new List<MovieCategory>();

    public virtual ICollection<Showtime> Showtimes { get; set; } = new List<Showtime>();
}
