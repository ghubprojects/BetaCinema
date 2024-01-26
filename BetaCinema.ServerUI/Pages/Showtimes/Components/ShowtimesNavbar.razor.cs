using BetaCinema.Application.Features.Movies.Commands;
using BetaCinema.Domain.Models;
using BetaCinema.ServerUI.Store.CinemaUseCase;
using Fluxor;
using MediatR;
using Microsoft.AspNetCore.Components;

namespace BetaCinema.ServerUI.Pages.Showtimes.Components
{
    public class ShowtimesNavbarBase : ComponentBase
    {
        [Inject] private IState<CinemaState> CinemaState { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        public Dictionary<string, DateTime> currentWeekDays { get; set; }

        protected List<Movie> movieList { get; set; } = new();

        private Dictionary<string, DateTime> GetCurrentWeekDays()
        {
            DateTime currentDate = DateTime.Now;

            // Calculate the start and end dates for the current week
            DateTime startDate = currentDate;
            DateTime endDate = startDate.AddDays(6);

            var weekDays = new Dictionary<string, DateTime>();
            // Build the result string
            for (DateTime date = startDate; date <= endDate; date = date.AddDays(1))
            {

                weekDays.Add(($"{date:dd/MM} - {date:ddd}").Replace("h ", ""), date);
            }

            return weekDays;
        }

        protected override void OnInitialized()
        {
            currentWeekDays = GetCurrentWeekDays();
        }

        protected override async Task OnParametersSetAsync()
        {
            movieList = await Mediator.Send(new GetMoviesByWeekDayQuery()
            {
                CinemaId = CinemaState.Value.Cinema?.Id,
                ShowDate = currentWeekDays.First().Value
            });
        }

        protected async Task GetMoviesByWeekDay(string weekDay)
        {
            movieList = await Mediator.Send(new GetMoviesByWeekDayQuery()
            {
                CinemaId = CinemaState.Value.Cinema.Id,
                ShowDate = currentWeekDays[weekDay]
            });
        }
    }

}
