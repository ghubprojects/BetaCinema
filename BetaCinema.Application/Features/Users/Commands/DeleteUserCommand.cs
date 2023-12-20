using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Users.Commands
{
    public class DeleteUserCommand : IRequest
    {
        public string Id { get; set; } = null!;
    }

    public class DeleteUserCommandHandler : IRequestHandler<DeleteUserCommand>
    {
        private readonly IUnitOfWork _unitOfWork;

        public DeleteUserCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task Handle(DeleteUserCommand request, CancellationToken cancellationToken)
        {
            var product = await _unitOfWork.Repository<User>().GetByIdAsync(request.Id);
            if (product != null)
            {
                await _unitOfWork.Repository<User>().DeleteAsync(product);
            }
        }
    }
}
