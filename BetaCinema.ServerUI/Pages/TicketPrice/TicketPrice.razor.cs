using BetaCinema.ServerUI.Store.CinemaUseCase;
using Fluxor;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Components.Server.ProtectedBrowserStorage;

namespace BetaCinema.ServerUI.Pages.TicketPrice
{
    public class TicketPriceBase : ComponentBase
    {
        [Inject] protected AuthenticationStateProvider AuthenticationStateProvider { get; set; }

        [Inject] protected ProtectedLocalStorage BrowserStorage { get; set; }

        [Inject] protected IState<CinemaState> CinemaState { get; set; }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            // check if the user is autheticated
            var authState = await AuthenticationStateProvider.GetAuthenticationStateAsync();
            var userId = authState.User.FindFirst(u => u.Type.Contains("nameidentifier"))?.Value;

            if (userId != null)
            {
                // check if user id is stored
                var storedUserId = await BrowserStorage.GetAsync<string>("userId");
                if (!storedUserId.Success)
                {
                    await BrowserStorage.SetAsync("userId", userId);
                }
            }
        }
    }
}
