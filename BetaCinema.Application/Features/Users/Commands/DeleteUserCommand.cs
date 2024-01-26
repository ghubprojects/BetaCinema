using BetaCinema.Application.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Users.Commands
{
    public class DeleteUserCommand : IRequest
    {
        public string Id { get; set; } = null!;
    }

    public class DeleteUserCommandHandler : IRequestHandler<DeleteUserCommand>
    {
        private readonly IAppDbContext _context;

        public DeleteUserCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task Handle(DeleteUserCommand request, CancellationToken cancellationToken)
        {
            var item = await _context.Users.FindAsync(request.Id);
            if (item != null)
            {
                item.DeleteFlag = true;
                _context.Entry(item).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
            }
        }
    }
}
