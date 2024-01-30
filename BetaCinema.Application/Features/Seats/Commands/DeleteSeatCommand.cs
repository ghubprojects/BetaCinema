using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class DeleteSeatCommand : IRequest<ServiceResult>
    {
        public string Id { get; set; } = null!;
    }

    public class DeleteSeatCommandHandler : IRequestHandler<DeleteSeatCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public DeleteSeatCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(DeleteSeatCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var seat = await _context.Seats
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(c => c.Id == request.Id, cancellationToken);

                // If errors, return false
                if (seat == null)
                    return new ServiceResult(false, string.Format(MessageResouces.NotExisted, SeatResources.Seat));

                // Delete item
                seat.DeleteFlag = true;
                _context.Entry(seat).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }
    }
}
