using BetaCinema.Application.Features.Seats.Commands;

namespace BetaCinema.ServerUI.Features.MovieShowtimes
{
    public class MovieShowtimeItemBase : ComponentBase
    {
        [Inject] private IMediator Mediator { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Parameter] public Showtime ShowtimeData { get; set; } = new();

        [Parameter] public bool IsFullWidth { get; set; }

        protected int unsoldSeats { get; set; } = 0;
        protected int totalSeats { get; set; } = 0;


        protected string ShowtimeClass { get => IsFullWidth ? "showtime fullwidth" : "showtime"; }

        protected override async Task OnInitializedAsync()
        {
            // get total seat

            var result = await Mediator.Send(new GetAllSeatsQuery());

            if (result.IsSuccess)
            {
                totalSeats = result.Data.Count;
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

        protected override void OnParametersSet()
        {
            var soldSeats = ShowtimeData.Reservations
                .SelectMany(r => r.ReservationItems)
                .Select(ri => ri.Seat)
                .ToList().Count;

            unsoldSeats = totalSeats - soldSeats;
        }

        protected void ShowConfirmShowtimeDialog()
        {
            DialogService.Show<ConfirmShowtimeDialog>($"Bạn đang đặt vé xem phim".ToUpper(),
                new DialogParameters<ConfirmShowtimeDialog>
                {
                    { x => x.ButtonText, SharedResources.Agree },
                    { x => x.ShowtimeData, ShowtimeData },
                }, new DialogOptions()
                {
                    MaxWidth = MaxWidth.Medium,
                    CloseButton = true,
                });
        }
    }
}
