using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class GetMovieByIdQuery : IRequest<Movie>
    {
        public string Id { get; set; } = null!;
    }

    public class GetMovieByIdQueryHandler : IRequestHandler<GetMovieByIdQuery, Movie>
    {
        private readonly IUnitOfWork _unitOfWork;

        public GetMovieByIdQueryHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<Movie> Handle(GetMovieByIdQuery request, CancellationToken cancellationToken)
        {
            return await _unitOfWork.Repository<Movie>().GetByIdAsync(request.Id);
        }
    }
}
