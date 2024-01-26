using BetaCinema.Application.Features.Seats.Commands;
using BetaCinema.Application.Features.Showtimes.Commands;
using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.ServerUI.Components.Dialog;
using BetaCinema.ServerUI.Resources;
using BetaCinema.ServerUI.Store.ReservationUseCase;
using Fluxor;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Components.Server.ProtectedBrowserStorage;
using Microsoft.AspNetCore.WebUtilities;
using Microsoft.Extensions.Primitives;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Reservation
{
    public class ReservationBase : ComponentBase
    {
        [Inject] private IMediator Mediator { get; set; }

        [Inject] public IDispatcher Dispatcher { get; set; }

        [Inject] protected AuthenticationStateProvider AuthenticationStateProvider { get; set; }

        [Inject] protected ProtectedLocalStorage BrowserStorage { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        protected List<Seat>? seats = new();
        protected List<RowSeat> roomSeats = new() { };
        protected List<Seat>? selectedSeats = new();
        protected List<Seat>? soldSeats = new();
        protected int totalPrice = 0;

        protected List<SeatStatus> seatStatusList = new()
        {
            new SeatStatus("Ghế trống", "seat-unselected.png"),
            new SeatStatus("Ghế đang chọn", "seat-selected.png"),
            new SeatStatus("Ghế đã bán", "seat-sold.png"),
        };

        protected List<InfoItem> movieInfos = new();
        protected List<InfoItem> showtimeInfos = new();

        protected Showtime ShowtimeData { get; set; } = new();

        protected async override Task OnInitializedAsync()
        {
            seats = await Mediator.Send(new GetAllSeatsQuery());

            var uri = Navigation.ToAbsoluteUri(Navigation.Uri);
            if (QueryHelpers.ParseQuery(uri.Query).TryGetValue("id", out StringValues id))
            {
                ShowtimeData = await Mediator.Send(new GetShowtimeByIdQuery() { Id = Convert.ToString(id) });
                soldSeats = await Mediator.Send(new GetSoldSeatsByShowtimeId() { ShowtimeId = ShowtimeData.Id });
            }
        }

        protected override void OnParametersSet()
        {
            roomSeats = BuildRoomSeats(seats);

            movieInfos.AddRange(new List<InfoItem>()
                {
                    new InfoItem(CategoryResources.CategoryName, "{ Category }", "fas fa-tags"),
                    new InfoItem(MovieResources.Duration, ShowtimeData.Movie.Duration.ToString(), "far fa-clock")
                });

            showtimeInfos.AddRange(new List<InfoItem>()
                {
                    new InfoItem(CinemaResources.CinemaName, ShowtimeData.Cinema.CinemaName, "fas fa-landmark"),
                    new InfoItem(ShowtimeResources.ShowDate, ShowtimeData.StartTime.Value.ToString("dd/MM/yyyy"), "far fa-calendar-days"),
                    new InfoItem(ShowtimeResources.StartTime, ShowtimeData.StartTime.Value.ToString("HH:mm"), "far fa-clock")
                });
        }

        private List<RowSeat> BuildRoomSeats(List<Seat> seats)
        {
            foreach (var seat in seats)
            {
                var rowSeat = roomSeats.Find(rs => rs.RowNum == seat.RowNum);

                if (rowSeat == null)
                {
                    rowSeat = new RowSeat { RowNum = seat.RowNum };
                    roomSeats.Add(rowSeat);
                }

                rowSeat.Seats.Add(seat);
            }

            roomSeats.Sort((rs1, rs2) => string.Compare(rs1.RowNum, rs2.RowNum, StringComparison.Ordinal));

            foreach (var rowSeat in roomSeats)
            {
                rowSeat.Seats = rowSeat.Seats
                    .OrderBy(c => c.RowNum)
                    .ThenBy(c => c.SeatNum)
                    .ToList();
            }

            return roomSeats;
        }

        protected void ToggleSelectSeat(Seat seat)
        {
            var seatIsSold = soldSeats.Find(s => s.Id == seat.Id);
            if (seatIsSold != null)
            {
                return;
            }

            var searchResult = selectedSeats.Find(s => s.Id == seat.Id);

            if (searchResult == null)
            {
                selectedSeats.Add(seat);
                totalPrice += ShowtimeData.TicketPrice;
            }
            else
            {
                selectedSeats.Remove(seat);
                totalPrice -= ShowtimeData.TicketPrice;
            }
        }

        protected string GetSeatClasses(Seat seat)
        {
            var seatIsSold = soldSeats.Find(s => s.Id == seat.Id);
            if (seatIsSold != null)
            {
                return "seat sold";
            }

            var seatIsSelected = selectedSeats.Find(s => s.Id == seat.Id);
            if (seatIsSelected != null)
            {
                return "seat selected";
            }

            return "seat";
        }

        protected async Task HandleReserveSeat()
        {
            if (selectedSeats == null)
            {
                return;
            }

            if (!selectedSeats.Any())
            {
                DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
                    new DialogParameters<ErrorMessageDialog>
                    {
                        { x => x.ContentText, "Vui lòng chọn ít nhất 1 ghế để tiếp tục." },
                        { x => x.ButtonText, SharedResources.Close },
                        { x => x.Color, Color.Error }
                    }, new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
            }
            else
            {
                // get user data
                var storedUserId = await BrowserStorage.GetAsync<string>("userId");
                var userDataResult = await Mediator.Send(
                    new GetUserByIdQuery() { Id = storedUserId.Value });

                if (userDataResult.IsSuccess)
                {
                    var userData = (User)userDataResult.Data;
                    Dispatcher.Dispatch(new ReserveSeatAction()
                    {
                        Showtime = ShowtimeData,
                        SelectedSeat = selectedSeats,
                        UserEmail = userData.Email,
                        UserFullName = userData.FullName,
                    });

                    await BrowserStorage.SetAsync("showtimeId", ShowtimeData.Id);
                    await BrowserStorage.SetAsync("selectedSeats", string.Join(", ", selectedSeats.Select(x => $"{x.RowNum}{x.SeatNum}")));

                    Navigation.NavigateTo("checkout");
                }
                else
                {
                    Navigation.NavigateTo("login", true);
                }
            }
        }
    }

    public class RowSeat
    {
        public string RowNum { get; set; }
        public List<Seat> Seats { get; set; } = new();
    }

    public class SeatStatus
    {
        public string Status { get; set; }
        public string ImageFileName { get; set; }

        //constructor
        public SeatStatus(string status, string imageFileName) { Status = status; ImageFileName = imageFileName; }
    }

    public class InfoItem
    {
        public string Title { get; set; }
        public string Content { get; set; }
        public string IconClass { get; set; }

        // constructor
        public InfoItem(string title, string content, string iconClass)
        {
            Title = title;
            Content = content;
            IconClass = iconClass;
        }
    }
}
