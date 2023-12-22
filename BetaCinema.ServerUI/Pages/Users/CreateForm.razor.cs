using BetaCinema.Domain.Enums;
using BetaCinema.Domain.Models;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Identity;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Users
{
    public class CreateFormBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] protected SignInManager<User> SignInManager { get; set; }

        [Inject] protected UserManager<User> UserManager { get; set; }

        protected User userData = new();

        protected async Task CreateUser()
        {
            var user = new User
            {
                UserName = userData.Email,
                Email = userData.Email,
                Fullname = userData.Email,
                Role = userData.Role.ToString() ?? UserRole.Customer.ToString(),
                DeleteFlag = false,
                Password = userData.Password,
            };

            var addUserResult = await UserManager.CreateAsync(user, user.Password);
            var addUserRoleResult = await UserManager.AddToRoleAsync(user, user.Role.ToString());

            if (addUserResult.Succeeded && addUserRoleResult.Succeeded)
            {
                SnackBar.Configuration.PositionClass = Defaults.Classes.Position.BottomRight;
                SnackBar.Add("Add new user successfully", Severity.Success, config =>
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
}
