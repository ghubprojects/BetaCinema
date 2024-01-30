using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Categories.Commands
{
    public class GetAllCategoriesQuery : IRequest<ServiceResult> { }

    public class GetAllCategoriesQueryHandler : IRequestHandler<GetAllCategoriesQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetAllCategoriesQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetAllCategoriesQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var data = await _context.Categories
                    .Where(c => !c.DeleteFlag)
                    .OrderBy(c => c.CategoryName)
                    .AsNoTracking()
                    .ToListAsync(cancellationToken);

                return new ServiceResult(true, "", data);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }
    }
}
