using BetaCinema.Application.Features.Categories.Commands;
using BetaCinema.Application.Features.Movies.Commands;
using BetaCinema.Application.Requests;
using Microsoft.AspNetCore.Components.Forms;

namespace BetaCinema.ServerUI.Pages.Admin.Movies
{
    public class CreateBase : ComponentBase
    {
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

            var result = await Mediator.Send(new GetAllCategoriesQuery());

            if (result.IsSuccess)
            {
                CategoryList = result.Data;
            }
            else
            {
                DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
                    new DialogParameters<ErrorMessageDialog>
                    { { x => x.ContentText, result.Message } },
                    new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
            }
        }

        protected async Task CreateMovie()
        {
            var result = await Mediator.Send(new CreateMovieCommand()
            {
                Data = MovieData,
                Categories = categoryOptions.ToList()
            });

            if (result.IsSuccess)
            {
                SnackBar.Add(SnackbarResources.AddSuccess, Severity.Success);
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
                { UploadRequest = uploadRequest });

                if (result.IsSuccess)
                {
                    MovieData.Poster = result.Data;
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
