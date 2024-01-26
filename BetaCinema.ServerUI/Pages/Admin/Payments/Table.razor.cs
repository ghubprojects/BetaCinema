using BetaCinema.Application.Features.Movies.Queries;
using BetaCinema.Application.Features.Payments.Commands;
using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Forms;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Payments
{
    public class TableBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        protected List<Payment>? payments;

        protected string _searchString;

        // quick filter - filter globally across multiple columns with the same input
        protected Func<Payment, bool> _quickFilter => x =>
        {
            if (string.IsNullOrWhiteSpace(_searchString))
                return true;

            if (x.TotalPrice.ToString().Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if (x.CreatedDate.ToString("dd/MM/yyyy HH:mm:ss").Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            return false;
        };

        protected override async Task OnInitializedAsync()
        {
            payments = await Mediator.Send(new GetAllPaymentsQuery());
        }

        protected async Task Delete(string paymentId)
        {
            var payment = payments.First(x => x.Id == paymentId);
            if (await js.InvokeAsync<bool>("confirm", $"Do you want to delete Movie <{payment.Id}>?"))
            {
                await Mediator.Send(new DeleteUserCommand() { Id = paymentId });
                SnackBar.Add("Delete successfully", Severity.Success);
                await OnInitializedAsync();
            }
        }

        protected async Task DownloadExcelFile()
        {
            var excelBytes = await Mediator.Send(new ExportMoviesToExcelQuery(""));

            // Tạo 1 unique filename cho file excel
            string fileName = $"{typeof(Movie).Name}_{DateTime.Now:yyyyMMddHHmmss}.xlsx";

            await js.InvokeVoidAsync("saveAsFile", fileName, Convert.ToBase64String(excelBytes));
        }

        protected IList<IBrowserFile> files = new List<IBrowserFile>();
    }
}
