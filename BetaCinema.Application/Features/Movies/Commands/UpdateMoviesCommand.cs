using BetaCinema.Application.Features.Movies.Validators;
using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class UpdateMovieCommand : IRequest<ServiceResult>
    {
        public Movie Data { get; set; }
    }

    public class UpdateMovieCommandHandler : IRequestHandler<UpdateMovieCommand, ServiceResult>
    {
        private readonly IUnitOfWork _unitOfWork;

        public UpdateMovieCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<ServiceResult> Handle(UpdateMovieCommand request, CancellationToken cancellationToken)
        {
            // Validate
            var validateResult = CreateUpdateImportValidator.Validate(request.Data);

            if (validateResult.Any())
            {
                return new ServiceResult(false, validateResult.First());
            }
            else
            {
                await _unitOfWork.Repository<Movie>().UpdateAsync(request.Data);
                return new ServiceResult(true);
            }
        }
    }
}
