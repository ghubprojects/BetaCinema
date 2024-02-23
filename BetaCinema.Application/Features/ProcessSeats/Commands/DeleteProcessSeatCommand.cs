using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.ProcessSeats.Commands
{
    public class DeleteProcessSeatCommand : IRequest<ServiceResult>
    {
        public Seat SeatData { get; set; } = null!;
        public Showtime ShowtimeData { get; set; } = null!;
    }

    public class DeleteProcessSeatCommandHandler : IRequestHandler<DeleteProcessSeatCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public DeleteProcessSeatCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(DeleteProcessSeatCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var item = await _context.ProcessSeats
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(c => c.SeatId == request.SeatData.Id && c.ShowtimeId == request.ShowtimeData.Id, cancellationToken);

                // If errors, return false
                if (item == null)
                    return new ServiceResult(false, string.Format(MessageResouces.NotExisted, SeatResources.Seat));

                // Delete item
                item.DeleteFlag = true;
                _context.Entry(item).State = EntityState.Modified;
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
