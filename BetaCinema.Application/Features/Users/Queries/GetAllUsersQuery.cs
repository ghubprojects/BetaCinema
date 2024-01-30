using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Users.Commands
{
    public class GetAllUsersQuery : IRequest<ServiceResult> { }

    public class GetAllUsersQueryHandler : IRequestHandler<GetAllUsersQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetAllUsersQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetAllUsersQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var data = await _context.Users
                    .Where(u => !u.DeleteFlag)
                    .OrderBy(u => u.Role)
                    .ThenBy(u => u.UserName)
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
