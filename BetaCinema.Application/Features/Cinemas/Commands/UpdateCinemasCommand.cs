using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Cinemas.Commands
{
    public class UpdateCinemaCommand : IRequest<ServiceResult>
    {
        public Cinema Data { get; set; }
        public Cinema OldData { get; set; }
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
            try
            {
                // Validate
                var validateResult = await ValidateAsync(request.Data, request.OldData);

                // If errors, return false
                if (validateResult.Any())
                    return new ServiceResult(false, validateResult.First());

                // Update item
                request.Data.ModifiedDate = DateTime.Now;
                _context.Entry(request.Data).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }

        private async Task<List<string>> ValidateAsync(Cinema data, Cinema old)
        {
            var errors = new List<string>();

            // Validate CinemaName
            if (string.IsNullOrWhiteSpace(data.CinemaName))
            {
                errors.Add(string.Format(MessageResouces.Required, CinemaResources.CinemaName));
            }
            else
            {
                var searchResult = await _context.Cinemas
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(c => c.CinemaName.ToLower() == data.CinemaName.ToLower() && c.CinemaName.ToLower() != old.CinemaName.ToLower());

                if (searchResult != null)
                    errors.Add(string.Format(MessageResouces.Duplicated, CinemaResources.CinemaName));
            }

            // Validate CinemaName
            if (string.IsNullOrWhiteSpace(data.CinemaLocation))
            {
                errors.Add(string.Format(MessageResouces.Required, CinemaResources.CinemaLocation));
            }

            return errors;
        }
    }
}
