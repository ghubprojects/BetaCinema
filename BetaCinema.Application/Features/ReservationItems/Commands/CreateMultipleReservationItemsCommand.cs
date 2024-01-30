using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;

namespace BetaCinema.Application.Features.ReservationItems.Commands
{
    public class CreateMultipleReservationItemsCommand : IRequest<ServiceResult>
    {
        public Reservation ReservationData { get; set; }
        public string SelectedSeatList { get; set; }
    }

    public class CreateMultipleReservationItemsCommandHandler : IRequestHandler<CreateMultipleReservationItemsCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public CreateMultipleReservationItemsCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(CreateMultipleReservationItemsCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var reservationItemList = new List<ReservationItem>();
                var selectedSeatsString = request.SelectedSeatList.Split(", ");

                if (!selectedSeatsString.Any())
                    return new ServiceResult(false, string.Format(MessageResouces.Required, SeatResources.Seat));

                foreach (var seat in selectedSeatsString)
                {
                    var searchResult = _context.Seats
                         .Where(x => string.Concat(x.RowNum, x.SeatNum.ToString()) == seat)
                         .FirstOrDefault();

                    if (searchResult == null)
                    {
                        return new ServiceResult(false, string.Format(MessageResouces.NotExisted, $"{SeatResources.Seat} <{seat}>"));
                    }

                    reservationItemList.Add(new ReservationItem()
                    {
                        Id = Guid.NewGuid().ToString(),
                        ReservationId = request.ReservationData.Id,
                        SeatId = searchResult.Id,
                        DeleteFlag = false,
                        CreatedDate = DateTime.Now,
                        ModifiedDate = DateTime.Now,
                    });
                }

                _context.ReservationItems.AddRange(reservationItemList);
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }
    }
}