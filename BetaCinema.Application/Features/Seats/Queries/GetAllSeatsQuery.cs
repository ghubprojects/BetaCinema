using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class GetAllSeatsQuery : IRequest<List<Seat>> { }

    public class GetAllSeatsQueryHandler : IRequestHandler<GetAllSeatsQuery, List<Seat>>
    {
        private readonly IUnitOfWork _unitOfWork;

        public GetAllSeatsQueryHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<List<Seat>> Handle(GetAllSeatsQuery request, CancellationToken cancellationToken)
        {
            return await _unitOfWork.Repository<Seat>().GetAllAsync();
        }
    }
}
