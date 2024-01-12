using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class DeleteSeatCommand : IRequest
    {
        public string Id { get; set; } = null!;
    }

    public class DeleteSeatCommandHandler : IRequestHandler<DeleteSeatCommand>
    {
        private readonly IUnitOfWork _unitOfWork;

        public DeleteSeatCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task Handle(DeleteSeatCommand request, CancellationToken cancellationToken)
        {
            var cinema = await _unitOfWork.Repository<Seat>().GetByIdAsync(request.Id);
            if (cinema != null)
            {
                await _unitOfWork.Repository<Seat>().DeleteAsync(cinema);
            }
        }
    }
}
