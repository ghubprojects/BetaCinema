using BetaCinema.Application.Features.Cinemas.Commands;
using BetaCinema.Application.Features.Movies.Commands;
using BetaCinema.Application.Features.Showtimes.Commands;

namespace BetaCinema.ServerUI.Pages.Admin.Showtimes
{
    public class UpdateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Parameter] public string ShowtimeId { get; set; }

        public Showtime OldData { get; set; } = new();
        public Showtime ShowtimeData { get; set; } = new();

        public List<Movie>? movies { get; set; } = new();
        public List<Cinema>? cinemas { get; set; } = new();

        protected DateTime? showDate = DateTime.Now;
        protected TimeSpan? startTime = new TimeSpan(09, 00, 00);

        protected async override Task OnParametersSetAsync()
        {
            await GetAllMovies();
            await GetAllCinemas();

            var result = await Mediator.Send(new GetShowtimeByIdQuery() { Id = ShowtimeId });

            if (result.IsSuccess)
            {
                ShowtimeData = result.Data;
                OldData = result.Data;
                showDate = ShowtimeData.StartTime.Value.Date;
                startTime = ShowtimeData.StartTime.Value.TimeOfDay;
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

        protected async Task SaveChanges()
        {
            ShowtimeData.StartTime = showDate.Value.Date + startTime.Value;
            var result = await Mediator.Send(new UpdateShowtimeCommand()
            { Data = ShowtimeData, OldData = OldData });

            if (result.IsSuccess)
            {
                SnackBar.Add(SnackbarResources.UpdateSuccess, Severity.Success);
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
    }
}
