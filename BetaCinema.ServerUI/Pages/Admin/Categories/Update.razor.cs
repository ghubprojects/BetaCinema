using BetaCinema.Application.Features.Categories.Commands;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Categories
{
    public class UpdateBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        [Parameter] public string CategoryId { get; set; }

        public Category CategoryData { get; set; } = new();

        protected async override Task OnParametersSetAsync()
        {
            CategoryData = await Mediator.Send(new GetCategoryByIdQuery() { Id = CategoryId });
        }

        protected async Task SaveChanges()
        {
            await Mediator.Send(new UpdateCategoryCommand() { Data = CategoryData });

            SnackBar.Add("Update successfully", Severity.Success);
            Navigation.NavigateTo("admin/categories");
        }
    }
}
