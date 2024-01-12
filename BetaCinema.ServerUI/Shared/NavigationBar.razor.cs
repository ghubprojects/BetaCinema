using BetaCinema.Application.Features.Cinemas.Commands;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Components;
using MudBlazor;

namespace BetaCinema.ServerUI.Shared
{
    public class NavigationBarBase : ComponentBase
    {
        [Inject] private IMediator Mediator { get; set; }

        protected MudTheme Theme = new();

        protected readonly List<NavItem> navItemList = new()
        {
            new NavItem("Lịch chiếu theo rạp", "showtimes"),
            new NavItem("Phim", "movies"),
            new NavItem("Giá vé", "ticket-price"),
            new NavItem("Thành viên", "member"),
            new NavItem("Reservation Test", "reservation")
        };

        protected List<Cinema>? cinemas;
        protected LocationMenu? locationMenu;

        protected override async Task OnInitializedAsync()
        {
            locationMenu = new() { SelectedCinema = new Cinema() };
            cinemas = await Mediator.Send(new GetAllCinemasQuery());
        }

        protected override void OnParametersSet()
        {
            locationMenu = BuildLocationMenu(cinemas);
        }

        private LocationMenu BuildLocationMenu(List<Cinema> cinemas)
        {
            var menu = new LocationMenu
            {
                SelectedCinema = cinemas.FirstOrDefault()
            };

            foreach (var cinema in cinemas)
            {
                var location = menu.Locations.Find(l => l.LocationName == cinema.CinemaLocation);

                if (location == null)
                {
                    location = new Location { LocationName = cinema.CinemaLocation };
                    menu.Locations.Add(location);
                }

                location.Cinemas.Add(cinema);
            }

            return menu;
        }

        protected void SelectCinema(Cinema cinema)
        {
            locationMenu.SelectedCinema = cinema;
        }
    }

    public class LocationMenu
    {
        public Cinema SelectedCinema { get; set; }

        public List<Location> Locations { get; set; } = new List<Location>();
    }

    public class Location
    {
        public string LocationName { get; set; }

        public List<Cinema> Cinemas { get; set; } = new();
    }

    public class NavItem
    {
        public string Title { get; set; }

        public string Href { get; set; }

        public NavItem(string title, string href)
        {
            Title = title;
            Href = href;
        }
    }
}
