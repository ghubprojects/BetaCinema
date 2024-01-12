using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using MediatR;

namespace BetaCinema.Application.Features.Cinemas.Commands
{
    public class GetAllCinemasQuery : IRequest<List<Cinema>> { }

    public class GetAllCinemasQueryHandler : IRequestHandler<GetAllCinemasQuery, List<Cinema>>
    {
        private readonly IUnitOfWork _unitOfWork;

        public GetAllCinemasQueryHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<List<Cinema>> Handle(GetAllCinemasQuery request, CancellationToken cancellationToken)
        {
            return await _unitOfWork.Repository<Cinema>().GetAllAsync();
        }
    }
}
