using BetaCinema.Application.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class DeleteSeatCommand : IRequest
    {
        public string Id { get; set; } = null!;
    }

    public class DeleteSeatCommandHandler : IRequestHandler<DeleteSeatCommand>
    {
        private readonly IAppDbContext _context;

        public DeleteSeatCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task Handle(DeleteSeatCommand request, CancellationToken cancellationToken)
        {
            var seat = await _context.Seats.FindAsync(request.Id);
            if (seat != null)
            {
                seat.DeleteFlag = true;
                _context.Entry(seat).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
            }
        }
    }
}
