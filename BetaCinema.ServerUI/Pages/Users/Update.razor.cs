using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Users
{
    public class UpdateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Parameter]
        public string UserId { get; set; }

        [Parameter]
        public User UserData { get; set; }

        protected async override Task OnParametersSetAsync()
        {
            UserData = await Mediator.Send(new GetUserByIdQuery() { Id = UserId });
        }

        protected async Task SaveUser()
        {
            await Mediator.Send(new UpdateUserCommand() { Data = UserData });

            SnackBar.Configuration.PositionClass = Defaults.Classes.Position.BottomRight;
            SnackBar.Add("Update successfully", Severity.Success, config =>
            {
                config.VisibleStateDuration = 3000;
                config.HideTransitionDuration = 300;
                config.ShowTransitionDuration = 300;
                config.SnackbarVariant = Variant.Filled;
            });
            Navigation.NavigateTo("users");
        }
    }
}
