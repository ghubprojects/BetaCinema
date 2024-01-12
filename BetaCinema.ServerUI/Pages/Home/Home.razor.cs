using BetaCinema.Application.Features.Slides.Queries;
using MediatR;
using Microsoft.AspNetCore.Components;

namespace BetaCinema.ServerUI.Pages.Home
{
    public class HomeBase : ComponentBase
    {
        [Inject] private IMediator Mediator { get; set; }

        protected List<string>? slideNames;

        protected override async Task OnInitializedAsync()
        {
            slideNames = await Mediator.Send(new GetAllSlidesQuery());
        }
    }
}
