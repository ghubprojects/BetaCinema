using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Users
{
    public class TableDataBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        protected List<User>? users;

        protected override async Task OnInitializedAsync()
        {
            users = await Mediator.Send(new GetAllUsersQuery());
        }

        protected void NavigateToCreateForm()
        {
            Navigation.NavigateTo("users/create");
        }

        protected async Task Delete(string userId)
        {
            var user = users.First(x => x.Id == userId);
            if (await js.InvokeAsync<bool>("confirm", $"Do you want to delete User <{user.Fullname}>?"))
            {
                await Mediator.Send(new DeleteUserCommand() { Id = userId });
                SnackBar.Configuration.PositionClass = Defaults.Classes.Position.BottomRight;
                SnackBar.Add("Delete successfully", Severity.Success, config =>
                {
                    config.VisibleStateDuration = 3000;
                    config.HideTransitionDuration = 300;
                    config.ShowTransitionDuration = 300;
                    config.SnackbarVariant = Variant.Filled;
                });
                await OnInitializedAsync();
            }
        }
    }

}
