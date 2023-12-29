using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class CreateMovieCommand : IRequest<ServiceResult>
    {
        public Movie Data { get; set; }
    }

    public class CreateMovieCommandHandler : IRequestHandler<CreateMovieCommand, ServiceResult>
    {
        private readonly IUnitOfWork _unitOfWork;

        public CreateMovieCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<ServiceResult> Handle(CreateMovieCommand request, CancellationToken cancellationToken)
        {
            request.Data.Id = Guid.NewGuid().ToString();
            await _unitOfWork.Repository<Movie>().AddAsync(request.Data);
            return new ServiceResult(true);
        }
    }
}
