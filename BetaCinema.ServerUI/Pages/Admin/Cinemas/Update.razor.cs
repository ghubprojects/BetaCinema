using BetaCinema.Application.Features.Cinemas.Commands;

namespace BetaCinema.ServerUI.Pages.Admin.Cinemas
{
    public class UpdateBase : ComponentBase
    {
        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Parameter] public string CinemaId { get; set; }

        public Cinema OldData { get; set; } = new();

        public Cinema CinemaData { get; set; } = new();

        protected async override Task OnParametersSetAsync()
        {
            var result = await Mediator.Send(new GetCinemaByIdQuery() { Id = CinemaId });

            if (result.IsSuccess)
            {
                CinemaData = result.Data;
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
            var result = await Mediator.Send(new UpdateCinemaCommand()
            { Data = CinemaData, OldData = OldData });

            if (result.IsSuccess)
            {
                SnackBar.Add(SnackbarResources.UpdateSuccess, Severity.Success);
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
