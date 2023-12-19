using BetaCinema.Domain.Contracts;

namespace BetaCinema.Domain.Models;

public partial class Showtime : IEntity
{
    public Guid Id { get; set; }

    public Guid MovieId { get; set; }

    public Guid CinemaId { get; set; }

    public DateTime StartTime { get; set; }

    public int Price { get; set; }

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual Cinema Cinema { get; set; } = null!;

    public virtual Movie Movie { get; set; } = null!;

    public virtual ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();

    public bool GetDeleteFlag() => DeleteFlag;

    public Guid GetId() => Id;

    public void SetDeleteFlag(bool deleteFlag) => DeleteFlag = deleteFlag;

    public void SetId(Guid id) => Id = id;
}
