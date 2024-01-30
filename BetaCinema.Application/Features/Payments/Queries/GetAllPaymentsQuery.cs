using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Payments.Commands
{
    public class GetAllPaymentsQuery : IRequest<ServiceResult> { }

    public class GetAllPaymentsQueryHandler : IRequestHandler<GetAllPaymentsQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetAllPaymentsQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetAllPaymentsQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var data = await _context.Payments
                    .Where(p => !p.DeleteFlag)
                    .Include(p => p.Reservation)
                        .ThenInclude(r => r.User)
                    .OrderByDescending(p => p.CreatedDate)
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
