using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Enums;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;
using System.Text.RegularExpressions;

namespace BetaCinema.Application.Features.Users.Commands
{
    public class UpdateUserCommand : IRequest<ServiceResult>
    {
        public User OldData { get; set; }
        public User Data { get; set; }
    }

    public class UpdateUserCommandHandler : IRequestHandler<UpdateUserCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public UpdateUserCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(UpdateUserCommand request, CancellationToken cancellationToken)
        {
            try
            {
                // Validate
                var validateResult = await ValidateAsync(request.Data, request.OldData);

                // If errors, return false
                if (validateResult.Any())
                    return new ServiceResult(false, validateResult.First());

                // Update item
                request.Data.ModifiedDate = DateTime.Now;
                request.Data.NormalizedEmail = request.Data.Email.ToUpper();
                request.Data.NormalizedUserName = request.Data.UserName.ToUpper();

                _context.Entry(request.Data).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }

        private async Task<List<string>> ValidateAsync(User user, User old)
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
                   .FirstOrDefaultAsync(u => u.UserName.ToLower() == user.UserName.ToLower() && u.UserName.ToLower() == old.UserName.ToLower());

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
