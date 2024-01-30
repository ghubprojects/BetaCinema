using BetaCinema.Application.Features.Cinemas.Commands;
using BetaCinema.Application.Features.Cinemas.Queries;
using BetaCinema.Application.Requests;
using Microsoft.AspNetCore.Components.Forms;

namespace BetaCinema.ServerUI.Pages.Admin.Cinemas
{
    public class TableBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        protected List<Cinema>? cinemas;

        protected string _searchString;

        // quick filter - filter globally across multiple columns with the same input
        protected Func<Cinema, bool> _quickFilter => x =>
        {
            if (string.IsNullOrWhiteSpace(_searchString))
                return true;

            if (x.CinemaName.Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if (x.CinemaLocation.Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if ($"{x.CinemaName} {x.CinemaLocation}".Contains(_searchString))
                return true;

            return false;
        };

        protected override async Task OnInitializedAsync()
        {
            var result = await Mediator.Send(new GetAllCinemasQuery());

            if (result.IsSuccess)
            {
                cinemas = result.Data;
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

        protected async Task Delete(string cinemaId)
        {
            var cinema = cinemas.First(x => x.Id == cinemaId);

            var dialog = DialogService.Show<DeleteConfirmation>(DialogResources.DeleteTitle, new DialogParameters<DeleteConfirmation>
            {
                { x => x.Command,  new DeleteCinemaCommand() { Id = cinemaId } },
                { x => x.ContentText, string.Format(DialogResources.ConfirmDelete, CinemaResources.CinemaName,cinema.CinemaName ) }
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
            var excelBytes = await Mediator.Send(new ExportCinemasToExcelQuery(""));

            // Tạo 1 unique filename cho file excel
            string fileName = $"{typeof(Cinema).Name}_{DateTime.Now:yyyyMMddHHmmss}.xlsx";

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

                var result = await Mediator.Send(new ImportCinemasFromExcelCommand()
                { ImportRequest = importRequest });

                if (result.IsSuccess)
                {
                    SnackBar.Add(SnackbarResources.ImportSuccess, Severity.Success);
                    await OnInitializedAsync();
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
