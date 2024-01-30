using BetaCinema.Application.Features.Seats.Commands;

namespace BetaCinema.ServerUI.Pages.Admin.Seats
{
    public class CreateBase : ComponentBase
    {
        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        public Seat SeatData { get; set; } = new();

        protected async override Task OnParametersSetAsync()
        {
            await Task.Run(() =>
            {
                SeatData = new Seat()
                {
                    DeleteFlag = false
                };
            });
        }

        protected async Task CreateSeat()
        {
            var result = await Mediator.Send(new CreateSeatCommand() { Data = SeatData });

            if (result.IsSuccess)
            {
                SnackBar.Add(SnackbarResources.AddSuccess, Severity.Success);
                Navigation.NavigateTo("admin/seats");
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
}
