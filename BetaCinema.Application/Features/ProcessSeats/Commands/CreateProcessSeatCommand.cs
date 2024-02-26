using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using Hangfire;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.ProcessSeats.Commands
{
    public class CreateProcessSeatCommand : IRequest<ServiceResult>
    {
        public Seat SeatData { get; set; } = null!;
        public Showtime ShowtimeData { get; set; } = null!;
    }

    public class CreateProcessSeatCommandHandler : IRequestHandler<CreateProcessSeatCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public CreateProcessSeatCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(CreateProcessSeatCommand request, CancellationToken cancellationToken)
        {
            try
            {
                // Add item
                var newItem = new ProcessSeat()
                {
                    Id = Guid.NewGuid().ToString(),
                    SeatId = request.SeatData.Id,
                    ShowtimeId = request.ShowtimeData.Id,
                    DeleteFlag = false,
                    CreatedDate = DateTime.Now,
                    ModifiedDate = DateTime.Now,
                };

                _context.ProcessSeats.Add(newItem);
                await _context.SaveChangesAsync(cancellationToken);

                BackgroundJob.Schedule(() => AutoDeleteAfterTimeout(newItem, cancellationToken), TimeSpan.FromSeconds(60));

                return new ServiceResult(true);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }

        public async Task AutoDeleteAfterTimeout(ProcessSeat item, CancellationToken cancellationToken)
        {
            item.DeleteFlag = true;
            _context.Entry(item).State = EntityState.Modified;
            await _context.SaveChangesAsync(cancellationToken);
        }
    }
}
