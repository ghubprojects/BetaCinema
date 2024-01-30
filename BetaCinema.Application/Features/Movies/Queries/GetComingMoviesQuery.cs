using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class GetComingMoviesQuery : IRequest<ServiceResult> { }

    public class GetComingMoviesQueryHandler : IRequestHandler<GetComingMoviesQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetComingMoviesQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetComingMoviesQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var data = await _context.Movies
                    .Include(m => m.MovieCategories)
                        .ThenInclude(mc => mc.Category)
                    .Where(m => !m.DeleteFlag && m.ReleaseDate > DateTime.Today)
                    .OrderBy(movie => movie.ReleaseDate)
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
