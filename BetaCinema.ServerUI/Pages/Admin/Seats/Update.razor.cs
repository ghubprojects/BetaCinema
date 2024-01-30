using BetaCinema.Application.Features.Seats.Commands;

namespace BetaCinema.ServerUI.Pages.Admin.Seats
{
    public class UpdateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Parameter] public string SeatId { get; set; }

        public Seat OldData { get; set; } = new();
        public Seat SeatData { get; set; } = new();

        protected async override Task OnParametersSetAsync()
        {
            var result = await Mediator.Send(new GetSeatByIdQuery() { Id = SeatId });

            if (result.IsSuccess)
            {
                SeatData = result.Data;
                OldData = result.Data;
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

        protected async Task SaveChanges()
        {
            var result = await Mediator.Send(new UpdateSeatCommand()
            { Data = SeatData, OldData = OldData });

            if (result.IsSuccess)
            {
                SnackBar.Add(SnackbarResources.UpdateSuccess, Severity.Success);
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
