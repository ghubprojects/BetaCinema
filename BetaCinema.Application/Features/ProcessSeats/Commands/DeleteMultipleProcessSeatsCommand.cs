using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.ProcessSeats.Commands
{
    public class DeleteMultipleProcessSeatsCommand : IRequest<ServiceResult>
    {
        public List<Seat> SeatList { get; set; } = null!;
        public Showtime ShowtimeData { get; set; } = null!;
    }

    public class DeleteMultipleProcessSeatsCommandHandler : IRequestHandler<DeleteMultipleProcessSeatsCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public DeleteMultipleProcessSeatsCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(DeleteMultipleProcessSeatsCommand request, CancellationToken cancellationToken)
        {
            try
            {
                // Validate exist or not
                foreach (var seat in request.SeatList)
                {
                    var item = await _context.ProcessSeats
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(c => c.SeatId == seat.Id && c.ShowtimeId == request.ShowtimeData.Id, cancellationToken);

                    // If errors, return false
                    if (item == null)
                        return new ServiceResult(false, string.Format(MessageResouces.NotExisted, SeatResources.Seat));
                }

                // Set DeleteFlag to true
                foreach (var seat in request.SeatList)
                {
                    var item = await _context.ProcessSeats
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(c => c.SeatId == seat.Id && c.ShowtimeId == request.ShowtimeData.Id, cancellationToken);

                    item.DeleteFlag = true;
                    _context.Entry(item).State = EntityState.Modified;
                }

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
