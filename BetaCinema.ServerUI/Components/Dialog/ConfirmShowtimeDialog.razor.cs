using BetaCinema.Domain.Models;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.WebUtilities;
using MudBlazor;

namespace BetaCinema.ServerUI.Components.Dialog
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
