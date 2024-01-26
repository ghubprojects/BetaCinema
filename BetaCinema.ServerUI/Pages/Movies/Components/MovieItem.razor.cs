using BetaCinema.Domain.Models;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.WebUtilities;

namespace BetaCinema.ServerUI.Pages.Movies.Components
{
    public class MovieItemBase : ComponentBase
    {
        [Parameter] public Movie MovieData { get; set; }

        protected string uri { get; set; }

        protected override void OnInitialized()
        {
            var query = new Dictionary<string, string> { { "id", MovieData.Id } };

            uri = QueryHelpers.AddQueryString("/movie-detail", query);
        }
    }
}
