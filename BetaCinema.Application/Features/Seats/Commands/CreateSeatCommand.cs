using BetaCinema.Application.Features.Seats.Validators;
using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class CreateSeatCommand : IRequest<ServiceResult>
    {
        public Seat Data { get; set; }
    }

    public class CreateSeatCommandHandler : IRequestHandler<CreateSeatCommand, ServiceResult>
    {
        private readonly IUnitOfWork _unitOfWork;

        public CreateSeatCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<ServiceResult> Handle(CreateSeatCommand request, CancellationToken cancellationToken)
        {
            // Validate
            var validateResult = CreateUpdateImportValidator.Validate(request.Data);

            if (validateResult.Any())
            {
                return new ServiceResult(false, validateResult.First());
            }
            else
            {
                request.Data.Id = Guid.NewGuid().ToString();
                await _unitOfWork.Repository<Seat>().AddAsync(request.Data);
                return new ServiceResult(true);
            }
        }
    }
}
