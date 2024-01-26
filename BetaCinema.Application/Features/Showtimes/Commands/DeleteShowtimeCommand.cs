using BetaCinema.Application.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Showtimes.Commands
{
    public class DeleteShowtimeCommand : IRequest
    {
        public string Id { get; set; } = null!;
    }

    public class DeleteShowtimeCommandHandler : IRequestHandler<DeleteShowtimeCommand>
    {
        private readonly IAppDbContext _context;

        public DeleteShowtimeCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task Handle(DeleteShowtimeCommand request, CancellationToken cancellationToken)
        {
            var item = await _context.Showtimes.FindAsync(request.Id);
            if (item != null)
            {
                item.DeleteFlag = true;
                _context.Entry(item).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
            }
        }
    }
}
