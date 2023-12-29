using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class CreateMultipleMoviesCommand : IRequest<ServiceResult>
    {
        public List<Movie> ListData { get; set; }
    }

    public class CreateMultipleMoviesCommandHandler : IRequestHandler<CreateMultipleMoviesCommand, ServiceResult>
    {
        private readonly IUnitOfWork _unitOfWork;

        public CreateMultipleMoviesCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<ServiceResult> Handle(CreateMultipleMoviesCommand request, CancellationToken cancellationToken)
        {
            foreach (var movie in request.ListData)
            {
                movie.Id = Guid.NewGuid().ToString();
            }

            await _unitOfWork.Repository<Movie>().AddMultipleAsync(request.ListData);
            return new ServiceResult(true);
        }
    }
}
