using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class GetMoviesByWeekDayQuery : IRequest<List<Movie>>
    {
        public string CinemaId { get; set; } = null!;

        public DateTime ShowDate { get; set; }
    }

    public class GetMoviesByWeekDayQueryHandler : IRequestHandler<GetMoviesByWeekDayQuery, List<Movie>>
    {
        private readonly IAppDbContext _context;

        public GetMoviesByWeekDayQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<List<Movie>> Handle(GetMoviesByWeekDayQuery request, CancellationToken cancellationToken)
        {
            return _context.Movies
                .Where(m => !m.DeleteFlag && m.ReleaseDate <= DateTime.Today)
                .Where(m => m.Showtimes.Any(s =>
                    s.CinemaId == request.CinemaId &&
                    s.StartTime.HasValue &&
                    s.StartTime.Value.Date == request.ShowDate.Date))
                .OrderByDescending(m => m.ReleaseDate)
                .ThenBy(m => m.MovieName)
                .ToList();
        }
    }
}
