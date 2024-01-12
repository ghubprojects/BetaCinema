using BetaCinema.Application.Features.Cinemas.Commands;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Cinemas
{
    public class UpdateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Parameter]
        public string CinemaId { get; set; }

        [Parameter]
        public Cinema CinemaData { get; set; }

        protected async override Task OnParametersSetAsync()
        {
            CinemaData = await Mediator.Send(new GetCinemaByIdQuery() { Id = CinemaId });
        }

        protected async Task SaveChanges()
        {
            await Mediator.Send(new UpdateCinemaCommand() { Data = CinemaData });

            SnackBar.Add("Update successfully", Severity.Success);
            Navigation.NavigateTo("admin/cinemas");
        }
    }
}
