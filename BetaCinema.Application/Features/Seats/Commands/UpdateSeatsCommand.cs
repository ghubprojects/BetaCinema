using BetaCinema.Application.Features.Seats.Validators;
using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class UpdateSeatCommand : IRequest<ServiceResult>
    {
        public Seat Data { get; set; }
    }

    public class UpdateSeatCommandHandler : IRequestHandler<UpdateSeatCommand, ServiceResult>
    {
        private readonly IUnitOfWork _unitOfWork;

        public UpdateSeatCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<ServiceResult> Handle(UpdateSeatCommand request, CancellationToken cancellationToken)
        {
            // Validate
            var validateResult = CreateUpdateImportValidator.Validate(request.Data);

            if (validateResult.Any())
            {
                return new ServiceResult(false, validateResult.First());
            }
            else
            {
                await _unitOfWork.Repository<Seat>().UpdateAsync(request.Data);
                return new ServiceResult(true);
            }
        }
    }
}
