using BetaCinema.Application.Interfaces;
using BetaCinema.Application.Interfaces.Services;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Payments.Commands
{
    public class SendTicketBookingEmailCommand : IRequest<ServiceResult>
    {
        public string UserEmail { get; set; }
        public string UserFullName { get; set; }
        public string PaymentId { get; set; }
    }

    public class SendTicketBookingEmailCommandHandler : IRequestHandler<SendTicketBookingEmailCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;
        private readonly IMailService _mailService;

        public SendTicketBookingEmailCommandHandler(IAppDbContext context, IMailService mailService)
        {
            _context = context;
            _mailService = mailService;
        }

        public async Task<ServiceResult> Handle(SendTicketBookingEmailCommand request, CancellationToken cancellationToken)
        {
            var payment = await _context.Payments
                .Include(p => p.Reservation)
                    .ThenInclude(r => r.ReservationItems)
                        .ThenInclude(ri => ri.Seat)
                .Include(p => p.Reservation)
                    .ThenInclude(r => r.Showtime)
                        .ThenInclude(s => s.Cinema)
                .Include(p => p.Reservation)
                    .ThenInclude(r => r.Showtime)
                        .ThenInclude(s => s.Movie)
                .FirstOrDefaultAsync(p => p.Id == request.PaymentId);

            if (payment == null)
            {
                return new ServiceResult(false, string.Format(MessageResouces.NotExisted, PaymentResources.Payment));
            }
            else
            {
                var selectedSeat = payment.Reservation.ReservationItems
                    .OrderBy(x => x.Seat.RowNum)
                    .ThenBy(x => x.Seat.SeatNum)
                    .Select(x => $"{x.Seat.RowNum}{x.Seat.SeatNum}");
                var emailModel = new
                {
                    request.UserFullName,
                    payment.Reservation.Showtime.Movie.MovieName,
                    payment.Reservation.Showtime.Cinema.CinemaName,
                    StartTime = payment.Reservation.Showtime.StartTime.Value.ToString("dd/MM/yyyy HH:mm:ss"),
                    SelectedSeat = string.Join(", ", selectedSeat),
                    payment.PaymentMethod,
                    PaymentTime = payment.CreatedDate.ToString("dd/MM/yyyy HH:mm:ss"),
                    TotalPrice = string.Format("{0} VND", payment.TotalPrice.ToString("#,##0"))
                };

                var emailSubject = "[BetaCinemas _Thông tin vé phim] - Đặt vé trực tuyến thành công / Your online ticket purchase has been successful";

                var result = await _mailService.SendAsync(request.UserEmail, emailSubject, "ticket-booking", emailModel);

                return new ServiceResult(result.Successful);
            }
        }
    }
}
