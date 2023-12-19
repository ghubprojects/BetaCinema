using BetaCinema.Domain.Contracts;

namespace BetaCinema.Domain.Models;

public partial class Category : IEntity
{
    public Guid Id { get; set; }

    public string Name { get; set; } = null!;

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual ICollection<MovieCategory> MovieCategories { get; set; } = new List<MovieCategory>();

    public bool GetDeleteFlag() => DeleteFlag;

    public Guid GetId() => Id;

    public void SetDeleteFlag(bool deleteFlag) => DeleteFlag = deleteFlag;

    public void SetId(Guid id) => Id = id;
}
