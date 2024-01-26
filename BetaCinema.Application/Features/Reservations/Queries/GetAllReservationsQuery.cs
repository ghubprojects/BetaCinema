using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Reservations.Queries
{
    public class GetAllReservationsQuery : IRequest<List<Reservation>> { }

    public class GetAllReservationsQueryHandler : IRequestHandler<GetAllReservationsQuery, List<Reservation>>
    {
        private readonly IAppDbContext _context;

        public GetAllReservationsQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<List<Reservation>> Handle(GetAllReservationsQuery request, CancellationToken cancellationToken)
        {
            var reservations = await _context.Reservations
                .Include(r => r.Showtime)
                    .ThenInclude(s => s.Movie)
                .Include(r => r.Showtime)
                    .ThenInclude(s => s.Cinema)
                .Include(r => r.ReservationItems)
                    .ThenInclude(ri => ri.Seat)
                .Include(r => r.User)
                .Where(r => !r.DeleteFlag)
                .OrderBy(r => r.CreatedDate)
                .AsNoTracking()
                .ToListAsync(cancellationToken);

            return reservations;
        }
    }
}
