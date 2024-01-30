using BetaCinema.Application.Features.Users.Commands;

namespace BetaCinema.ServerUI.Pages.Admin.Users
{
    public class UpdateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Parameter] public string UserId { get; set; }

        public User OldData { get; set; } = new();
        public User UserData { get; set; } = new();

        protected async override Task OnParametersSetAsync()
        {
            var result = await Mediator.Send(new GetUserByIdQuery() { Id = UserId });
            if (result.IsSuccess)
            {
                UserData = result.Data;
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
            var result = await Mediator.Send(new UpdateUserCommand()
            { Data = UserData, OldData = OldData });

            if (result.IsSuccess)
            {
                SnackBar.Add(SnackbarResources.UpdateSuccess, Severity.Success);
                Navigation.NavigateTo("admin/users");
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
