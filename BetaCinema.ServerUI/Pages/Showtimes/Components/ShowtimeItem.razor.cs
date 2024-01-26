using BetaCinema.Application.Features.Showtimes.Commands;
using BetaCinema.Domain.Models;
using BetaCinema.ServerUI.Store.CinemaUseCase;
using Fluxor;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.WebUtilities;

namespace BetaCinema.ServerUI.Pages.Showtimes.Components
{
    public class ShowtimeItemBase : ComponentBase
    {
        #region Dependency Injection

        [Inject] private IState<CinemaState> CinemaState { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        #endregion

        #region Parameters

        [Parameter] public Movie MovieData { get; set; } = new();

        [Parameter] public DateTime ShowDate { get; set; } = new();

        [Parameter] public bool IsFirstItem { get; set; }

        #endregion

        #region Properties and Fields

        protected List<Showtime> showtimeList { get; set; } = new();

        protected string uri { get; set; }

        protected string movieTitleClasses { get => IsFirstItem ? "movie-title first-movie" : "movie-title"; }

        protected string wrapperStyles { get => IsFirstItem ? "width: 100%" : "width:50%"; }

        protected string posterStyles
        {
            get => IsFirstItem ? "border-radius: 20px;width:30%" : "border-radius: 20px;width:40%";
        }

        #endregion

        protected override void OnInitialized()
        {
            var query = new Dictionary<string, string> { { "id", MovieData.Id } };

            uri = QueryHelpers.AddQueryString("/movie-detail", query);
        }

        protected override async Task OnParametersSetAsync()
        {
            showtimeList = await Mediator.Send(new GetShowtimesByWeekDayQuery()
            {
                CinemaId = CinemaState.Value.Cinema.Id,
                MovieId = MovieData.Id,
                ShowDate = ShowDate
            });
        }
    }
}
