using BetaCinema.Domain.Contracts;

namespace BetaCinema.Domain.Models;

public partial class ReservationItem : IEntity
{
    public Guid Id { get; set; }

    public Guid ReservationId { get; set; }

    public Guid SeatId { get; set; }

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual Reservation Reservation { get; set; } = null!;

    public virtual Seat Seat { get; set; } = null!;

    public bool GetDeleteFlag() => DeleteFlag;

    public Guid GetId() => Id;

    public void SetDeleteFlag(bool deleteFlag) => DeleteFlag = deleteFlag;

    public void SetId(Guid id) => Id = id;
}
