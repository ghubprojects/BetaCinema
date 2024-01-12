using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;

namespace BetaCinema.Application.Features.Movies.Validators
{
    public static class CreateUpdateImportValidator
    {
        public static List<string> Validate(Movie movie)
        {
            var errors = new List<string>();

            // Validate MovieName
            if (string.IsNullOrWhiteSpace(movie.MovieName))
            {
                errors.Add(string.Format(MessageResouces.Required, "Movie Name"));
            }

            // Validate Duration
            if (movie.Duration <= 0)
            {
                errors.Add(string.Format(MessageResouces.GreaterThan0, "Duration"));
            }

            // Validate ReleaseDate (if provided)
            if (movie.ReleaseDate.HasValue && movie.ReleaseDate.Value < DateTime.Now)
            {
                errors.Add(string.Format(MessageResouces.GreaterThanNow, "Release Date"));
            }

            return errors;
        }
    }
}
