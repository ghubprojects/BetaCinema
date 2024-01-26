using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Showtimes.Commands
{
    public class GetShowtimesByWeekDayQuery : IRequest<List<Showtime>>
    {
        public string MovieId { get; set; } = null!;

        public string CinemaId { get; set; } = null!;

        public DateTime ShowDate { get; set; }
    }

    public class GetShowtimesByWeekDayQueryHandler : IRequestHandler<GetShowtimesByWeekDayQuery, List<Showtime>>
    {
        private readonly IAppDbContext _context;

        public GetShowtimesByWeekDayQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<List<Showtime>> Handle(GetShowtimesByWeekDayQuery request, CancellationToken cancellationToken)
        {
            return _context.Showtimes
                .Where(s => s.CinemaId == request.CinemaId && s.MovieId == request.MovieId && s.StartTime.HasValue && s.StartTime.Value.Date == request.ShowDate.Date)
                .Include(s => s.Movie)
                .Include(s => s.Cinema)
                .OrderBy(s => s.StartTime.Value)
                .ToList();
        }
    }
}
