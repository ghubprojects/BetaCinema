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
        public Category Data { get; set; }
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
            // Validate
            var validateResult = await ValidateAsync(request.Data);

            if (validateResult.Any())
            {
                return new ServiceResult(false, validateResult.First());
            }
            else
            {
                request.Data.ModifiedDate = DateTime.Now;
                _context.Entry(request.Data).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
        }

        private async Task<List<string>> ValidateAsync(Category category)
        {
            var errors = new List<string>();

            // Validate CategoryName
            if (string.IsNullOrWhiteSpace(category.CategoryName))
            {
                errors.Add(string.Format(MessageResouces.Required, CategoryResources.CategoryName));
            }
            else
            {
                var duplicatedCategory = _context.Categories
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefault(c => string.Equals(c.CategoryName, category.CategoryName, StringComparison.OrdinalIgnoreCase));

                if (duplicatedCategory != null)
                {
                    errors.Add(string.Format(MessageResouces.Duplicated, CategoryResources.CategoryName));
                }
            }

            return errors;
        }
    }
}
