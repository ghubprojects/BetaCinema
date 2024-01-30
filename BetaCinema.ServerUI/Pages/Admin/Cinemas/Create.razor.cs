using BetaCinema.Application.Features.Cinemas.Commands;

namespace BetaCinema.ServerUI.Pages.Admin.Cinemas
{
    public class CreateBase : ComponentBase
    {
        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        public Cinema CinemaData { get; set; } = new();

        protected async override Task OnParametersSetAsync()
        {
            await Task.Run(() =>
            {
                CinemaData = new Cinema()
                {
                    DeleteFlag = false
                };
            });
        }

        protected async Task CreateCinema()
        {
            var result = await Mediator.Send(new CreateCinemaCommand() { Data = CinemaData });

            if (result.IsSuccess)
            {
                SnackBar.Add(SnackbarResources.AddSuccess, Severity.Success);
                Navigation.NavigateTo("admin/cinemas");
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
