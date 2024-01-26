using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Payments.Commands
{
    public class CreatePaymentCommand : IRequest<ServiceResult>
    {
        public Reservation ReservationData { get; set; }
        public string PaymentMethod { get; set; }
        public int TotalPrice { get; set; }
    }

    public class CreatePaymentCommandHandler : IRequestHandler<CreatePaymentCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public CreatePaymentCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(CreatePaymentCommand request, CancellationToken cancellationToken)
        {
            // Validate
            var validateResult = await ValidateAsync(request.ReservationData);

            if (validateResult.Any())
            {
                return new ServiceResult(false, validateResult.First());
            }
            else
            {
                var payment = new Payment()
                {
                    Id = Guid.NewGuid().ToString(),
                    ReservationId = request.ReservationData.Id,
                    TotalPrice = request.TotalPrice,
                    PaymentMethod = request.PaymentMethod,
                    DeleteFlag = false,
                    CreatedDate = DateTime.Now,
                    ModifiedDate = DateTime.Now,
                };

                _context.Payments.Add(payment);
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true, "", payment);
            }
        }

        private async Task<List<string>> ValidateAsync(Reservation reservation)
        {
            var errors = new List<string>();

            // Validate Reservation
            if (string.IsNullOrWhiteSpace(reservation.Id))
            {
                errors.Add(string.Format(MessageResouces.Required, ReservationResources.Reservation));
            }
            else
            {
                var searchResult = await _context.Reservations
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(r => r.Id == reservation.Id);

                if (searchResult == null)
                {
                    errors.Add(string.Format(MessageResouces.NotExisted, ReservationResources.Reservation));
                }
            }

            return errors;
        }
    }
}

