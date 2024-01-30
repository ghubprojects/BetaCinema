using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Cinemas.Commands
{
    public class GetCinemaByIdQuery : IRequest<ServiceResult>
    {
        public string Id { get; set; } = null!;
    }

    public class GetCinemaByIdQueryHandler : IRequestHandler<GetCinemaByIdQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetCinemaByIdQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetCinemaByIdQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var item = await _context.Cinemas
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(c => c.Id == request.Id, cancellationToken);

                if (item == null)
                    return new ServiceResult(false, string.Format(MessageResouces.NotExisted, CinemaResources.CinemaName));

                return new ServiceResult(true, "", item);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }
    }
}
