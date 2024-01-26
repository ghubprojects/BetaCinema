using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Showtimes.Commands
{
    public class GetShowtimeByIdQuery : IRequest<Showtime>
    {
        public string Id { get; set; } = null!;
    }

    public class GetShowtimeByIdQueryHandler : IRequestHandler<GetShowtimeByIdQuery, Showtime>
    {
        private readonly IAppDbContext _context;

        public GetShowtimeByIdQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<Showtime> Handle(GetShowtimeByIdQuery request, CancellationToken cancellationToken)
        {
            return await _context.Showtimes
                .Include(s => s.Movie)
                .Include(s => s.Cinema)
                .FirstOrDefaultAsync(s => s.Id == request.Id);
        }
    }
}
