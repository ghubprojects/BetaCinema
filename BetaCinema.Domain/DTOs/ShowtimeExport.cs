namespace BetaCinema.Domain.DTOs
{
    public class ShowtimeExport
    {
        public string MovieName { get; set; } = null!;

        public string CinemaName { get; set; } = null!;

        public string StartTime { get; set; } = null!;

        public string TicketPrice { get; set; } = null!;

        public string DeleteFlag { get; set; }
    }
}
