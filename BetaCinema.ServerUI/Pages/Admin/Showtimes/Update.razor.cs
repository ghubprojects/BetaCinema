using BetaCinema.Application.Features.Showtimes.Commands;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Showtimes
{
    public class UpdateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Parameter] public string ShowtimeId { get; set; }

        public Showtime ShowtimeData { get; set; } = new();

        protected async override Task OnParametersSetAsync()
        {
            ShowtimeData = await Mediator.Send(new GetShowtimeByIdQuery() { Id = ShowtimeId });
        }

        protected async Task SaveChanges()
        {
            await Mediator.Send(new UpdateShowtimeCommand() { Data = ShowtimeData });

            SnackBar.Add("Update successfully", Severity.Success);
            Navigation.NavigateTo("admin/showtimes");
        }
    }
}
