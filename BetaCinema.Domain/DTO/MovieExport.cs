namespace BetaCinema.Domain.DTO
{
    public class MovieExport
    {
        public string MovieName { get; set; } = null!;

        public string? Poster { get; set; }

        public string Duration { get; set; }

        public string ReleaseDate { get; set; }

        public string? Director { get; set; }

        public string? Actor { get; set; }

        public string? Description { get; set; }

        public string DeleteFlag { get; set; }
    }
}
