using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Showtimes.Commands
{
    public class GetAllShowtimesQuery : IRequest<List<Showtime>> { }

    public class GetAllShowtimesQueryHandler : IRequestHandler<GetAllShowtimesQuery, List<Showtime>>
    {
        private readonly IAppDbContext _context;

        public GetAllShowtimesQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<List<Showtime>> Handle(GetAllShowtimesQuery request, CancellationToken cancellationToken)
        {
            return _context.Showtimes
                .Where(s => !s.DeleteFlag)
                .OrderBy(s => s.StartTime.Value)
                .Include(s => s.Movie)
                .Include(s => s.Cinema)
                .AsNoTracking()
                .ToList();
        }
    }
}

