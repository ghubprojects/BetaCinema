using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class DeleteMovieCommand : IRequest<ServiceResult>
    {
        public string Id { get; set; } = null!;
    }

    public class DeleteMovieCommandHandler : IRequestHandler<DeleteMovieCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public DeleteMovieCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(DeleteMovieCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var movie = await _context.Movies
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(c => c.Id == request.Id, cancellationToken);

                // If errors, return false
                if (movie == null)
                    return new ServiceResult(false, string.Format(MessageResouces.NotExisted, MovieResources.Movie));

                // Delete item
                movie.DeleteFlag = true;
                _context.Entry(movie).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }
    }
}
