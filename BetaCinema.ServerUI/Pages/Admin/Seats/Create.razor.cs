using BetaCinema.Application.Features.Seats.Commands;
using BetaCinema.Domain.Models;
using BetaCinema.ServerUI.Components.Dialog;
using BetaCinema.ServerUI.Resources;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Seats
{
    public class CreateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Parameter]
        public Seat SeatData { get; set; }

        protected async override Task OnParametersSetAsync()
        {
            await Task.Run(() =>
            {
                SeatData = new Seat()
                {
                    DeleteFlag = false
                };
            });
        }

        protected async Task CreateSeat()
        {
            var result = await Mediator.Send(new CreateSeatCommand() { Data = SeatData });

            if (result.IsSuccess)
            {
                SnackBar.Add("Add new seat successfully", Severity.Success);
                Navigation.NavigateTo("admin/seats");
            }
            else
            {
                DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
                    new DialogParameters<ErrorMessageDialog>
                    {
                        { x => x.ContentText, result.Message },
                        { x => x.ButtonText, SharedResources.Close },
                        { x => x.Color, Color.Error }
                    }, new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
            }
        }
    }
}
