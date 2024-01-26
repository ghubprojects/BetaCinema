using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Payments.Commands
{
    public class GetAllPaymentsQuery : IRequest<List<Payment>> { }

    public class GetAllPaymentsQueryHandler : IRequestHandler<GetAllPaymentsQuery, List<Payment>>
    {
        private readonly IAppDbContext _context;

        public GetAllPaymentsQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<List<Payment>> Handle(GetAllPaymentsQuery request, CancellationToken cancellationToken)
        {
            return _context.Payments
                .Where(c => !c.DeleteFlag)
                .ToList();
        }
    }
}
