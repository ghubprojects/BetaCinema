using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Cinemas.Commands
{
    public class GetCinemaByIdQuery : IRequest<Cinema>
    {
        public string Id { get; set; } = null!;
    }

    public class GetCinemaByIdQueryHandler : IRequestHandler<GetCinemaByIdQuery, Cinema>
    {
        private readonly IUnitOfWork _unitOfWork;

        public GetCinemaByIdQueryHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<Cinema> Handle(GetCinemaByIdQuery request, CancellationToken cancellationToken)
        {
            return await _unitOfWork.Repository<Cinema>().GetByIdAsync(request.Id);
        }
    }
}
