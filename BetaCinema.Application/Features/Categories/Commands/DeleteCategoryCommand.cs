using BetaCinema.Application.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Categorys.Commands
{
    public class DeleteCategoryCommand : IRequest
    {
        public string Id { get; set; } = null!;
    }

    public class DeleteCategoryCommandHandler : IRequestHandler<DeleteCategoryCommand>
    {
        private readonly IAppDbContext _context;

        public DeleteCategoryCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task Handle(DeleteCategoryCommand request, CancellationToken cancellationToken)
        {
            var category = await _context.Categories.FindAsync(request.Id);
            if (category != null)
            {
                category.DeleteFlag = true;
                _context.Entry(category).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
            }
        }
    }
}
