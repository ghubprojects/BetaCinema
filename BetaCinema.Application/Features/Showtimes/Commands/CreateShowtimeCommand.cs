using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;

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
            // Validate
            var validateResult = await ValidateAsync(request.Data);

            if (validateResult.Any())
            {
                return new ServiceResult(false, validateResult.First());
            }
            else
            {
                // Determine the day of the week for the StartTime
                var dayOfWeek = request.Data.StartTime.Value.DayOfWeek;

                // Set ticketPrice based on the day of the week
                var ticketPrice = (dayOfWeek >= DayOfWeek.Monday && dayOfWeek <= DayOfWeek.Friday) ? 40000 : 60000;

                request.Data.TicketPrice = ticketPrice;
                request.Data.Id = Guid.NewGuid().ToString();
                request.Data.DeleteFlag = false;
                request.Data.CreatedDate = DateTime.Now;
                request.Data.ModifiedDate = DateTime.Now;

                _context.Showtimes.Add(request.Data);
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
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
