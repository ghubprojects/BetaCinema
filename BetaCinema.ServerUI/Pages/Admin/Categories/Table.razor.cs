using BetaCinema.Application.Features.Categories.Commands;
using BetaCinema.Application.Features.Categories.Queries;
using BetaCinema.Application.Features.Categorys.Commands;
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

namespace BetaCinema.ServerUI.Pages.Admin.Categories
{
    public class TableBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        protected List<Category>? categories;

        protected override async Task OnInitializedAsync()
        {
            categories = await Mediator.Send(new GetAllCategoriesQuery());
        }

        protected void NavigateToCreateForm()
        {
            Navigation.NavigateTo("admin/categories/create");
        }

        protected async Task Delete(string categoryId)
        {
            var category = categories.First(x => x.Id == categoryId);
            if (await js.InvokeAsync<bool>("confirm", $"Do you want to delete Category {category.CategoryName}>?"))
            {
                await Mediator.Send(new DeleteCategoryCommand() { Id = categoryId });
                SnackBar.Add("Delete successfully", Severity.Success);
                await OnInitializedAsync();
            }
        }

        protected async Task DownloadExcelFile()
        {
            var excelBytes = await Mediator.Send(new ExportCategoriesToExcelQuery(""));

            // Tạo 1 unique filename cho file excel
            string fileName = $"{typeof(Category).Name}_{DateTime.Now:yyyyMMddHHmmss}.xlsx";

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

                var result = await Mediator.Send(new ImportCategoriesFromExcelCommand()
                { ImportRequest = importRequest });

                if (result.IsSuccess)
                {
                    SnackBar.Add("Import successfully", Severity.Success);
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

                files.Clear();
            }
        }
    }
}
