using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Showtimes.Commands
{
    public class CreateShowtimeCommand : IRequest<ServiceResult>
    {
        public Showtime Data { get; set; }
    }

    public class CreateShowtimeCommandHandler : IRequestHandler<CreateShowtimeCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public CreateShowtimeCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(CreateShowtimeCommand request, CancellationToken cancellationToken)
        {
            try
            {
                // Validate
                var validateResult = await ValidateAsync(request.Data);

                // If errors, return false
                if (validateResult.Any())
                    return new ServiceResult(false, validateResult.First());

                // Add item
                request.Data.Id = Guid.NewGuid().ToString();
                request.Data.DeleteFlag = false;
                request.Data.CreatedDate = DateTime.Now;
                request.Data.ModifiedDate = DateTime.Now;

                _context.Showtimes.Add(request.Data);
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }

        private async Task<List<string>> ValidateAsync(Showtime showtime)
        {
            var errors = new List<string>();

            // Validate MovieId
            if (string.IsNullOrWhiteSpace(showtime.MovieId))
            {
                errors.Add(string.Format(MessageResouces.Required, MovieResources.MovieName));
            }
            else
            {
                var searchResult = await _context.Movies
                    .Where(m => !m.DeleteFlag)
                    .FirstOrDefaultAsync(m => m.Id == showtime.MovieId);

                if (searchResult == null)
                {
                    errors.Add(string.Format(MessageResouces.NotExisted, MovieResources.MovieName));
                }
                else if (showtime.StartTime.Value.Date < searchResult.ReleaseDate.Value.Date)
                {
                    errors.Add(string.Format(MessageResouces.NotGreaterThan, ShowtimeResources.ShowDate, MovieResources.ReleaseDate));
                }
            }

            // Validate CinemaId
            if (string.IsNullOrWhiteSpace(showtime.CinemaId))
            {
                errors.Add(string.Format(MessageResouces.Required, CinemaResources.CinemaName));
            }
            else
            {
                var searchResult = await _context.Cinemas
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(c => c.Id == showtime.CinemaId);

                if (searchResult == null)
                {
                    errors.Add(string.Format(MessageResouces.NotExisted, CinemaResources.CinemaName));
                }
            }

            // Check duplicated showtime by movieId and cinemaId
            if (!string.IsNullOrWhiteSpace(showtime.MovieId) && !string.IsNullOrWhiteSpace(showtime.CinemaId))
            {
                var showtimeExists = _context.Showtimes
                    .Any(s => s.MovieId == showtime.MovieId && s.CinemaId == showtime.CinemaId && s.StartTime == showtime.StartTime);

                if (showtimeExists)
                {
                    errors.Add(string.Format(MessageResouces.Duplicated, ShowtimeResources.StartTime));
                }
            }

            // Validate StartTime
            if (!showtime.StartTime.HasValue)
            {
                errors.Add(string.Format(MessageResouces.Required, ShowtimeResources.StartTime));
            }
            else if (showtime.StartTime.Value < DateTime.Now)
            {
                errors.Add(string.Format(MessageResouces.GreaterThanNow, ShowtimeResources.StartTime));
            }

            // Validate TicketPrice
            if (showtime.TicketPrice <= 0)
            {
                errors.Add(string.Format(MessageResouces.GreaterThan0, ShowtimeResources.TicketPrice));
            }

            return errors;
        }
    }
}
