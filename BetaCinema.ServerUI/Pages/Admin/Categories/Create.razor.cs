using BetaCinema.Application.Features.Categories.Commands;

namespace BetaCinema.ServerUI.Pages.Admin.Categories
{
    public class CreateBase : ComponentBase
    {
        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        public Category CategoryData { get; set; } = new();

        protected async override Task OnParametersSetAsync()
        {
            await Task.Run(() =>
            {
                CategoryData = new Category()
                {
                    DeleteFlag = false
                };
            });
        }

        protected async Task CreateCategory()
        {
            var result = await Mediator.Send(new CreateCategoryCommand() { Data = CategoryData });

            if (result.IsSuccess)
            {
                SnackBar.Add(SnackbarResources.AddSuccess, Severity.Success);
                Navigation.NavigateTo("admin/categories");
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
    }
}
