using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class GetSoldSeatsByShowtimeId : IRequest<List<Seat>>
    {
        public string ShowtimeId { get; set; } = null!;
    }

    public class GetSoldSeatsByShowtimeIdHandler : IRequestHandler<GetSoldSeatsByShowtimeId, List<Seat>>
    {
        private readonly IAppDbContext _context;

        public GetSoldSeatsByShowtimeIdHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<List<Seat>> Handle(GetSoldSeatsByShowtimeId request, CancellationToken cancellationToken)
        {
            return _context.ReservationItems
                .Include(ri => ri.Seat)
                .Include(ri => ri.Reservation)
                    .ThenInclude(r => r.Showtime)
                .Where(ri => ri.Reservation.ShowtimeId == request.ShowtimeId)
                .Select(ri => ri.Seat)
                .ToList();
        }
    }
}
