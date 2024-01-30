using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Reservations.Queries
{
    public class GetAllReservationsQuery : IRequest<ServiceResult> { }

    public class GetAllReservationsQueryHandler : IRequestHandler<GetAllReservationsQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetAllReservationsQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetAllReservationsQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var data = await _context.Reservations
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

                return new ServiceResult(true, "", data);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }
    }
}
