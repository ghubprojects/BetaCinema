using BetaCinema.Application.Features.Movies.Commands;
using BetaCinema.Application.Features.Movies.Queries;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Enums;
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
    public class TableBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        protected List<Movie>? movies;

        protected string _searchString;

        // quick filter - filter globally across multiple columns with the same input
        protected Func<Movie, bool> _quickFilter => x =>
        {
            if (string.IsNullOrWhiteSpace(_searchString))
                return true;

            if (x.MovieName.Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if (string.Join(", ", x.MovieCategories.Select(mc => mc.Category.CategoryName)).Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            if (x.ReleaseDate.Value.ToString("dd/MM/yyyy").Contains(_searchString, StringComparison.OrdinalIgnoreCase))
                return true;

            return false;
        };

        protected override async Task OnInitializedAsync()
        {
            movies = await Mediator.Send(new GetAllMoviesQuery());
        }

        protected void NavigateToCreateForm()
        {
            Navigation.NavigateTo("admin/movies/create");
        }

        protected async Task Delete(string movieId)
        {
            var movie = movies.First(x => x.Id == movieId);
            if (await js.InvokeAsync<bool>("confirm", $"Do you want to delete Movie <{movie.MovieName}>?"))
            {
                var result = await Mediator.Send(new DeleteMovieCommand() { Id = movieId });

                if (result.IsSuccess)
                {
                    SnackBar.Add("Delete successfully", Severity.Success);
                    await OnInitializedAsync();
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

        protected async Task DownloadExcelFile()
        {
            var excelBytes = await Mediator.Send(new ExportMoviesToExcelQuery(""));

            // Tạo 1 unique filename cho file excel
            string fileName = $"{typeof(Movie).Name}_{DateTime.Now:yyyyMMddHHmmss}.xlsx";

            await js.InvokeVoidAsync("saveAsFile", fileName, Convert.ToBase64String(excelBytes));
        }

        protected IList<IBrowserFile> files = new List<IBrowserFile>();

        protected async Task UploadFiles(IBrowserFile file)
        {
            files.Add(file);

            if (files.Any())
            {
                var uploadFile = files[0];

                var buffer = new byte[uploadFile.Size];
                var extension = Path.GetExtension(uploadFile.Name);
                await uploadFile.OpenReadStream(uploadFile.Size).ReadAsync(buffer);

                var importRequest = new ImportRequest
                {
                    Data = buffer,
                    FileName = uploadFile.Name,
                    UploadType = UploadType.Document,
                    Extension = extension
                };

                var result = await Mediator.Send(new ImportMoviesFromExcelCommand()
                { ImportRequest = importRequest });

                if (result.IsSuccess)
                {
                    SnackBar.Add("Import successfully", Severity.Success);
                    Navigation.NavigateTo("admin/movies", true);
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

                files.Clear();
            }
        }
    }
}
