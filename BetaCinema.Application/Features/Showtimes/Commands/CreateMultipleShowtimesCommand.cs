using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;

namespace BetaCinema.Application.Features.Showtimes.Commands
{
    public class CreateMultipleShowtimesCommand : IRequest<ServiceResult>
    {
        public List<Showtime> ListData { get; set; }
    }

    public class CreateMultipleShowtimesCommandHandler : IRequestHandler<CreateMultipleShowtimesCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public CreateMultipleShowtimesCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Handle command
        /// </summary>
        /// <param name="request"></param>
        /// <param name="cancellationToken"></param>
        /// <returns></returns>
        public async Task<ServiceResult> Handle(CreateMultipleShowtimesCommand request, CancellationToken cancellationToken)
        {
            // Validate
            foreach (var showtime in request.ListData)
            {
                var validateResult = await ValidateAsync(showtime);

                if (validateResult.Any())
                {
                    return new ServiceResult(false, validateResult.First());
                }
            }

            foreach (var movie in request.ListData)
            {
                // Determine the day of the week for the StartTime
                var dayOfWeek = movie.StartTime.Value.DayOfWeek;

                // Set ticketPrice based on the day of the week
                var ticketPrice = (dayOfWeek >= DayOfWeek.Monday && dayOfWeek <= DayOfWeek.Friday) ? 40000 : 60000;

                movie.TicketPrice = ticketPrice;
                movie.Id = Guid.NewGuid().ToString();
                movie.DeleteFlag = false;
                movie.CreatedDate = DateTime.Now;
                movie.ModifiedDate = DateTime.Now;
            }

            _context.Showtimes.AddRange(request.ListData);
            await _context.SaveChangesAsync(cancellationToken);
            return new ServiceResult(true);
        }

        /// <summary>
        /// Validate
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
                var searchResult = await _context.Cinemas.FindAsync(showtime.CinemaId);

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
