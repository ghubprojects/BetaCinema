using BetaCinema.Application.Features.Movies.Validators;
using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class CreateMovieCommand : IRequest<ServiceResult>
    {
        public Movie Data { get; set; }
    }

    public class CreateMovieCommandHandler : IRequestHandler<CreateMovieCommand, ServiceResult>
    {
        private readonly IUnitOfWork _unitOfWork;

        public CreateMovieCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<ServiceResult> Handle(CreateMovieCommand request, CancellationToken cancellationToken)
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
                await _unitOfWork.Repository<Movie>().AddAsync(request.Data);
                return new ServiceResult(true);
            }
        }
    }
}
