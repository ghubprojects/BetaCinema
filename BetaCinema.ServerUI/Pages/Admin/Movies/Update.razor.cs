using BetaCinema.Application.Features.Categories.Commands;
using BetaCinema.Application.Features.Movies.Commands;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Models;
using BetaCinema.ServerUI.Components.Dialog;
using BetaCinema.ServerUI.Resources;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Forms;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Movies
{
    public class UpdateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Parameter] public string MovieId { get; set; }

        protected Movie OldData { get; set; } = new();

        protected Movie MovieData { get; set; } = new();

        protected List<Category> CategoryList { get; set; } = new();

        protected string categoriesValue = "";
        protected IEnumerable<string> categoryOptions { get; set; } = new HashSet<string>() { };

        protected async override Task OnParametersSetAsync()
        {
            MovieData = await Mediator.Send(new GetMovieByIdQuery() { Id = MovieId });
            CategoryList = await Mediator.Send(new GetAllCategoriesQuery());
            OldData = MovieData;
            categoryOptions = MovieData.MovieCategories.Select(mc => mc.Category.CategoryName);
        }

        protected async Task SaveChanges()
        {
            var result = await Mediator.Send(new UpdateMovieCommand()
            {
                OldData = OldData,
                MovieInfo = MovieData,
                Categories = categoryOptions.ToList()
            });

            if (result.IsSuccess)
            {
                SnackBar.Add("Update successfully", Severity.Success);
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

        /// <summary>
        /// Upload Poster
        /// </summary>

        protected IList<IBrowserFile> files = new List<IBrowserFile>();

        protected async Task UploadPoster(IBrowserFile imgFile)
        {
            files.Add(imgFile);

            if (files.Any())
            {
                var uploadRequest = new UploadRequest()
                {
                    MaxFileSize = 1024 * 1024 * 3,
                    UploadedFiles = files
                };

                var result = await Mediator.Send(new UploadPosterMovieCommand()
                {
                    MovieData = MovieData,
                    UploadRequest = uploadRequest
                });

                if (result.IsSuccess)
                {
                    SnackBar.Add("Upload poster successfully", Severity.Success);
                }
            }

            files.Clear();
        }
    }
}
