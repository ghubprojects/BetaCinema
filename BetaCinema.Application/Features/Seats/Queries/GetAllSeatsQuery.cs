using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class GetAllSeatsQuery : IRequest<List<Seat>> { }

    public class GetAllSeatsQueryHandler : IRequestHandler<GetAllSeatsQuery, List<Seat>>
    {
        private readonly IAppDbContext _context;

        public GetAllSeatsQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<List<Seat>> Handle(GetAllSeatsQuery request, CancellationToken cancellationToken)
        {
            return _context.Seats
                .Where(s => !s.DeleteFlag)
                .OrderBy(s => s.RowNum)
                .ThenBy(s => s.SeatNum)
                .ToList();
        }
    }
}
