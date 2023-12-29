using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class UpdateMovieCommand : IRequest
    {
        public Movie Data { get; set; }
    }

    public class UpdateMovieCommandHandler : IRequestHandler<UpdateMovieCommand>
    {
        private readonly IUnitOfWork _unitOfWork;

        public UpdateMovieCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task Handle(UpdateMovieCommand request, CancellationToken cancellationToken)
        {
            await _unitOfWork.Repository<Movie>().UpdateAsync(request.Data);
        }
    }
}
