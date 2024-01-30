using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

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
            try
            {
                // Validate
                var validateResult = await ValidateAsync(request.Data);

                // If errors, return false
                if (validateResult.Any())
                    return new ServiceResult(false, validateResult.First());

                request.Data.Id = Guid.NewGuid().ToString();
                request.Data.DeleteFlag = false;
                request.Data.CreatedDate = DateTime.Now;
                request.Data.ModifiedDate = DateTime.Now;

                _context.Cinemas.Add(request.Data);
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }

        }

        private async Task<List<string>> ValidateAsync(Cinema cinema)
        {
            var errors = new List<string>();

            // Validate CinemaName
            if (string.IsNullOrWhiteSpace(cinema.CinemaName))
            {
                errors.Add(string.Format(MessageResouces.Required, CinemaResources.CinemaName));
            }
            else
            {
                var searchResult = await _context.Cinemas
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(c => c.CinemaName.ToLower() == cinema.CinemaName.ToLower());

                if (searchResult != null)
                    errors.Add(string.Format(MessageResouces.Duplicated, CinemaResources.CinemaName));
            }

            // Validate CinemaName
            if (string.IsNullOrWhiteSpace(cinema.CinemaLocation))
            {
                errors.Add(string.Format(MessageResouces.Required, CinemaResources.CinemaLocation));
            }

            return errors;
        }
    }
}
