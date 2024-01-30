using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Categories.Commands
{
    public class UpdateCategoryCommand : IRequest<ServiceResult>
    {
        public Category OldData { get; set; } = null!;
        public Category Data { get; set; } = null!;
    }

    public class UpdateCategoryCommandHandler : IRequestHandler<UpdateCategoryCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public UpdateCategoryCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(UpdateCategoryCommand request, CancellationToken cancellationToken)
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
                _context.Entry(request.Data).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }

        private async Task<List<string>> ValidateAsync(Category data, Category old)
        {
            var errors = new List<string>();

            // Validate CategoryName
            if (string.IsNullOrWhiteSpace(data.CategoryName))
            {
                errors.Add(string.Format(MessageResouces.Required, CategoryResources.CategoryName));
            }
            else
            {
                var searchResult = await _context.Categories
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(c => c.CategoryName.ToLower() == data.CategoryName.ToLower() && c.CategoryName.ToLower() != old.CategoryName.ToLower());

                if (searchResult != null)
                {
                    errors.Add(string.Format(MessageResouces.Duplicated, CategoryResources.CategoryName));
                }
            }

            return errors;
        }
    }
}
