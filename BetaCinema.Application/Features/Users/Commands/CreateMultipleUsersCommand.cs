using BetaCinema.Domain.Enums;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.AspNetCore.Identity;

namespace BetaCinema.Application.Features.Users.Commands
{
    public class CreateMultipleUsersCommand : IRequest<ServiceResult>
    {
        public List<User> ListData { get; set; }
    }

    public class CreateMultipleUsersCommandHandler : IRequestHandler<CreateMultipleUsersCommand, ServiceResult>
    {
        private readonly UserManager<User> _userManager;

        public CreateMultipleUsersCommandHandler(UserManager<User> userManager)
        {
            _userManager = userManager;
        }

        public async Task<ServiceResult> Handle(CreateMultipleUsersCommand request, CancellationToken cancellationToken)
        {
            var users = request.ListData.Select(data => new User
            {
                UserName = data.UserName,
                FullName = data.FullName,
                Email = data.Email,
                Password = data.Password,
                Role = data.Role ?? UserRole.Customer.ToString(),
                DeleteFlag = false,
            });

            foreach (var user in users)
            {
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

            return new ServiceResult(true);
        }
    }
}
