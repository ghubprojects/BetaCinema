using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Users
{
    public class UpdateFormBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Parameter]
        public string userId { get; set; }

        protected User user = new();

        protected async override Task OnParametersSetAsync()
        {
            user = await Mediator.Send(new GetUserByIdQuery() { Id = userId });
        }

        protected async Task EditUser()
        {
            await Mediator.Send(new UpdateUserCommand() { Data = user });

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
