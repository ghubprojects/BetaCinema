using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class GetMovieByIdQuery : IRequest<Movie>
    {
        public string Id { get; set; } = null!;
    }

    public class GetMovieByIdQueryHandler : IRequestHandler<GetMovieByIdQuery, Movie>
    {
        private readonly IAppDbContext _context;

        public GetMovieByIdQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<Movie> Handle(GetMovieByIdQuery request, CancellationToken cancellationToken)
        {
            var movie = await _context.Movies
                .Include(m => m.MovieCategories)
                    .ThenInclude(mc => mc.Category)
                .FirstOrDefaultAsync(m => m.Id == request.Id, cancellationToken);

            return movie;
        }
    }
}
