using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Categories.Commands
{
    public class GetAllCategoriesQuery : IRequest<List<Category>> { }

    public class GetAllCategoriesQueryHandler : IRequestHandler<GetAllCategoriesQuery, List<Category>>
    {
        private readonly IAppDbContext _context;

        public GetAllCategoriesQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<List<Category>> Handle(GetAllCategoriesQuery request, CancellationToken cancellationToken)
        {
            return _context.Categories
                .Where(c => !c.DeleteFlag)
                .ToList();
        }
    }
}
