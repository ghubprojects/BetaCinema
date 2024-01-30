namespace BetaCinema.Domain.DTOs
{
    public class SeatExport
    {
        public string RowNum { get; set; } = null!;

        public string SeatNum { get; set; } = null!;

        public string DeleteFlag { get; set; }
    }
}
