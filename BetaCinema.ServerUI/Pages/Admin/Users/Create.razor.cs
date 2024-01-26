using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.Domain.Enums;
using BetaCinema.Domain.Models;
using BetaCinema.ServerUI.Components.Dialog;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Identity;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Users
{
    public class CreateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected SignInManager<User> SignInManager { get; set; }

        [Inject] protected UserManager<User> UserManager { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        public User UserData { get; set; } = new();

        protected async override Task OnParametersSetAsync()
        {
            await Task.Run(() =>
            {
                UserData = new User()
                {
                    Role = UserRole.Customer.ToString(),
                    DeleteFlag = false
                };
            });
        }

        protected async Task CreateUser()
        {
            var result = await Mediator.Send(new CreateUserCommand() { Data = UserData });

            if (result.IsSuccess)
            {
                SnackBar.Add("Add new user successfully", Severity.Success);
                Navigation.NavigateTo("admin/users");
            }
            else
            {
                var parameters = new DialogParameters<ErrorMessageDialog>
                {
                    { x => x.ContentText, result.Message },
                    { x => x.ButtonText, "Close" },
                    { x => x.Color, Color.Error }
                };

                var options = new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall };

                DialogService.Show<ErrorMessageDialog>("Lỗi", parameters, options);
            }
        }
    }
}
