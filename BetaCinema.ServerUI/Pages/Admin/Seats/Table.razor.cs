using BetaCinema.Application.Features.Seats.Commands;
using BetaCinema.Application.Features.Seats.Queries;
using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.Application.Requests;
using Microsoft.AspNetCore.Components.Forms;

namespace BetaCinema.ServerUI.Pages.Admin.Seats
{
    public class TableBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        protected List<Seat>? seats;

        protected override async Task OnInitializedAsync()
        {
            var result = await Mediator.Send(new GetAllSeatsQuery());

            if (result.IsSuccess)
            {
                seats = result.Data;
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

        protected async Task Delete(string seatId)
        {
            var seat = seats.First(x => x.Id == seatId);

            var dialog = DialogService.Show<DeleteConfirmation>(DialogResources.DeleteTitle, new DialogParameters<DeleteConfirmation>
            {
                { x => x.Command,  new DeleteSeatCommand() { Id = seatId } },
                { x => x.ContentText, string.Format(DialogResources.ConfirmDelete, SeatResources.Seat,$"{seat.RowNum}{seat.SeatNum}" ) }
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
            var excelBytes = await Mediator.Send(new ExportSeatsToExcelQuery(""));

            // Tạo 1 unique filename cho file excel
            string fileName = $"{typeof(Seat).Name}_{DateTime.Now:yyyyMMddHHmmss}.xlsx";

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

                var result = await Mediator.Send(new ImportUsersFromExcelCommand()
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
