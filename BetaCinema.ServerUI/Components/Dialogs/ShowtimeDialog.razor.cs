using BetaCinema.ServerUI.Store.CinemaUseCase;

namespace BetaCinema.ServerUI.Components.Dialogs
{
    public class ShowtimeDialogBase : ComponentBase
    {
        [Inject] protected IState<CinemaState> CinemaState { get; set; }

        [Parameter] public Movie MovieData { get; set; }
    }
}
