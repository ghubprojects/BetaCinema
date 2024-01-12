using BetaCinema.Application.Features.Seats.Commands;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Seats
{
    public class UpdateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Parameter]
        public string SeatId { get; set; }

        [Parameter]
        public Seat SeatData { get; set; }

        protected async override Task OnParametersSetAsync()
        {
            SeatData = await Mediator.Send(new GetSeatByIdQuery() { Id = SeatId });
        }

        protected async Task SaveChanges()
        {
            await Mediator.Send(new UpdateSeatCommand() { Data = SeatData });

            SnackBar.Add("Update successfully", Severity.Success);
            Navigation.NavigateTo("admin/seats");
        }
    }
}
