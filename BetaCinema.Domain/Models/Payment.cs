using BetaCinema.Domain.Contracts;

namespace BetaCinema.Domain.Models;

public partial class Payment : IEntity
{
    public Guid Id { get; set; }

    public Guid ReservationId { get; set; }

    public int TotalPrice { get; set; }

    public string PaymentMethod { get; set; } = null!;

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual Reservation Reservation { get; set; } = null!;

    public bool GetDeleteFlag() => DeleteFlag;

    public Guid GetId() => Id;

    public void SetDeleteFlag(bool deleteFlag) => DeleteFlag = deleteFlag;

    public void SetId(Guid id) => Id = id;
}
