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
            var movie = await _context.Movies.FindAsync(request.Id);
            if (movie != null)
            {
                movie.DeleteFlag = true;
                _context.Entry(movie).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            else
            {
                return new ServiceResult(false, string.Format(MessageResouces.NotExisted), "Phim");
            }
        }
    }
}
