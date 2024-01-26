using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Wrappers;
using MediatR;

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
                var userData = await _context.Users.FindAsync(request.Id);
                return new ServiceResult(true, "", userData);
            }
            catch (Exception ex)
            {
                return new ServiceResult(false, ex.Message);
            }
        }
    }
}
