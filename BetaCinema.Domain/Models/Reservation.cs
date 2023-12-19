using BetaCinema.Domain.Contracts;

namespace BetaCinema.Domain.Models;

public partial class Reservation : IEntity
{
    public Guid Id { get; set; }

    public Guid ShowtimeId { get; set; }

    public Guid UserId { get; set; }

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();

    public virtual ICollection<ReservationItem> ReservationItems { get; set; } = new List<ReservationItem>();

    public virtual Showtime Showtime { get; set; } = null!;

    public virtual User User { get; set; } = null!;

    public bool GetDeleteFlag() => DeleteFlag;

    public Guid GetId() => Id;

    public void SetDeleteFlag(bool deleteFlag) => DeleteFlag = deleteFlag;

    public void SetId(Guid id) => Id = id;
}
