using BetaCinema.Application.Features.Movies.Commands;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Components.Server.ProtectedBrowserStorage;
using Microsoft.AspNetCore.WebUtilities;
using Microsoft.Extensions.Primitives;

namespace BetaCinema.ServerUI.Pages.Detail
{
    public class MovieDetailBase : ComponentBase
    {
        [Inject] private IMediator Mediator { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected AuthenticationStateProvider AuthenticationStateProvider { get; set; }

        [Inject] protected ProtectedLocalStorage BrowserStorage { get; set; }

        protected Movie MovieData { get; set; } = new();

        /// <summary>
        /// Get movie data by movie id from query string
        /// </summary>
        /// <returns></returns>
        protected async override Task OnInitializedAsync()
        {
            var uri = Navigation.ToAbsoluteUri(Navigation.Uri);
            if (QueryHelpers.ParseQuery(uri.Query).TryGetValue("id", out StringValues id))
            {
                var result = await Mediator.Send(new GetMovieByIdQuery()
                { Id = Convert.ToString(id) });

                if (result.IsSuccess)
                {
                    MovieData = result.Data;
                }
                else
                {
                    DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
                        new DialogParameters<ErrorMessageDialog>
                        {
                            { x => x.ContentText, result.Message },
                        }, new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
                }
            }
        }

        /// <summary>
        /// Check and update user id if the user is logged in
        /// </summary>
        /// <returns></returns>
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
