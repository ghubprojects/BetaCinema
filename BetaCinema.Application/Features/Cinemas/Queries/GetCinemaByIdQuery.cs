using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Cinemas.Commands
{
    public class GetCinemaByIdQuery : IRequest<Cinema>
    {
        public string Id { get; set; } = null!;
    }

    public class GetCinemaByIdQueryHandler : IRequestHandler<GetCinemaByIdQuery, Cinema>
    {
        private readonly IAppDbContext _context;

        public GetCinemaByIdQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<Cinema> Handle(GetCinemaByIdQuery request, CancellationToken cancellationToken)
        {
            return await _context.Cinemas.FindAsync(request.Id);
        }
    }
}
