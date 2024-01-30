using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class DeleteMultipleMoviesCommand : IRequest<ServiceResult>
    {
        public List<Movie> RemovedList { get; set; }
    }

    public class DeleteMultipleMoviesCommandHandler : IRequestHandler<DeleteMultipleMoviesCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public DeleteMultipleMoviesCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(DeleteMultipleMoviesCommand request, CancellationToken cancellationToken)
        {
            try
            {
                // Validate exist or not
                foreach (var item in request.RemovedList)
                {
                    var movie = await _context.Movies
                    .Where(c => !c.DeleteFlag)
                    .AsNoTracking()
                    .FirstOrDefaultAsync(c => c.Id == item.Id, cancellationToken);

                    // If errors, return false
                    if (movie == null)
                        return new ServiceResult(false, string.Format(MessageResouces.NotExisted, MovieResources.Movie));
                }

                // Set DeleteFlag to true
                foreach (var item in request.RemovedList)
                {
                    item.DeleteFlag = true;
                    _context.Entry(item).State = EntityState.Modified;
                }

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
