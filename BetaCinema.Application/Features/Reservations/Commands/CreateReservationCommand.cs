using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;

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
            // Validate
            var validateResult = await ValidateAsync();

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

        private async Task<List<string>> ValidateAsync()
        {
            var errors = new List<string>();

            return errors;
        }
    }
}
