using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Users.Commands
{
    public class GetUserByIdQuery : IRequest<ServiceResult>
    {
        public string Id { get; set; } = null!;
    }

    public class GetUserByIdQueryHandler : IRequestHandler<GetUserByIdQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetUserByIdQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetUserByIdQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var user = await _context.Users
                    .Where(u => !u.DeleteFlag)
                    .FirstOrDefaultAsync(u => u.Id == request.Id, cancellationToken);

                if (user == null)
                    return new ServiceResult(false, string.Format(MessageResouces.NotExisted, UserResources.User));

                return new ServiceResult(true, "", user);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }
    }
}
