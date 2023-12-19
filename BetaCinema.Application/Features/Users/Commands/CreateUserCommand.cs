using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Users.Commands
{
    public class CreateUserCommand : IRequest
    {
        public User Data { get; set; }

    }

    public class CreateUserCommandHandler : IRequestHandler<CreateUserCommand>
    {
        private readonly IUnitOfWork _unitOfWork;

        public CreateUserCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task Handle(CreateUserCommand request, CancellationToken cancellationToken)
        {
            request.Data.Id = Guid.NewGuid();
            await _unitOfWork.Repository<User>().AddAsync(request.Data);
        }
    }
}
