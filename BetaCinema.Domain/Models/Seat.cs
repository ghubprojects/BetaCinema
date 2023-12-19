using BetaCinema.Domain.Contracts;

namespace BetaCinema.Domain.Models;

public partial class Seat : IEntity
{
    public Guid Id { get; set; }

    public string RowNum { get; set; } = null!;

    public int SeatNum { get; set; }

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual ICollection<ReservationItem> ReservationItems { get; set; } = new List<ReservationItem>();

    public bool GetDeleteFlag() => DeleteFlag;

    public Guid GetId() => Id;

    public void SetDeleteFlag(bool deleteFlag) => DeleteFlag = deleteFlag;

    public void SetId(Guid id) => Id = id;
}
