using Microsoft.AspNetCore.WebUtilities;

namespace BetaCinema.ServerUI.Pages.Movies.Components
{
    public class MovieItemBase : ComponentBase
    {
        [Inject] IDialogService DialogService { get; set; }

        [Parameter] public Movie MovieData { get; set; }

        protected string uri { get; set; }

        protected override void OnInitialized()
        {
            var query = new Dictionary<string, string> { { "id", MovieData.Id } };

            uri = QueryHelpers.AddQueryString("/movie-detail", query);
        }

        protected void ShowDialogShowtime()
        {
            DialogService.Show<ShowtimeDialog>("",
                new DialogParameters<ShowtimeDialog>
                { { x => x.MovieData, MovieData} },
                new DialogOptions()
                { MaxWidth = MaxWidth.Large, CloseButton = true, });
        }
    }
}
