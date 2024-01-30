using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Showtimes.Commands
{
    public class GetShowtimesByWeekDayQuery : IRequest<ServiceResult>
    {
        public string MovieId { get; set; } = null!;

        public string CinemaId { get; set; } = null!;

        public DateTime ShowDate { get; set; }
    }

    public class GetShowtimesByWeekDayQueryHandler : IRequestHandler<GetShowtimesByWeekDayQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetShowtimesByWeekDayQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetShowtimesByWeekDayQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var item = await _context.Showtimes
                    .Where(s => s.CinemaId == request.CinemaId && s.MovieId == request.MovieId && s.StartTime.HasValue && s.StartTime.Value.Date == request.ShowDate.Date && s.StartTime.Value > DateTime.Now)
                    .Include(s => s.Movie)
                    .Include(s => s.Cinema)
                    .Include(s => s.Reservations)
                        .ThenInclude(r => r.ReservationItems)
                            .ThenInclude(ri => ri.Seat)
                    .OrderBy(s => s.StartTime.Value)
                    .AsNoTracking()
                    .ToListAsync(cancellationToken);

                if (item == null)
                    return new ServiceResult(false, string.Format(MessageResouces.NotExisted, ShowtimeResources.Showtime));

                return new ServiceResult(true, "", item);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }
    }
}
