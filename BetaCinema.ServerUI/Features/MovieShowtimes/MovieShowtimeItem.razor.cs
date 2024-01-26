using BetaCinema.Domain.Models;
using BetaCinema.ServerUI.Components.Dialog;
using BetaCinema.ServerUI.Resources;
using Microsoft.AspNetCore.Components;
using MudBlazor;

namespace BetaCinema.ServerUI.Features.MovieShowtimes
{
    public class MovieShowtimeItemBase : ComponentBase
    {
        [Inject] IDialogService DialogService { get; set; }

        [Parameter] public Showtime ShowtimeData { get; set; } = new();

        [Parameter] public bool IsFullWidth { get; set; }

        protected string ShowtimeClass { get => IsFullWidth ? "showtime fullwidth" : "showtime"; }

        protected void ShowConfirmShowtimeDialog()
        {
            DialogService.Show<ConfirmShowtimeDialog>($"Bạn đang đặt vé xem phim".ToUpper(),
                new DialogParameters<ConfirmShowtimeDialog>
                {
                    { x => x.ButtonText, SharedResources.Agree },
                    { x => x.ShowtimeData, ShowtimeData },
                }, new DialogOptions()
                {
                    MaxWidth = MaxWidth.Medium,
                    CloseButton = true,
                });
        }
    }
}
