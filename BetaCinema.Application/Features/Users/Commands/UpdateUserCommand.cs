using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Users.Commands
{
    public class UpdateUserCommand : IRequest
    {
        public User Data { get; set; }
    }

    public class UpdateUserCommandHandler : IRequestHandler<UpdateUserCommand>
    {
        private readonly IUnitOfWork _unitOfWork;

        public UpdateUserCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task Handle(UpdateUserCommand request, CancellationToken cancellationToken)
        {
            request.Data.NormalizedEmail = request.Data.Email.ToUpper();
            request.Data.NormalizedUserName = request.Data.UserName.ToUpper();
            await _unitOfWork.Repository<User>().UpdateAsync(request.Data);
        }
    }
}
