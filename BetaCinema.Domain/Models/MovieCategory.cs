using BetaCinema.Domain.Contracts;

namespace BetaCinema.Domain.Models;

public partial class MovieCategory : IEntity
{
    public Guid Id { get; set; }

    public Guid MovieId { get; set; }

    public Guid CategoryId { get; set; }

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual Category Category { get; set; } = null!;

    public virtual Movie Movie { get; set; } = null!;

    public bool GetDeleteFlag() => DeleteFlag;

    public Guid GetId() => Id;

    public void SetDeleteFlag(bool deleteFlag) => DeleteFlag = deleteFlag;

    public void SetId(Guid id) => Id = id;
}
