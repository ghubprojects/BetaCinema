namespace BetaCinema.Domain.DTOs
{
    public class MovieImport
    {
        public string MovieName { get; set; } = null!;

        public List<string> Categories { get; set; }

        public int Duration { get; set; }

        public DateTime? ReleaseDate { get; set; }

        public string? Director { get; set; }

        public string? Actor { get; set; }

        public string? Description { get; set; }
    }
}
