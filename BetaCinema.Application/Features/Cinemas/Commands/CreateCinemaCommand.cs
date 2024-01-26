using BetaCinema.Application.Features.Cinemas.Validators;
using BetaCinema.Application.Interfaces;
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
        private readonly IAppDbContext _context;

        public CreateCinemaCommandHandler(IAppDbContext context)
        {
            _context = context;
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
                request.Data.DeleteFlag = false;
                request.Data.CreatedDate = DateTime.Now;
                request.Data.ModifiedDate = DateTime.Now;

                _context.Cinemas.Add(request.Data);
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
        }
    }
}
