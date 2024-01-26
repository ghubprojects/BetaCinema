using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Cinemas.Commands
{
    public class GetAllCinemasQuery : IRequest<List<Cinema>> { }

    public class GetAllCinemasQueryHandler : IRequestHandler<GetAllCinemasQuery, List<Cinema>>
    {
        private readonly IAppDbContext _context;

        public GetAllCinemasQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<List<Cinema>> Handle(GetAllCinemasQuery request, CancellationToken cancellationToken)
        {
            return _context.Cinemas
                .Where(c => !c.DeleteFlag)
                .ToList();
        }
    }
}
