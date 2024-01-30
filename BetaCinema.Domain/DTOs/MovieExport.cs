namespace BetaCinema.Domain.DTOs
{
    public class MovieExport
    {
        public string MovieName { get; set; } = null!;

        public string Categories { get; set; }

        public string Duration { get; set; }

        public string ReleaseDate { get; set; }

        public string? Director { get; set; }

        public string? Actor { get; set; }

        public string? Description { get; set; }

        public string DeleteFlag { get; set; }
    }
}
