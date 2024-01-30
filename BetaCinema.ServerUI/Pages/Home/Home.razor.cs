using BetaCinema.Application.Features.Slides.Queries;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Components.Server.ProtectedBrowserStorage;

namespace BetaCinema.ServerUI.Pages.Home
{
    public class HomeBase : ComponentBase
    {
        [Inject] private IMediator Mediator { get; set; }

        [Inject] protected AuthenticationStateProvider AuthenticationStateProvider { get; set; }

        [Inject] protected ProtectedLocalStorage BrowserStorage { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        protected List<string>? slideNames;

        protected override async Task OnInitializedAsync()
        {
            var result = await Mediator.Send(new GetAllSlidesQuery());

            if (result.IsSuccess)
            {
                slideNames = result.Data;
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
