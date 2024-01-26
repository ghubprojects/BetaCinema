using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class GetAllMoviesQuery : IRequest<List<Movie>> { }

    public class GetAllMoviesQueryHandler : IRequestHandler<GetAllMoviesQuery, List<Movie>>
    {
        private readonly IAppDbContext _context;

        public GetAllMoviesQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<List<Movie>> Handle(GetAllMoviesQuery request, CancellationToken cancellationToken)
        {
            return _context.Movies
                .Include(m => m.MovieCategories)
                    .ThenInclude(mc => mc.Category)
                .Where(m => !m.DeleteFlag)
                .OrderByDescending(m => m.ModifiedDate)
                .ThenByDescending(m => m.ReleaseDate)
                .ToList();
        }
    }
}
