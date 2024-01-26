using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Models;
using BetaCinema.ServerUI.Components.Dialog;
using BetaCinema.ServerUI.Resources;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Components.Forms;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Member
{
    public class MemberBase : ComponentBase
    {
        [Inject] private AuthenticationStateProvider AuthenticationStateProvider { get; set; }

        [Inject] private IConfiguration Configuration { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        public string UserId { get; set; }

        public User UserData { get; set; }

        private async Task<string> RetrieveUserId()
        {
            var user = (await AuthenticationStateProvider.GetAuthenticationStateAsync()).User;
            var id = user.FindFirst(u => u.Type.Contains("nameidentifier"))?.Value;
            return id;
        }

        protected override void OnInitialized()
        {
            UserData = new User();
        }

        protected override async Task OnParametersSetAsync()
        {

            var result = await Mediator.Send(new GetUserByIdQuery() { Id = await RetrieveUserId() });

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

        protected async Task SaveChanges()
        {
            await Mediator.Send(new UpdateUserCommand() { Data = UserData });

            SnackBar.Add("Update successfully", Severity.Success);
        }

        /// <summary>
        /// Upload Avatar
        /// </summary>

        protected IList<IBrowserFile> files = new List<IBrowserFile>();

        protected async Task UploadAvatar(IBrowserFile avatarFile)
        {
            files.Add(avatarFile);

            if (files.Any())
            {
                var uploadRequest = new UploadRequest()
                {
                    MaxFileSize = 1024 * 1024 * 3,
                    UploadedFiles = files
                };

                var result = await Mediator.Send(new UploadAvatarUserCommand()
                {
                    UserData = UserData,
                    UploadRequest = uploadRequest
                });

                if (result.IsSuccess)
                {
                    SnackBar.Add("Upload avatar successfully", Severity.Success);
                }
            }

            files.Clear();
        }
    }
}
