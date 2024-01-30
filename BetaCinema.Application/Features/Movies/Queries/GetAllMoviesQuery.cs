using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class GetAllMoviesQuery : IRequest<ServiceResult> { }

    public class GetAllMoviesQueryHandler : IRequestHandler<GetAllMoviesQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetAllMoviesQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetAllMoviesQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var data = await _context.Movies
                    .Include(m => m.MovieCategories)
                        .ThenInclude(mc => mc.Category)
                    .Where(m => !m.DeleteFlag)
                    .OrderByDescending(m => m.ModifiedDate)
                    .ThenByDescending(m => m.ReleaseDate)
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
