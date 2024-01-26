using BetaCinema.Application.Features.Cinemas.Validators;
using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Cinemas.Commands
{
    public class UpdateCinemaCommand : IRequest<ServiceResult>
    {
        public Cinema Data { get; set; }
    }

    public class UpdateCinemaCommandHandler : IRequestHandler<UpdateCinemaCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public UpdateCinemaCommandHandler(IAppDbContext context)
        {
            _context = context;
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
                request.Data.ModifiedDate = DateTime.Now;
                _context.Entry(request.Data).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
        }
    }
}
