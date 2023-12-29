using BetaCinema.Application.Helpers;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Enums;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.AspNetCore.Identity;
using System.Data;

namespace BetaCinema.Application.Features.Users.Commands
{
    public class ImportUsersFromExcelCommand : IRequest<ServiceResult>
    {
        public UploadRequest UploadRequest { get; set; }
    }

    /// <summary>
    /// Xử lý yêu cầu (request) để nhập dữ liệu người dùng từ file Excel
    /// </summary>
    internal sealed class ImportUsersFromExcelCommandHandler : IRequestHandler<ImportUsersFromExcelCommand, ServiceResult>
    {
        private readonly UserManager<User> _userManager;

        public ImportUsersFromExcelCommandHandler(UserManager<User> userManager)
        {
            _userManager = userManager;
        }

        public async Task<ServiceResult> Handle(ImportUsersFromExcelCommand request, CancellationToken cancellationToken)
        {
            var stream = new MemoryStream(request.UploadRequest.Data);
            var result = (await ImportFromExcelHelper<User>.ImportAsync(stream, mappers: new Dictionary<string, Func<DataRow, User, object>>
            {
                { "UserName", (row,item) => item.UserName = row["UserName"].ToString() },
                { "FullName", (row,item) => item.FullName = row["FullName"].ToString() },
                { "Email", (row,item) => item.Email = row["Email"].ToString() },
                { "Password", (row,item) => item.Password = row["Password"].ToString() },
                { "Role", (row,item) => item.Role = row["Role"].ToString() },
            }, "Sheet1"));

            var users = result.Select(data => new User
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
            }

            return new ServiceResult(true);
        }
    }
}
