using BetaCinema.Application.Features.Categories.Commands;
using BetaCinema.Application.Features.Movies.Commands;
using BetaCinema.Application.Requests;
using Microsoft.AspNetCore.Components.Forms;

namespace BetaCinema.ServerUI.Pages.Admin.Movies
{
    public class UpdateBase : ComponentBase
    {
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
            // Get Movie Data
            var movieResult = await Mediator.Send(new GetMovieByIdQuery() { Id = MovieId });

            if (movieResult.IsSuccess)
            {
                MovieData = movieResult.Data;
                OldData = movieResult.Data;
                categoryOptions = MovieData.MovieCategories.Select(mc => mc.Category.CategoryName);
            }
            else
            {
                DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
                    new DialogParameters<ErrorMessageDialog>
                    {
                        { x => x.ContentText, movieResult.Message },
                    }, new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
            }

            // Get Categories
            var categoryResult = await Mediator.Send(new GetAllCategoriesQuery());

            if (categoryResult.IsSuccess)
                CategoryList = categoryResult.Data;
            else
                DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
                    new DialogParameters<ErrorMessageDialog>
                    { { x => x.ContentText, categoryResult.Message } },
                    new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
        }

        protected async Task SaveChanges()
        {
            var result = await Mediator.Send(new UpdateMovieCommand()
            {
                Data = MovieData,
                OldData = OldData,
                Categories = categoryOptions.ToList()
            });

            if (result.IsSuccess)
            {
                SnackBar.Add(SnackbarResources.UpdateSuccess, Severity.Success);
                Navigation.NavigateTo("admin/movies");
            }
            else
            {
                DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
                    new DialogParameters<ErrorMessageDialog>
                    {
                        { x => x.ContentText, result.Message },
                    }, new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
            }
        }

        /// <summary>
        /// Upload Poster
        /// </summary>

        protected IList<IBrowserFile> files = new List<IBrowserFile>();

        protected async Task UploadPoster(IBrowserFile file)
        {
            files.Add(file);

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
                    SnackBar.Add(SnackbarResources.UploadSuccess, Severity.Success);
                }
                else
                {
                    DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
                        new DialogParameters<ErrorMessageDialog>
                        {
                            { x => x.ContentText, result.Message },
                        }, new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
                }
            }

            files.Clear();
        }
    }
}
