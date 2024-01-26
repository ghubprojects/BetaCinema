using BetaCinema.ServerUI.Store.CinemaUseCase;
using BetaCinema.ServerUI.Store.ReservationUseCase;
using Fluxor;

namespace BetaCinema.ServerUI.Store
{
    public class Reducers
    {
        [ReducerMethod]
        public static CinemaState ReduceSelectCinemaAction(CinemaState state, SelectCinemaAction action)
        {
            return new CinemaState(action.Cinema);
        }

        [ReducerMethod]
        public static ReservationState ReduceReserveSeatAction(ReservationState state, ReserveSeatAction action)
        {
            return new ReservationState(action.Showtime, action.SelectedSeat, action.UserFullName, action.UserEmail);
        }
    }
}
