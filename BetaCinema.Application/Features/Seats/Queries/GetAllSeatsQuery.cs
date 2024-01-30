using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class GetAllSeatsQuery : IRequest<ServiceResult> { }

    public class GetAllSeatsQueryHandler : IRequestHandler<GetAllSeatsQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetAllSeatsQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetAllSeatsQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var data = await _context.Seats
                    .Where(s => !s.DeleteFlag)
                    .OrderBy(s => s.RowNum)
                    .ThenBy(s => s.SeatNum)
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
