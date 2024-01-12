using Microsoft.AspNetCore.Components;

namespace BetaCinema.ServerUI.Pages.Movies.Components
{
    public class MovieItemBase : ComponentBase
    {
        [Parameter]
        public MovieItem movieData { get; set; }
    }
}
