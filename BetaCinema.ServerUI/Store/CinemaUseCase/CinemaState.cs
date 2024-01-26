using BetaCinema.Domain.Models;
using Fluxor;

namespace BetaCinema.ServerUI.Store.CinemaUseCase
{
    [FeatureState]
    public class CinemaState
    {
        public Cinema Cinema { get; }

        private CinemaState() { } // Required for creating initial state

        public CinemaState(Cinema cinema)
        {
            Cinema = cinema;
        }
    }
}
