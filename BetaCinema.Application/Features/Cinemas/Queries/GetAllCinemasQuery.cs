using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Cinemas.Commands
{
    public class GetAllCinemasQuery : IRequest<ServiceResult> { }

    public class GetAllCinemasQueryHandler : IRequestHandler<GetAllCinemasQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetAllCinemasQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetAllCinemasQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var data = await _context.Cinemas
                    .Where(c => !c.DeleteFlag)
                    .OrderBy(c => c.CinemaName)
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
