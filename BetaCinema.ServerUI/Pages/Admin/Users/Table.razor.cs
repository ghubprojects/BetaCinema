using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.Application.Features.Users.Queries;
using BetaCinema.Application.Requests;
using Microsoft.AspNetCore.Components.Forms;

namespace BetaCinema.ServerUI.Pages.Admin.Users
{
    public class TableBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        protected List<User>? users;
        protected HashSet<User> selectedItems = new();

        protected string _searchString;

        // quick filter - filter globally across multiple columns with the same input
        protected Func<User, bool> _quickFilter => x =>
        {
            if (string.IsNullOrWhiteSpace(_searchString))
                return true;

            if (x.UserName.Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if (x.FullName.Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if (x.Email.Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if (x.Role.Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if ($"{x.UserName} {x.FullName} {x.Email} {x.Role}".Contains(_searchString))
                return true;

            return false;
        };

        protected override async Task OnInitializedAsync()
        {
            var result = await Mediator.Send(new GetAllUsersQuery());

            if (result.IsSuccess)
            {
                users = result.Data;
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

        protected async Task Delete(string userId)
        {
            var user = users.First(x => x.Id == userId);

            var dialog = DialogService.Show<DeleteConfirmation>(DialogResources.DeleteTitle, new DialogParameters<DeleteConfirmation>
            {
                { x => x.Command,  new DeleteUserCommand() { Id = userId } },
                { x => x.ContentText, string.Format(DialogResources.ConfirmDelete, UserResources.User,user.FullName ) }
            }, new DialogOptions
            {
                MaxWidth = MaxWidth.ExtraSmall,
                DisableBackdropClick = true
            });

            var state = await dialog.Result;
            if (!state.Canceled)
            {
                await OnInitializedAsync();
            }
        }

        protected async Task DeleteMultiple()
        {
            var dialog = DialogService.Show<DeleteConfirmation>(DialogResources.DeleteTitle, new DialogParameters<DeleteConfirmation>
            {
                { x => x.Command,
                    new DeleteMultipleUsersCommand() { RemovedList = selectedItems.ToList() } },
                { x => x.ContentText, DialogResources.ConfirmDeleteMultiple }
            }, new DialogOptions
            {
                MaxWidth = MaxWidth.ExtraSmall,
                DisableBackdropClick = true
            });

            var state = await dialog.Result;
            if (!state.Canceled)
            {
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

                var importRequest = new ImportRequest
                {
                    Data = buffer,
                    FileName = uploadFile.Name,
                    UploadType = UploadType.Document,
                    Extension = extension
                };

                var result = await Mediator.Send(new ImportUsersFromExcelCommand() { ImportRequest = importRequest });

                if (result.IsSuccess)
                {
                    SnackBar.Add(SnackbarResources.ImportSuccess, Severity.Success);
                    Navigation.NavigateTo("admin/users", true);
                }
                else
                {
                    DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
                        new DialogParameters<ErrorMessageDialog>
                        {
                            { x => x.ContentText, result.Message },
                        }, new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
                }

                files.Clear();
            }
        }
    }
}
