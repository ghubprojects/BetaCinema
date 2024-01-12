using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Payments.Commands
{
    public class GetAllPaymentsQuery : IRequest<List<Payment>> { }

    public class GetAllPaymentsQueryHandler : IRequestHandler<GetAllPaymentsQuery, List<Payment>>
    {
        private readonly IUnitOfWork _unitOfWork;

        public GetAllPaymentsQueryHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<List<Payment>> Handle(GetAllPaymentsQuery request, CancellationToken cancellationToken)
        {
            return await _unitOfWork.Repository<Payment>().GetAllAsync();
        }
    }
}
