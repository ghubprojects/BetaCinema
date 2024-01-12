using BetaCinema.Application.Features.Cinemas.Validators;
using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;

namespace BetaCinema.Application.Features.Cinemas.Commands
{
    public class UpdateCinemaCommand : IRequest<ServiceResult>
    {
        public Cinema Data { get; set; }
    }

    public class UpdateCinemaCommandHandler : IRequestHandler<UpdateCinemaCommand, ServiceResult>
    {
        private readonly IUnitOfWork _unitOfWork;

        public UpdateCinemaCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<ServiceResult> Handle(UpdateCinemaCommand request, CancellationToken cancellationToken)
        {
            // Validate
            var validateResult = CreateUpdateImportValidator.Validate(request.Data);

            if (validateResult.Any())
            {
                return new ServiceResult(false, validateResult.First());
            }
            else
            {
                await _unitOfWork.Repository<Cinema>().UpdateAsync(request.Data);
                return new ServiceResult(true);
            }
        }
    }
}
