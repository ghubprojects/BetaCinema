using BetaCinema.Application.Features.Cinemas.Validators;
using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;

namespace BetaCinema.Application.Features.Cinemas.Commands
{
    public class CreateCinemaCommand : IRequest<ServiceResult>
    {
        public Cinema Data { get; set; }
    }

    public class CreateCinemaCommandHandler : IRequestHandler<CreateCinemaCommand, ServiceResult>
    {
        private readonly IUnitOfWork _unitOfWork;

        public CreateCinemaCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<ServiceResult> Handle(CreateCinemaCommand request, CancellationToken cancellationToken)
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
                await _unitOfWork.Repository<Cinema>().AddAsync(request.Data);
                return new ServiceResult(true);
            }
        }
    }
}
