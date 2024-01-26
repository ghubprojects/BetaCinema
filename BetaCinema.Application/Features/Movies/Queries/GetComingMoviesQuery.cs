using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class GetComingMoviesQuery : IRequest<List<Movie>> { }

    public class GetComingMoviesQueryHandler : IRequestHandler<GetComingMoviesQuery, List<Movie>>
    {
        private readonly IAppDbContext _context;

        public GetComingMoviesQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<List<Movie>> Handle(GetComingMoviesQuery request, CancellationToken cancellationToken)
        {
            return _context.Movies
                .Where(m => !m.DeleteFlag && m.ReleaseDate > DateTime.Today)
                .OrderBy(movie => movie.ReleaseDate)
                .ToList();
        }
    }
}
