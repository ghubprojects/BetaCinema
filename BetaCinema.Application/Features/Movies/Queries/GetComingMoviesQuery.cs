using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

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
                .Include(m => m.MovieCategories)
                    .ThenInclude(mc => mc.Category)
                .Where(m => !m.DeleteFlag && m.ReleaseDate > DateTime.Today)
                .OrderBy(movie => movie.ReleaseDate)
                .ToList();
        }
    }
}
