using Microsoft.AspNetCore.WebUtilities;

namespace BetaCinema.ServerUI.Components.Dialogs
{
    public class ConfirmShowtimeDialogBase : ComponentBase
    {
        [Inject] protected NavigationManager Navigation { get; set; }

        [CascadingParameter] MudDialogInstance MudDialog { get; set; }

        [Parameter] public string ButtonText { get; set; }

        [Parameter] public Showtime ShowtimeData { get; set; }

        protected string uri { get; set; }

        protected void NavigateToReservation()
        {
            MudDialog.Close(DialogResult.Ok(true));

            var query = new Dictionary<string, string> { { "id", ShowtimeData.Id } };
            uri = QueryHelpers.AddQueryString("/reservation", query);
            Navigation.NavigateTo(uri);
        }
    }
}
