using BetaCinema.Application.Features.Movies.Commands;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Components;

namespace BetaCinema.ServerUI.Pages.Movies.Components
{
    public class MoviesNavbarBase : ComponentBase
    {
        [Inject] private IMediator Mediator { get; set; }

        protected int activeTabIndex = 1;

        protected List<Movie>? comingMovies = new();

        protected List<Movie>? showingMovies = new();

        protected override async Task OnParametersSetAsync()
        {
            showingMovies = await Mediator.Send(new GetShowingMoviesQuery());
        }

        protected async Task GetShowingMovies()
        {
            showingMovies = await Mediator.Send(new GetShowingMoviesQuery());
        }

        protected async Task GetComingMovies()
        {
            comingMovies = await Mediator.Send(new GetComingMoviesQuery());
        }
    }
}
