using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class GetAllMoviesQuery : IRequest<List<Movie>> { }

    public class GetAllMoviesQueryHandler : IRequestHandler<GetAllMoviesQuery, List<Movie>>
    {
        private readonly IUnitOfWork _unitOfWork;

        public GetAllMoviesQueryHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<List<Movie>> Handle(GetAllMoviesQuery request, CancellationToken cancellationToken)
        {
            return await _unitOfWork.Repository<Movie>().GetAllAsync();
        }
    }
}
