using BetaCinema.Application.Features.Showtimes.Commands;
using BetaCinema.Application.Features.Showtimes.Queries;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Forms;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Showtimes
{
    public class TableBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        protected List<Showtime>? showtimes = new();

        protected string _searchString;

        // quick filter - filter globally across multiple columns with the same input
        protected Func<Showtime, bool> _quickFilter => x =>
        {
            if (string.IsNullOrWhiteSpace(_searchString))
                return true;

            if (x.Movie.MovieName.Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if (x.Cinema.CinemaName.Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if (x.StartTime.Value.ToString("dd/MM/yyyy HH:mm:ss").Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if ($"{x.Movie.MovieName} {x.Cinema.CinemaName} {x.StartTime.Value.ToString("dd/MM/yyyy HH:mm:ss")}".Contains(_searchString))
                return true;

            return false;
        };

        protected override async Task OnParametersSetAsync()
        {
            showtimes = await Mediator.Send(new GetAllShowtimesQuery());
        }

        protected void NavigateToCreateForm()
        {
            Navigation.NavigateTo("admin/showtimes/create");
        }

        protected async Task Delete(string showtimeId)
        {
            var showtime = showtimes.First(x => x.Id == showtimeId);
            if (await js.InvokeAsync<bool>("confirm", $"Do you want to delete this showtime ?"))
            {
                await Mediator.Send(new DeleteShowtimeCommand() { Id = showtimeId });
                SnackBar.Add("Delete successfully", Severity.Success);
                await OnInitializedAsync();
            }
        }

        protected async Task DownloadExcelFile()
        {
            var excelBytes = await Mediator.Send(new ExportShowtimesToExcelQuery(""));

            // Tạo 1 unique filename cho file excel
            string fileName = $"{typeof(Showtime).Name}_{DateTime.Now:yyyyMMddHHmmss}.xlsx";

            await js.InvokeVoidAsync("saveAsFile", fileName, Convert.ToBase64String(excelBytes));
        }

        protected IList<IBrowserFile> files = new List<IBrowserFile>();

        protected async Task UploadFiles(IBrowserFile file)
        {
            //files.Add(file);

            //if (files.Any())
            //{
            //    var uploadFile = files[0];

            //    var buffer = new byte[uploadFile.Size];
            //    var extension = Path.GetExtension(uploadFile.Name);
            //    await uploadFile.OpenReadStream(uploadFile.Size).ReadAsync(buffer);

            //    var importRequest = new ImportRequest
            //    {
            //        Data = buffer,
            //        FileName = uploadFile.Name,
            //        UploadType = UploadType.Document,
            //        Extension = extension
            //    };

            //    var result = await Mediator.Send(new ImportShowtimesFromExcelCommand()
            //    { ImportRequest = importRequest });

            //    if (result.IsSuccess)
            //    {
            //        SnackBar.Add("Import successfully", Severity.Success);
            //        Navigation.NavigateTo("admin/showtimes", true);
            //    }
            //    else
            //    {
            //        DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
            //            new DialogParameters<ErrorMessageDialog>
            //            {
            //                { x => x.ContentText, result.Message },
            //                { x => x.ButtonText, SharedResources.Close },
            //                { x => x.Color, Color.Error }
            //            }, new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
            //    }

            //    files.Clear();
            //}
        }
    }
}
