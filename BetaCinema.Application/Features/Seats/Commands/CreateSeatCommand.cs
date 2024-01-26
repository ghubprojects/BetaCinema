using BetaCinema.Application.Features.Seats.Validators;
using BetaCinema.Application.Interfaces;
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
        private readonly IAppDbContext _context;

        public CreateSeatCommandHandler(IAppDbContext context)
        {
            _context = context;
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
                request.Data.DeleteFlag = false;
                request.Data.CreatedDate = DateTime.Now;
                request.Data.ModifiedDate = DateTime.Now;

                _context.Seats.Add(request.Data);
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
        }
    }
}
