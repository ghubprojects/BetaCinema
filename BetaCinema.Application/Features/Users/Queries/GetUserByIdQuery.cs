using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
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
        private readonly IUnitOfWork _unitOfWork;

        public GetUserByIdQueryHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<ServiceResult> Handle(GetUserByIdQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var userData = await _unitOfWork.Repository<User>().GetByIdAsync(request.Id);
                return new ServiceResult(true, "", userData);
            }
            catch (Exception ex)
            {
                return new ServiceResult(false, ex.Message);
            }
        }
    }
}
