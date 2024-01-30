using BetaCinema.Application.Features.Categories.Commands;

namespace BetaCinema.ServerUI.Pages.Admin.Categories
{
    public class UpdateBase : ComponentBase
    {
        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Parameter] public string CategoryId { get; set; }

        public Category CategoryData { get; set; } = new();
        public Category OldData { get; set; } = new();

        protected async override Task OnParametersSetAsync()
        {
            var result = await Mediator.Send(new GetCategoryByIdQuery() { Id = CategoryId });

            if (result.IsSuccess)
            {
                CategoryData = result.Data;
                OldData = result.Data;
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

        protected async Task SaveChanges()
        {
            var result = await Mediator.Send(new UpdateCategoryCommand()
            { Data = CategoryData, OldData = OldData });

            if (result.IsSuccess)
            {
                SnackBar.Add(SnackbarResources.UpdateSuccess, Severity.Success);
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
