using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Users
{
    public class CreateFormBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        protected User user = new();

        protected async Task CreateUser()
        {
            await Mediator.Send(new CreateUserCommand() { Data = user });

            SnackBar.Configuration.PositionClass = Defaults.Classes.Position.BottomRight;
            SnackBar.Add("Add successfully", Severity.Success, config =>
            {
                config.VisibleStateDuration = 3000;
                config.HideTransitionDuration = 300;
                config.ShowTransitionDuration = 300;
                config.SnackbarVariant = Variant.Filled;
            });
            Navigation.NavigateTo("user");
        }
    }
}
