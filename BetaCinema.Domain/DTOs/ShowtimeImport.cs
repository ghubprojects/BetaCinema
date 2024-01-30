namespace BetaCinema.Domain.DTOs
{
    public class ShowtimeImport
    {
        public string MovieName { get; set; } = null!;

        public string CinemaName { get; set; } = null!;

        public DateTime? StartTime { get; set; }

        public int TicketPrice { get; set; }
    }
}
