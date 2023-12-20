namespace BetaCinema.Domain.Models;

public partial class Seat
{
    public string Id { get; set; } = null!;

    public string RowNum { get; set; } = null!;

    public int SeatNum { get; set; }

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual ICollection<ReservationItem> ReservationItems { get; set; } = new List<ReservationItem>();
}
