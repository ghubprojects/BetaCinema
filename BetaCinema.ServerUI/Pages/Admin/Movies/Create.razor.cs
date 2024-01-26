using BetaCinema.Application.Features.Categories.Commands;
using BetaCinema.Application.Features.Movies.Commands;
using BetaCinema.Domain.Models;
using BetaCinema.ServerUI.Components.Dialog;
using BetaCinema.ServerUI.Resources;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Movies
{
    public class CreateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        public Movie MovieData { get; set; } = new();

        protected List<Category> CategoryList { get; set; } = new();

        protected string categoriesValue = "";
        protected IEnumerable<string> categoryOptions { get; set; } = new HashSet<string>() { };

        protected override async Task OnParametersSetAsync()
        {
            MovieData = new Movie() { DeleteFlag = false };
            CategoryList = await Mediator.Send(new GetAllCategoriesQuery());
        }

        protected async Task CreateMovie()
        {
            var result = await Mediator.Send(new CreateMovieCommand()
            {
                MovieInfo = MovieData,
                Categories = categoryOptions.ToList()
            });

            if (result.IsSuccess)
            {
                SnackBar.Add("Add new movie successfully", Severity.Success);
                Navigation.NavigateTo("admin/movies");
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
