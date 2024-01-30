using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Categories.Commands
{
    public class GetCategoryByIdQuery : IRequest<ServiceResult>
    {
        public string Id { get; set; } = null!;
    }

    public class GetCategoryByIdQueryHandler : IRequestHandler<GetCategoryByIdQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetCategoryByIdQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetCategoryByIdQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var item = await _context.Categories
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(c => c.Id == request.Id, cancellationToken);

                if (item == null)
                    return new ServiceResult(false, string.Format(MessageResouces.NotExisted, CategoryResources.CategoryName));

                return new ServiceResult(true, "", item);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }
    }
}
