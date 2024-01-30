using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class GetShowingMoviesQuery : IRequest<ServiceResult> { }

    public class GetShowingMoviesQueryHandler : IRequestHandler<GetShowingMoviesQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetShowingMoviesQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetShowingMoviesQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var data = await _context.Movies
                    .Include(m => m.MovieCategories)
                        .ThenInclude(mc => mc.Category)
                    .Where(m => !m.DeleteFlag && m.ReleaseDate <= DateTime.Today)
                    .OrderByDescending(movie => movie.ReleaseDate)
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
