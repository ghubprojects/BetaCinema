using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.Application.Requests;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Components.Forms;

namespace BetaCinema.ServerUI.Pages.Member
{
    public class MemberBase : ComponentBase
    {
        [Inject] private AuthenticationStateProvider AuthenticationStateProvider { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] private IConfiguration Configuration { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        public string UserId { get; set; }

        public User UserData { get; set; }

        protected User OldData { get; set; } = new();

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
                OldData = result.Data;
            }
            else
            {
                DialogService.Show<ErrorMessageDialog>("Lỗi", new DialogParameters<ErrorMessageDialog>
                {
                    { x => x.ContentText, result.Message },
                }, new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
            }
        }

        protected async Task SaveChanges()
        {
            var result = await Mediator.Send(new UpdateUserCommand()
            {
                Data = UserData,
                OldData = OldData,
            });

            if (result.IsSuccess)
            {
                SnackBar.Add(SnackbarResources.UpdateSuccess, Severity.Success);
                Navigation.NavigateTo("member", true);
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

        /// <summary>
        /// Upload Avatar
        /// </summary>

        protected IList<IBrowserFile> files = new List<IBrowserFile>();
        private readonly long maxFileSize = 1024 * 1024 * 3;

        protected async Task UploadAvatar(IBrowserFile avatarFile)
        {
            files.Add(avatarFile);

            if (files.Any())
            {
                var uploadRequest = new UploadRequest()
                {
                    MaxFileSize = maxFileSize,
                    UploadedFiles = files
                };

                if (files.Any(f => f.Size > maxFileSize))
                {
                    DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
                        new DialogParameters<ErrorMessageDialog>
                        {
                            { x => x.ContentText, "Kích cỡ file tối đa là 3MB. Vui lòng kiểm tra lại." },
                        }, new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
                }
                else
                {
                    var result = await Mediator.Send(new UploadAvatarUserCommand()
                    { UploadRequest = uploadRequest });

                    if (result.IsSuccess)
                    {
                        UserData.Avatar = result.Data;
                        SnackBar.Add(SnackbarResources.UploadSuccess, Severity.Success);
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

            files.Clear();
        }
    }
}