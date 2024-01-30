using BetaCinema.Application.Features.Showtimes.Commands;
using BetaCinema.ServerUI.Store.CinemaUseCase;

namespace BetaCinema.ServerUI.Features.MovieShowtimes
{
    public class MovieShowtimesNavigationBarBase : ComponentBase
    {
        [Parameter]
        public Movie MovieData { get; set; } = new();

        [Inject] private IState<CinemaState> CinemaState { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        protected List<Showtime> showtimeList { get; set; } = new();

        public Dictionary<string, DateTime> currentWeekDays { get; set; }

        protected override void OnInitialized()
        {
            currentWeekDays = GetCurrentWeekDays();
        }

        protected override async Task OnParametersSetAsync()
        {
            await GetShowtimes(currentWeekDays.Keys.First());
        }

        protected async Task GetShowtimes(string weekDay)
        {
            var result = await Mediator.Send(new GetShowtimesByWeekDayQuery()
            {
                CinemaId = CinemaState.Value.Cinema.Id,
                MovieId = MovieData.Id,
                ShowDate = currentWeekDays[weekDay]
            });

            if (result.IsSuccess)
            {
                showtimeList = result.Data;
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

        private Dictionary<string, DateTime> GetCurrentWeekDays()
        {
            DateTime currentDate = DateTime.Now;

            // Calculate the start and end dates for the current week
            DateTime startDate = currentDate;
            DateTime endDate = startDate.AddDays(6);

            var weekDays = new Dictionary<string, DateTime>();
            // Build the result string
            for (DateTime date = startDate; date <= endDate; date = date.AddDays(1))
            {
                weekDays.Add(($"{date:dd/MM} - {date:ddd}").Replace("h ", ""), date);
            }

            return weekDays;
        }
    }
}
