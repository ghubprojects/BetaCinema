using BetaCinema.Application.Features.Showtimes.Commands;
using BetaCinema.Domain.Models;
using BetaCinema.ServerUI.Components.Dialog;
using BetaCinema.ServerUI.Resources;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Showtimes
{
    public class CreateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        public Showtime ShowtimeData { get; set; } = new();

        protected override void OnParametersSet()
        {
            ShowtimeData = new Showtime() { DeleteFlag = false };
        }

        protected async Task CreateShowtime()
        {
            var result = await Mediator.Send(new CreateShowtimeCommand() { Data = ShowtimeData });

            if (result.IsSuccess)
            {
                SnackBar.Add("Add new showtime successfully", Severity.Success);
                Navigation.NavigateTo("admin/showtimes");
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
