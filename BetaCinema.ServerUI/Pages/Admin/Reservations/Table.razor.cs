using BetaCinema.Application.Features.Reservations.Queries;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Reservations
{
    public class TableBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        protected List<Domain.Models.Reservation>? reservations = new();

        protected string _searchString;

        // quick filter - filter globally across multiple columns with the same input
        protected Func<Domain.Models.Reservation, bool> _quickFilter => x =>
        {
            if (string.IsNullOrWhiteSpace(_searchString))
                return true;

            if (x.User.UserName.Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if (x.Showtime.Movie.MovieName.Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if (x.Showtime.Cinema.CinemaName.Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if (x.Showtime.StartTime.Value.ToString("dd/MM/yyyy HH:mm:ss").Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if ($"{x.User.UserName} {x.Showtime.Movie.MovieName} {x.Showtime.Cinema.CinemaName} {x.Showtime.StartTime.Value.ToString("dd/MM/yyyy HH:mm:ss")}".Contains(_searchString))
                return true;

            return false;
        };

        protected override async Task OnParametersSetAsync()
        {
            reservations = await Mediator.Send(new GetAllReservationsQuery());
        }

        protected void NavigateToCreateForm()
        {
            Navigation.NavigateTo("admin/reservations/create");
        }

        protected async Task DownloadExcelFile()
        {
            //var excelBytes = await Mediator.Send(new ExportReservationsToExcelQuery(""));

            //// Tạo 1 unique filename cho file excel
            //string fileName = $"{typeof(Domain.Models.Reservation).Name}_{DateTime.Now:yyyyMMddHHmmss}.xlsx";

            //await js.InvokeVoidAsync("saveAsFile", fileName, Convert.ToBase64String(excelBytes));
        }
    }
}
