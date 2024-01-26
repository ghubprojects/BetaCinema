using BetaCinema.Application.Features.Seats.Commands;
using BetaCinema.Application.Features.Showtimes.Commands;
using BetaCinema.Domain.Models;
using BetaCinema.ServerUI.Store.CinemaUseCase;
using Fluxor;
using MediatR;
using Microsoft.AspNetCore.Components;

namespace BetaCinema.ServerUI.Features.MovieShowtimes
{
    public class MovieShowtimesNavigationBarBase : ComponentBase
    {
        [Parameter]
        public Movie MovieData { get; set; } = new();

        [Inject] private IState<CinemaState> CinemaState { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        protected List<Showtime> showtimeList { get; set; } = new();
        protected int totalSeats { get; set; } = 0;

        public Dictionary<string, DateTime> currentWeekDays { get; set; }

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

        protected override async Task OnInitializedAsync()
        {
            currentWeekDays = GetCurrentWeekDays();
            showtimeList = await Mediator.Send(new GetShowtimesByWeekDayQuery()
            {
                CinemaId = CinemaState.Value.Cinema.Id,
                MovieId = MovieData.Id,
                ShowDate = currentWeekDays.First().Value
            });

            var result = await Mediator.Send(new GetAllSeatsQuery() { });
            totalSeats = result.Count;
        }

        protected async Task GetShowtimes(string weekDay)
        {
            showtimeList = await Mediator.Send(new GetShowtimesByWeekDayQuery()
            {
                CinemaId = CinemaState.Value.Cinema.Id,
                MovieId = MovieData.Id,
                ShowDate = currentWeekDays[weekDay]
            });
        }
    }
}
