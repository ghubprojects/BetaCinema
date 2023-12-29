using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.Application.Features.Users.Queries;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Enums;
using BetaCinema.Domain.Models;
using BetaCinema.ServerUI.Components.Dialog;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Forms;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Users
{
    public class TableBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] IDialogService DialogService { get; set; }

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
            if (await js.InvokeAsync<bool>("confirm", $"Do you want to delete User <{user.FullName}>?"))
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

        protected async Task DownloadExcelFile()
        {
            var excelBytes = await Mediator.Send(new ExportUsersToExcelQuery(""));

            // Tạo 1 unique filename cho file excel
            string fileName = $"{typeof(User).Name}_{DateTime.Now:yyyyMMddHHmmss}.xlsx";

            await js.InvokeVoidAsync("saveAsFile", fileName, Convert.ToBase64String(excelBytes));
        }

        protected IList<IBrowserFile> files = new List<IBrowserFile>();

        protected async Task UploadFiles(IBrowserFile file)
        {
            files.Add(file);

            if (files.Any())
            {
                var uploadFile = files[0];

                var buffer = new byte[uploadFile.Size];
                var extension = Path.GetExtension(uploadFile.Name);
                await uploadFile.OpenReadStream(uploadFile.Size).ReadAsync(buffer);

                var uploadRequest = new UploadRequest
                {
                    Data = buffer,
                    FileName = uploadFile.Name,
                    UploadType = UploadType.Document,
                    Extension = extension
                };

                var result = await Mediator.Send(new ImportUsersFromExcelCommand() { UploadRequest = uploadRequest });

                if (result.IsSuccess)
                {
                    SnackBar.Configuration.PositionClass = Defaults.Classes.Position.BottomRight;
                    SnackBar.Add("Import successfully", Severity.Success, config =>
                    {
                        config.VisibleStateDuration = 3000;
                        config.HideTransitionDuration = 300;
                        config.ShowTransitionDuration = 300;
                        config.SnackbarVariant = Variant.Filled;
                    });
                    Navigation.NavigateTo("users", true);
                }
                else
                {
                    var parameters = new DialogParameters<ErrorMessageDialog>
                {
                    { x => x.ContentText, result.Error },
                    { x => x.ButtonText, "Close" },
                    { x => x.Color, Color.Error }
                };

                    var options = new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall };

                    DialogService.Show<ErrorMessageDialog>("Lỗi", parameters, options);
                }

                files.Clear();
            }
        }
    }
}
