using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class GetSoldSeatsByShowtimeId : IRequest<ServiceResult>
    {
        public string ShowtimeId { get; set; } = null!;
    }

    public class GetSoldSeatsByShowtimeIdHandler : IRequestHandler<GetSoldSeatsByShowtimeId, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetSoldSeatsByShowtimeIdHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetSoldSeatsByShowtimeId request, CancellationToken cancellationToken)
        {
            try
            {
                // Check if showtime existed
                var searchResult = await _context.Showtimes
                    .Include(s => s.Movie)
                    .Include(s => s.Cinema)
                    .FirstOrDefaultAsync(s => s.Id == request.ShowtimeId, cancellationToken);

                if (searchResult == null)
                    return new ServiceResult(false, string.Format(MessageResouces.NotExisted, ShowtimeResources.Showtime));

                var data = await _context.ReservationItems
                    .Include(ri => ri.Seat)
                    .Include(ri => ri.Reservation)
                        .ThenInclude(r => r.Showtime)
                    .Where(ri => !ri.DeleteFlag && ri.Reservation.ShowtimeId == request.ShowtimeId)
                    .Select(ri => ri.Seat)
                    .AsNoTracking()
                    .ToListAsync(cancellationToken);

                return new ServiceResult(true, "", data);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }
    }
}
