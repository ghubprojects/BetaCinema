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
            // Validate
            var validateResult = await ValidateAsync(request.Data);

            if (validateResult.Any())
            {
                return new ServiceResult(false, validateResult.First());
            }
            else
            {
                request.Data.ModifiedDate = DateTime.Now;
                _context.Entry(request.Data).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
        }

        /// <summary>
        /// Validate Showtime
        /// </summary>
        /// <param name="showtime"></param>
        /// <returns></returns>
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
                var searchResult = await _context.Movies.FindAsync(showtime.MovieId);

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
                var searchResult = await _context.Showtimes.FindAsync(showtime.CinemaId);

                if (searchResult == null)
                {
                    errors.Add(string.Format(MessageResouces.NotExisted, CinemaResources.CinemaName));
                }
            }

            // Check duplicated showtime by movieId and cinemaId
            if (!string.IsNullOrWhiteSpace(showtime.MovieId) && !string.IsNullOrWhiteSpace(showtime.CinemaId))
            {
                bool showtimeExists = _context.Showtimes
                    .Any(s => s.MovieId == showtime.MovieId && s.CinemaId == showtime.CinemaId && s.StartTime == showtime.StartTime);

                if (showtimeExists)
                {
                    errors.Add(string.Format(MessageResouces.Duplicated, ShowtimeResources.StartTime));
                }
            }

            return errors;
        }
    }
}
