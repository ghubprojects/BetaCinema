using BetaCinema.Domain.Contracts;

namespace BetaCinema.Domain.Models;

public partial class Cinema : IEntity
{
    public Guid Id { get; set; }

    public string Name { get; set; } = null!;

    public string Location { get; set; } = null!;

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual ICollection<Showtime> Showtimes { get; set; } = new List<Showtime>();

    public bool GetDeleteFlag() => DeleteFlag;

    public Guid GetId() => Id;

    public void SetDeleteFlag(bool deleteFlag) => DeleteFlag = deleteFlag;

    public void SetId(Guid id) => Id = id;
}
