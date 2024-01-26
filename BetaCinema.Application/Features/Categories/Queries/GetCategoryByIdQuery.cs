using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Categories.Commands
{
    public class GetCategoryByIdQuery : IRequest<Category>
    {
        public string Id { get; set; } = null!;
    }

    public class GetCategoryByIdQueryHandler : IRequestHandler<GetCategoryByIdQuery, Category>
    {
        private readonly IAppDbContext _context;

        public GetCategoryByIdQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<Category> Handle(GetCategoryByIdQuery request, CancellationToken cancellationToken)
        {
            return await _context.Categories.FindAsync(request.Id);
        }
    }
}
