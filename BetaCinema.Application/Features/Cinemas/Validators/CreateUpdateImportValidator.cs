using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;

namespace BetaCinema.Application.Features.Cinemas.Validators
{
    public static class CreateUpdateImportValidator
    {
        public static List<string> Validate(Cinema cinema)
        {
            var errors = new List<string>();

            // Validate CinemaName
            if (string.IsNullOrWhiteSpace(cinema.CinemaName))
            {
                errors.Add(string.Format(MessageResouces.Required, "Cinema Name"));
            }

            // Validate CinemaLocation
            if (string.IsNullOrWhiteSpace(cinema.CinemaLocation))
            {
                errors.Add(string.Format(MessageResouces.Required, "Cinema Location"));
            }

            return errors;
        }
    }
}
