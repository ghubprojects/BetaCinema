using Microsoft.AspNetCore.Components;

namespace BetaCinema.ServerUI.Pages.Showtimes.Components
{
    public class ShowtimesNavigationBarBase : ComponentBase
    {
        public List<string> currentWeekDays { get; set; }

        private List<string> GetCurrentWeekDays()
        {
            DateTime currentDate = DateTime.Now;

            // Calculate the start and end dates for the current week
            DateTime startDate = currentDate;
            DateTime endDate = startDate.AddDays(6);

            var weekDays = new List<string>();
            // Build the result string
            for (DateTime date = startDate; date <= endDate; date = date.AddDays(1))
            {
                weekDays.Add(($"{date:dd/MM} - {date:ddd}").Replace("h ", ""));
            }

            return weekDays;
        }

        protected override void OnInitialized()
        {
            currentWeekDays = GetCurrentWeekDays();
        }
    }

}
