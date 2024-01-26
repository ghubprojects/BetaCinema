using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Users.Commands
{
    public class GetAllUsersQuery : IRequest<List<User>> { }

    public class GetAllUsersQueryHandler : IRequestHandler<GetAllUsersQuery, List<User>>
    {
        private readonly IAppDbContext _context;

        public GetAllUsersQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<List<User>> Handle(GetAllUsersQuery request, CancellationToken cancellationToken)
        {
            return _context.Users
                .Where(u => !u.DeleteFlag)
                .ToList();
        }
    }
}
