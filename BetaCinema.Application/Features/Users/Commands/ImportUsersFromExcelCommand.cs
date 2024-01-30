using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Enums;
using BetaCinema.Domain.Exceptions;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System.Data;
using System.Text.RegularExpressions;

namespace BetaCinema.Application.Features.Users.Commands
{
    public class ImportUsersFromExcelCommand : IRequest<ServiceResult>
    {
        public ImportRequest ImportRequest { get; set; }
    }

    /// <summary>
    /// Xử lý yêu cầu (request) để nhập dữ liệu người dùng từ file Excel
    /// </summary>
    internal sealed class ImportUsersFromExcelCommandHandler : IRequestHandler<ImportUsersFromExcelCommand, ServiceResult>
    {
        private readonly UserManager<User> _userManager;
        private readonly IAppDbContext _context;

        public ImportUsersFromExcelCommandHandler(UserManager<User> userManager, IAppDbContext context)
        {
            _userManager = userManager;
            _context = context;
        }

        public async Task<ServiceResult> Handle(ImportUsersFromExcelCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var stream = new MemoryStream(request.ImportRequest.Data);
                var result = (await ImportFromExcelHelper<User>.ImportAsync(stream, mappers: new Dictionary<string, Func<DataRow, User, object>>
            {
                {
                    UserResources.UserName, (row,item) =>
                    item.UserName = row[UserResources.UserName].ToString()
                },
                {
                    UserResources.FullName, (row,item) =>
                    item.FullName = row[UserResources.FullName].ToString()
                },
                {
                    UserResources.Email, (row,item) =>
                    item.Email = row[UserResources.Email].ToString()
                },
                {
                    UserResources.Password, (row,item) =>
                    item.Password = row[UserResources.Password].ToString()
                },
                {
                    UserResources.Role, (row,item) =>
                    item.Role = row[UserResources.Role].ToString()
                },
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

                // Validate
                foreach (var user in users)
                {
                    var validateResult = await ValidateAsync(user);

                    if (validateResult.Any())
                        return new ServiceResult(false, validateResult.First());
                }

                // Handle add users
                foreach (var user in users)
                {
                    // Add user
                    var addUserResult = await _userManager.CreateAsync(user, user.Password);
                    if (addUserResult.Errors.Any())
                        return new ServiceResult(false, addUserResult.Errors.First().Description);

                    // Add user role
                    var addUserRoleResult = await _userManager.AddToRoleAsync(user, user.Role);
                    if (addUserRoleResult.Errors.Any())
                        return new ServiceResult(false, addUserRoleResult.Errors.First().Description);
                }

                return new ServiceResult(true);
            }
            catch (Exception ex)
            {
                return new ServiceResult(false,
                    ex is BaseException baseEx ? baseEx.UserMessage : ErrorResources.UnhandledError);
            }
        }

        private async Task<List<string>> ValidateAsync(User user)
        {
            var errors = new List<string>();

            // Validate UserName
            if (string.IsNullOrWhiteSpace(user.UserName))
            {
                errors.Add(string.Format(MessageResouces.Required, UserResources.UserName));
            }
            else
            {
                var searchResult = await _context.Users
                   .Where(u => !u.DeleteFlag)
                   .FirstOrDefaultAsync(u => u.UserName.ToLower() == user.UserName.ToLower());

                if (searchResult != null)
                    errors.Add(string.Format(MessageResouces.Duplicated, UserResources.UserName));
            }

            // Validate Email
            if (string.IsNullOrWhiteSpace(user.Email))
            {
                errors.Add(string.Format(MessageResouces.Required, UserResources.Email));
            }
            else
            {
                // Regular expression pattern for validating email addresses
                string pattern = @"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$";
                Regex regex = new(pattern);

                // Check if the email matches the pattern
                if (!regex.IsMatch(user.Email))
                {
                    errors.Add(string.Format(MessageResouces.Invalid, UserResources.Email));
                }
            }

            // Validate FullName
            if (string.IsNullOrWhiteSpace(user.FullName))
            {
                errors.Add(string.Format(MessageResouces.Required, UserResources.Email));
            }

            // Validate Password
            if (string.IsNullOrWhiteSpace(user.Password))
            {
                errors.Add(string.Format(MessageResouces.Required, UserResources.Password));
            }
            else if (user.Password.Length < 6)
            {
                errors.Add(string.Format(MessageResouces.AtLeast, UserResources.Password, 6));
            }

            // Validate Role
            if (string.IsNullOrWhiteSpace(user.Role))
            {
                errors.Add(string.Format(MessageResouces.Required, UserResources.Role));
            }
            else if (user.Role != UserRole.Admin.ToString() && user.Role != UserRole.Customer.ToString())
            {
                errors.Add(string.Format(MessageResouces.Invalid, UserResources.Role));
            }

            return errors;
        }
    }
}
