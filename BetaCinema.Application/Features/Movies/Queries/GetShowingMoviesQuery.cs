using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;

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
                .Where(m => !m.DeleteFlag && m.ReleaseDate <= DateTime.Today)
                .OrderByDescending(movie => movie.ReleaseDate)
                .ToList();
        }
    }
}
