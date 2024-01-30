namespace BetaCinema.Domain.DTOs
{
    public class ReservationExport
    {
        public string UserName { get; set; }

        public string Email { get; set; }

        public string MovieName { get; set; }

        public string CinemaName { get; set; }

        public string StartTime { get; set; }

        public string Seats { get; set; }

        public string DeleteFlag { get; set; }
    }
}
