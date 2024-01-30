using BetaCinema.Application.Features.Payments.Commands;
using BetaCinema.Application.Features.Payments.Queries;

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
            var result = await Mediator.Send(new GetAllPaymentsQuery());

            if (result.IsSuccess)
            {
                payments = result.Data;
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

        protected async Task DownloadExcelFile()
        {
            var excelBytes = await Mediator.Send(new ExportPaymentsToExcelQuery(""));

            // Tạo 1 unique filename cho file excel
            string fileName = $"{typeof(Payment).Name}_{DateTime.Now:yyyyMMddHHmmss}.xlsx";

            await js.InvokeVoidAsync("saveAsFile", fileName, Convert.ToBase64String(excelBytes));
        }
    }
}
