using BetaCinema.Application.Features.Cinemas.Commands;
using BetaCinema.Application.Features.Movies.Commands;
using BetaCinema.Application.Features.Showtimes.Commands;

namespace BetaCinema.ServerUI.Pages.Admin.Showtimes
{
    public class CreateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        public List<Movie>? movies { get; set; } = new();
        public List<Cinema>? cinemas { get; set; } = new();

        public Showtime ShowtimeData { get; set; } = new();

        protected DateTime? showDate = DateTime.Now;
        protected TimeSpan? startTime = new TimeSpan(09, 00, 00);

        protected override async Task OnParametersSetAsync()
        {
            ShowtimeData = new Showtime() { DeleteFlag = false };
            await GetAllMovies();
            await GetAllCinemas();
        }

        protected async Task CreateShowtime()
        {
            ShowtimeData.StartTime = showDate.Value.Date + startTime.Value;
            var result = await Mediator.Send(new CreateShowtimeCommand() { Data = ShowtimeData });

            if (result.IsSuccess)
            {
                SnackBar.Add(SnackbarResources.AddSuccess, Severity.Success);
                Navigation.NavigateTo("admin/showtimes");
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

        private async Task GetAllMovies()
        {
            var result = await Mediator.Send(new GetAllMoviesQuery());

            if (result.IsSuccess)
            {
                movies = result.Data;
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

        protected async Task GetAllCinemas()
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
    }
}
