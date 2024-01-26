using BetaCinema.Domain.Models;
using Fluxor;

namespace BetaCinema.ServerUI.Store.ReservationUseCase
{
    [FeatureState]
    public class ReservationState
    {
        public Showtime Showtime { get; }

        public List<Seat> SelectedSeat { get; }

        public string UserFullName { get; set; }

        public string UserEmail { get; set; }

        private ReservationState() { }

        public ReservationState(Showtime showtime, List<Seat> selectedSeat, string userFullName, string userEmail)
        {
            Showtime = showtime;
            SelectedSeat = selectedSeat;
            UserFullName = userFullName;
            UserEmail = userEmail;
        }
    }
}
