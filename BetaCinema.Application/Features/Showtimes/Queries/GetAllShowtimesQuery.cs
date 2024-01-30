using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Showtimes.Commands
{
    public class GetAllShowtimesQuery : IRequest<ServiceResult> { }

    public class GetAllShowtimesQueryHandler : IRequestHandler<GetAllShowtimesQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetAllShowtimesQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetAllShowtimesQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var data = await _context.Showtimes
                    .OrderByDescending(s => s.ModifiedDate)
                    .Include(s => s.Movie)
                    .Include(s => s.Cinema)
                    .Where(s => !s.DeleteFlag && !s.Movie.DeleteFlag)
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

