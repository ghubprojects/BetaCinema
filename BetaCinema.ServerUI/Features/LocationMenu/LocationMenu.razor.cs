using BetaCinema.Application.Features.Cinemas.Commands;
using BetaCinema.ServerUI.Store.CinemaUseCase;

namespace BetaCinema.ServerUI.Features.LocationMenu
{
    public class LocationMenuBase : ComponentBase
    {
        [Inject] private IMediator Mediator { get; set; }

        [Inject] public IDispatcher Dispatcher { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        protected MudTheme Theme = new();
        protected MudMenu locationMenuRef = new();

        protected List<Cinema>? cinemas = new();
        protected Menu? locationMenu = new() { SelectedCinema = new Cinema() };

        protected override async Task OnInitializedAsync()
        {
            var result = await Mediator.Send(new GetAllCinemasQuery());

            if (result.IsSuccess)
            {
                cinemas = result.Data;
                locationMenu = BuildMenu(cinemas);
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

        private Menu BuildMenu(List<Cinema> cinemas)
        {
            var menu = new Menu { SelectedCinema = cinemas.FirstOrDefault() };

            Dispatcher.Dispatch(new SelectCinemaAction() { Cinema = menu.SelectedCinema });

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
            locationMenuRef.CloseMenu();
            Dispatcher.Dispatch(new SelectCinemaAction() { Cinema = locationMenu.SelectedCinema });
            Navigation.NavigateTo("home");
        }
    }

    public class Menu
    {
        public Cinema SelectedCinema { get; set; }

        public List<Location> Locations { get; set; } = new List<Location>();
    }

    public class Location
    {
        public string LocationName { get; set; }

        public List<Cinema> Cinemas { get; set; } = new();
    }
}
