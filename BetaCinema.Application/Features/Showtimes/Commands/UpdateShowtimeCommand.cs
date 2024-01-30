using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Showtimes.Commands
{
    public class UpdateShowtimeCommand : IRequest<ServiceResult>
    {
        public Showtime OldData { get; set; }
        public Showtime Data { get; set; }
    }

    public class UpdateShowtimeCommandHandler : IRequestHandler<UpdateShowtimeCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public UpdateShowtimeCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Handle
        /// </summary>
        /// <param name="request"></param>
        /// <param name="cancellationToken"></param>
        /// <returns></returns>
        public async Task<ServiceResult> Handle(UpdateShowtimeCommand request, CancellationToken cancellationToken)
        {
            try
            {
                // Validate
                var validateResult = await ValidateAsync(request.Data, request.OldData);

                // If errors, return false
                if (validateResult.Any())
                    return new ServiceResult(false, validateResult.First());

                // Update item
                request.Data.ModifiedDate = DateTime.Now;
                _context.Entry(request.Data).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }

        /// <summary>
        /// Validate Showtime
        /// </summary>
        /// <param name="showtime"></param>
        /// <returns></returns>
        private async Task<List<string>> ValidateAsync(Showtime showtime, Showtime old)
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
                if (showtime.MovieId != old.MovieId || showtime.CinemaId != old.CinemaId || (showtime.StartTime.HasValue && showtime.StartTime.Value != old.StartTime.Value))
                {
                    var showtimeExists = _context.Showtimes
                        .Any(s => s.MovieId == showtime.MovieId && s.CinemaId == showtime.CinemaId && s.StartTime == showtime.StartTime);

                    if (showtimeExists)
                    {
                        errors.Add(string.Format(MessageResouces.Duplicated, ShowtimeResources.StartTime));
                    }
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
