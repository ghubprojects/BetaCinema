using BetaCinema.Application.Features.Movies.Commands;

namespace BetaCinema.ServerUI.Pages.Movies.Components
{
    public class MoviesNavbarBase : ComponentBase
    {
        [Inject] private IMediator Mediator { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        protected int activeTabIndex = 1;

        protected List<Movie>? comingMovies = new();

        protected List<Movie>? showingMovies = new();

        protected override async Task OnParametersSetAsync()
        {
            await GetShowingMovies();
        }

        protected async Task GetShowingMovies()
        {
            var result = await Mediator.Send(new GetShowingMoviesQuery());

            if (result.IsSuccess)
            {
                showingMovies = result.Data;
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

        protected async Task GetComingMovies()
        {
            var result = await Mediator.Send(new GetComingMoviesQuery());

            if (result.IsSuccess)
            {
                comingMovies = result.Data;
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
