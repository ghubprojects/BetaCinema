using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Reservations.Commands
{
    public class CreateReservationCommand : IRequest<ServiceResult>
    {
        public string UserId { get; set; }
        public Showtime ShowtimeData { get; set; }
    }

    public class CreateReservationCommandHandler : IRequestHandler<CreateReservationCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public CreateReservationCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(CreateReservationCommand request, CancellationToken cancellationToken)
        {
            try
            {
                // Validate
                var validateResult = await ValidateAsync(request.UserId, request.ShowtimeData);

                if (validateResult.Any())
                {
                    return new ServiceResult(false, validateResult.First());
                }
                else
                {
                    var reservation = new Reservation()
                    {
                        Id = Guid.NewGuid().ToString(),
                        UserId = request.UserId,
                        ShowtimeId = request.ShowtimeData.Id,
                        DeleteFlag = false,
                        CreatedDate = DateTime.Now,
                        ModifiedDate = DateTime.Now,
                    };

                    _context.Reservations.Add(reservation);
                    await _context.SaveChangesAsync(cancellationToken);
                    return new ServiceResult(true, "", reservation);
                }
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }

        private async Task<List<string>> ValidateAsync(string userId, Showtime showtimeData)
        {
            var errors = new List<string>();

            // Validate UserId
            var searchResult = await _context.Users
                .Where(c => !c.DeleteFlag)
                .FirstOrDefaultAsync(c => c.Id == userId);

            if (searchResult == null)
                errors.Add(string.Format(MessageResouces.NotExisted, UserResources.User));

            // Validate showtime data
            if (showtimeData == null)
            {
                errors.Add(string.Format(MessageResouces.Required, ShowtimeResources.Showtime));
            }

            return errors;
        }
    }
}
