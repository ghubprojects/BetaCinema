using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class GetSeatByIdQuery : IRequest<Seat>
    {
        public string Id { get; set; } = null!;
    }

    public class GetSeatByIdQueryHandler : IRequestHandler<GetSeatByIdQuery, Seat>
    {
        private readonly IUnitOfWork _unitOfWork;

        public GetSeatByIdQueryHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<Seat> Handle(GetSeatByIdQuery request, CancellationToken cancellationToken)
        {
            return await _unitOfWork.Repository<Seat>().GetByIdAsync(request.Id);
        }
    }
}
