using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class GetSeatByIdQuery : IRequest<Seat>
    {
        public string Id { get; set; } = null!;
    }

    public class GetSeatByIdQueryHandler : IRequestHandler<GetSeatByIdQuery, Seat>
    {
        private readonly IAppDbContext _context;

        public GetSeatByIdQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<Seat> Handle(GetSeatByIdQuery request, CancellationToken cancellationToken)
        {
            return await _context.Seats.FindAsync(request.Id);
        }
    }
}
