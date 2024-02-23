using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class GetProcessSeatsByShowtime : IRequest<ServiceResult>
    {
        public Showtime ShowtimeData { get; set; } = null!;
    }

    public class GetProcessSeatsByShowtimeHandler : IRequestHandler<GetProcessSeatsByShowtime, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetProcessSeatsByShowtimeHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetProcessSeatsByShowtime request, CancellationToken cancellationToken)
        {
            try
            {
                var data = await _context.ProcessSeats
                    .Include(x => x.Seat)
                    .Include(x => x.Showtime)
                    .Where(x => !x.DeleteFlag && x.Showtime.Id == request.ShowtimeData.Id)
                    .Select(x => x.Seat)
                    .AsNoTracking()
                    .ToListAsync(cancellationToken);

                return new ServiceResult(true, "", data);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }
    }
}
