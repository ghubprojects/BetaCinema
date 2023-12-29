using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class DeleteMovieCommand : IRequest
    {
        public string Id { get; set; } = null!;
    }

    public class DeleteMovieCommandHandler : IRequestHandler<DeleteMovieCommand>
    {
        private readonly IUnitOfWork _unitOfWork;

        public DeleteMovieCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task Handle(DeleteMovieCommand request, CancellationToken cancellationToken)
        {
            var movie = await _unitOfWork.Repository<Movie>().GetByIdAsync(request.Id);
            if (movie != null)
            {
                await _unitOfWork.Repository<Movie>().DeleteAsync(movie);
            }
        }
    }
}
