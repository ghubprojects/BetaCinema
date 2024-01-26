using BetaCinema.Domain.Models;

namespace BetaCinema.ServerUI.Store.ReservationUseCase
{
    public class ReserveSeatAction
    {
        public Showtime Showtime { get; set; }

        public List<Seat> SelectedSeat { get; set; }

        public string UserFullName { get; set; }

        public string UserEmail { get; set; }
    }
}
