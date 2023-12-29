using BetaCinema.Domain.Enums;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.AspNetCore.Identity;

namespace BetaCinema.Application.Features.Users.Commands
{
    public class CreateUserCommand : IRequest<ServiceResult>
    {
        public User Data { get; set; }
    }

    public class CreateUserCommandHandler : IRequestHandler<CreateUserCommand, ServiceResult>
    {
        private readonly UserManager<User> _userManager;

        public CreateUserCommandHandler(UserManager<User> userManager)
        {
            _userManager = userManager;
        }

        public async Task<ServiceResult> Handle(CreateUserCommand request, CancellationToken cancellationToken)
        {
            var user = new User
            {
                UserName = request.Data.UserName,
                Email = request.Data.Email,
                FullName = request.Data.FullName,
                Password = request.Data.Password,
                Role = request.Data.Role ?? UserRole.Customer.ToString(),
                DeleteFlag = false,
            };

            var addUserResult = await _userManager.CreateAsync(user, user.Password);
            var addUserRoleResult = await _userManager.AddToRoleAsync(user, user.Role);

            if (addUserResult.Errors.Any())
            {
                return new ServiceResult(false, addUserResult.Errors.ToList()[0].Description);
            }
            else if (addUserRoleResult.Errors.Any())
            {
                return new ServiceResult(false, addUserRoleResult.Errors.ToList()[0].Description);
            }
            else
            {
                return new ServiceResult(true);
            }
        }
    }
}
