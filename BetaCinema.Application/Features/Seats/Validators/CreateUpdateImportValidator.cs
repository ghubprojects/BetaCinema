using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;

namespace BetaCinema.Application.Features.Seats.Validators
{
    public static class CreateUpdateImportValidator
    {
        public static List<string> Validate(Seat seat)
        {
            var errors = new List<string>();

            // Validate RowNum
            if (string.IsNullOrWhiteSpace(seat.RowNum))
            {
                errors.Add(string.Format(MessageResouces.Required, "Row Num"));
            }

            // Validate SeatNum
            if (seat.SeatNum <= 0)
            {
                errors.Add(string.Format(MessageResouces.GreaterThan0, "Seat Num"));
            }

            return errors;
        }
    }
}
