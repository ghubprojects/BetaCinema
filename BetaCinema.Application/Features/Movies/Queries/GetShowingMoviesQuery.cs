using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class GetShowingMoviesQuery : IRequest<List<Movie>> { }

    public class GetShowingMoviesQueryHandler : IRequestHandler<GetShowingMoviesQuery, List<Movie>>
    {
        private readonly IAppDbContext _context;

        public GetShowingMoviesQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<List<Movie>> Handle(GetShowingMoviesQuery request, CancellationToken cancellationToken)
        {
            return _context.Movies
                .Include(m => m.MovieCategories)
                    .ThenInclude(mc => mc.Category)
                .Where(m => !m.DeleteFlag && m.ReleaseDate <= DateTime.Today)
                .OrderByDescending(movie => movie.ReleaseDate)
                .ToList();
        }
    }
}
