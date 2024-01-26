using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;

namespace BetaCinema.Application.Features.Categories.Commands
{
    public class CreateCategoryCommand : IRequest<ServiceResult>
    {
        public Category Data { get; set; }
    }

    public class CreateCategoryCommandHandler : IRequestHandler<CreateCategoryCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public CreateCategoryCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(CreateCategoryCommand request, CancellationToken cancellationToken)
        {
            // Validate
            var validateResult = await ValidateAsync(request.Data);

            if (validateResult.Any())
            {
                return new ServiceResult(false, validateResult.First());
            }
            else
            {
                request.Data.Id = Guid.NewGuid().ToString();
                request.Data.DeleteFlag = false;
                request.Data.CreatedDate = DateTime.Now;
                request.Data.ModifiedDate = DateTime.Now;

                _context.Categories.Add(request.Data);
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
                var searchResult = _context.Categories
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefault(c => string.Equals(c.CategoryName, category.CategoryName, StringComparison.OrdinalIgnoreCase));

                if (searchResult != null)
                {
                    errors.Add(string.Format(MessageResouces.Duplicated, CategoryResources.CategoryName));
                }
            }

            return errors;
        }
    }
}
