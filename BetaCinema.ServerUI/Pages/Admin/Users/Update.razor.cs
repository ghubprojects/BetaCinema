using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.Domain.Models;
using BetaCinema.ServerUI.Components.Dialog;
using BetaCinema.ServerUI.Resources;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Users
{
    public class UpdateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Parameter] public string UserId { get; set; }

        public User UserData { get; set; } = new();

        protected async override Task OnParametersSetAsync()
        {
            var result = await Mediator.Send(new GetUserByIdQuery() { Id = UserId });
            if (result.IsSuccess)
            {
                UserData = result.Data;
            }
            else
            {
                DialogService.Show<ErrorMessageDialog>("Lỗi", new DialogParameters<ErrorMessageDialog>
                {
                    { x => x.ContentText, result.Message },
                    { x => x.ButtonText, SharedResources.Close },
                    { x => x.Color, Color.Error }
                }, new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
            }
        }

        protected async Task SaveUser()
        {
            await Mediator.Send(new UpdateUserCommand() { Data = UserData });

            SnackBar.Add("Update successfully", Severity.Success);
            Navigation.NavigateTo("admin/users");
        }
    }
}
