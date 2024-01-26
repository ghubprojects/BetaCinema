namespace BetaCinema.Domain.DTO
{
    public class ShowtimeExport
    {
        public string MovieId { get; set; } = null!;

        public string CinemaId { get; set; } = null!;

        public string StartTime { get; set; } = null!;

        public string DeleteFlag { get; set; }
    }
}
