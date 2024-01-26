using BetaCinema.Application.Features.Seats.Validators;
using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class UpdateSeatCommand : IRequest<ServiceResult>
    {
        public Seat Data { get; set; }
    }

    public class UpdateSeatCommandHandler : IRequestHandler<UpdateSeatCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public UpdateSeatCommandHandler(IAppDbContext context)
        {
            _context = context;
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
                request.Data.ModifiedDate = DateTime.Now;
                _context.Entry(request.Data).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
        }
    }
}
