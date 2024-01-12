using BetaCinema.Application.Features.Seats.Commands;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Components;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Reservation
{
    public class ReservationBase : ComponentBase
    {
        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        protected List<Seat>? seats = new();
        protected List<RowSeat> roomSeats = new() { };
        protected List<Seat>? selectedSeat = new();
        protected int totalPrice = 0;

        protected List<SeatStatus> seatStatusList = new()
        {
            new SeatStatus("Ghế trống", "seat-unselected.png"),
            new SeatStatus("Ghế đang chọn", "seat-selected.png"),
            new SeatStatus("Ghế đã bán", "seat-sold.png"),
        };

        protected List<InfoItem> movieInfos = new()
        {
            new InfoItem("Thể loại", "{category}", "fas fa-tags"),
            new InfoItem("Thời lượng ", "{duration}", "far fa-clock"),
        };

        protected List<InfoItem> showtimeInfos = new()
        {
            new InfoItem("Rạp chiếu", "{cinema}", "fas fa-landmark"),
            new InfoItem("Ngày chiếu", "{startTime}", "far fa-calendar-days"),
            new InfoItem("Giờ chiếu", "{startTime}", "far fa-clock"),
        };

        protected override async Task OnInitializedAsync()
        {
            seats = await Mediator.Send(new GetAllSeatsQuery());
        }

        protected override void OnParametersSet()
        {
            roomSeats = BuildRoomSeats(seats);
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

            // Sort cinemas in each location by CinemaName
            foreach (var rowSeat in roomSeats)
            {
                rowSeat.Seats = rowSeat.Seats
                    .OrderBy(c => $"{c.RowNum}")
                    .ThenBy(c => c.SeatNum)
                    .ToList();
            }

            return roomSeats;
        }

        protected void ToggleSelectSeat(Seat seat)
        {
            var searchResult = selectedSeat.Find(s => s.Id == seat.Id);

            if (searchResult == null)
            {
                selectedSeat.Add(seat);
            }
            else
            {
                selectedSeat.Remove(seat);
            }
        }

        protected string GetSeatClasses(Seat seat)
        {
            var searchResult = selectedSeat.Find(s => s.Id == seat.Id);
            if (searchResult == null)
            {
                return "seat";
            }
            else
            {
                return "seat selected";
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
