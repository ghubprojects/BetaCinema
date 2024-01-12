using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Cinemas.Commands
{
    public class DeleteCinemaCommand : IRequest
    {
        public string Id { get; set; } = null!;
    }

    public class DeleteCinemaCommandHandler : IRequestHandler<DeleteCinemaCommand>
    {
        private readonly IUnitOfWork _unitOfWork;

        public DeleteCinemaCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task Handle(DeleteCinemaCommand request, CancellationToken cancellationToken)
        {
            var cinema = await _unitOfWork.Repository<Cinema>().GetByIdAsync(request.Id);
            if (cinema != null)
            {
                await _unitOfWork.Repository<Cinema>().DeleteAsync(cinema);
            }
        }
    }
}
