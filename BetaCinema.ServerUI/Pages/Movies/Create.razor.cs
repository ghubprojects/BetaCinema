using BetaCinema.Application.Features.Movies.Commands;
using BetaCinema.Domain.Models;
using BetaCinema.ServerUI.Components.Dialog;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Movies
{
    public class CreateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Parameter]
        public Movie MovieData { get; set; }

        protected async override Task OnParametersSetAsync()
        {
            await Task.Run(() =>
            {
                MovieData = new Movie()
                {
                    DeleteFlag = false
                };
            });
        }

        protected async Task CreateMovie()
        {
            var result = await Mediator.Send(new CreateMovieCommand() { Data = MovieData });

            if (result.IsSuccess)
            {
                SnackBar.Configuration.PositionClass = Defaults.Classes.Position.BottomRight;
                SnackBar.Add("Add new movie successfully", Severity.Success, config =>
                {
                    config.VisibleStateDuration = 3000;
                    config.HideTransitionDuration = 300;
                    config.ShowTransitionDuration = 300;
                    config.SnackbarVariant = Variant.Filled;
                });
                Navigation.NavigateTo("movies");
            }
            else
            {
                var parameters = new DialogParameters<ErrorMessageDialog>
                {
                    { x => x.ContentText, result.Error },
                    { x => x.ButtonText, "Close" },
                    { x => x.Color, Color.Error }
                };

                var options = new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall };

                DialogService.Show<ErrorMessageDialog>("Lỗi", parameters, options);
            }
        }
    }
}
