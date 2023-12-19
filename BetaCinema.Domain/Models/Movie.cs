using BetaCinema.Domain.Contracts;

namespace BetaCinema.Domain.Models;

public partial class Movie : IEntity
{
    public Guid Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Poster { get; set; }

    public int Duration { get; set; }

    public DateOnly ReleaseDate { get; set; }

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

    public bool GetDeleteFlag() => DeleteFlag;

    public Guid GetId() => Id;

    public void SetDeleteFlag(bool deleteFlag) => DeleteFlag = deleteFlag;

    public void SetId(Guid id) => Id = id;
}
