using BetaCinema.Application.Features.Movies.Commands;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Slides
{
    public class UpdateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Parameter]
        public string MovieId { get; set; }

        [Parameter]
        public Movie MovieData { get; set; }

        protected async override Task OnParametersSetAsync()
        {
            MovieData = await Mediator.Send(new GetMovieByIdQuery() { Id = MovieId });
        }

        protected async Task SaveChanges()
        {
            await Mediator.Send(new UpdateMovieCommand() { Data = MovieData });

            SnackBar.Add("Update successfully", Severity.Success);
            Navigation.NavigateTo("movies");
        }
    }
}
