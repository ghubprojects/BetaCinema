﻿using BetaCinema.Application.Features.ProcessSeats.Commands;
using BetaCinema.Application.Features.Seats.Commands;
using BetaCinema.Application.Features.Showtimes.Commands;
using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.ServerUI.Store.ReservationUseCase;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Components.Server.ProtectedBrowserStorage;
using Microsoft.AspNetCore.SignalR.Client;
using Microsoft.AspNetCore.WebUtilities;
using Microsoft.Extensions.Primitives;
using System.Timers;

namespace BetaCinema.ServerUI.Pages.Reservation
{
    public class ReservationBase : ComponentBase, IDisposable
    {
        [Inject] private IMediator Mediator { get; set; }

        [Inject] public IDispatcher Dispatcher { get; set; }

        [Inject] protected AuthenticationStateProvider AuthenticationStateProvider { get; set; }

        [Inject] protected ProtectedLocalStorage BrowserStorage { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        private HubConnection hubConnection;

        protected List<Seat>? seats = new();
        protected List<RowSeat> roomSeats = new() { };
        protected List<Seat>? selectedSeats = new();
        protected List<Seat>? soldSeats = new();
        protected List<Seat>? processSeats = new();
        protected int totalPrice = 0;

        protected List<SeatStatus> seatStatusList = new()
        {
            new SeatStatus("Ghế trống", "seat-unselected.png"),
            new SeatStatus("Ghế đang chọn", "seat-selected.png"),
            new SeatStatus("Ghế đang được giữ", "seat-process.png"),
            new SeatStatus("Ghế đã bán", "seat-sold.png"),
        };

        protected List<InfoItem> movieInfos = new();
        protected List<InfoItem> showtimeInfos = new();

        protected Showtime ShowtimeData { get; set; } = new();

        protected async override Task OnInitializedAsync()
        {
            var uri = Navigation.ToAbsoluteUri(Navigation.Uri);
            if (QueryHelpers.ParseQuery(uri.Query).TryGetValue("id", out StringValues id))
            {
                // get showtime data by id and assign to ShowtimeData
                await GetShowtimeById(id);

                await GetAllSeats();
                await GetSoldSeats(ShowtimeData.Id);
                await GetAllProcessSeats();
            }

            // init hub
            hubConnection = new HubConnectionBuilder()
                .WithUrl(Navigation.ToAbsoluteUri("/signalRHub"))
                .Build();
            await hubConnection.StartAsync();

            // get changes in signalR hub
            hubConnection.On<string>("ReceiveProcessSeats", async (id) =>
            {
                if (ShowtimeData.Id == id)
                {
                    await GetAllProcessSeats();
                }
            });
        }

        /// <summary>
        /// Get all seats
        /// </summary>
        /// <returns></returns>
        protected async Task GetAllSeats()
        {
            var result = await Mediator.Send(new GetAllSeatsQuery());

            if (result.IsSuccess)
            {
                seats = result.Data;
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

        /// <summary>
        /// Get all process seats by showtime data and user ID
        /// </summary>
        /// <returns></returns>
        protected async Task GetAllProcessSeats()
        {
            var result = await Mediator.Send(new GetProcessSeatsByShowtime()
            { ShowtimeData = ShowtimeData });

            if (result.IsSuccess)
            {
                processSeats = result.Data;
                StateHasChanged();
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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="weekDay"></param>
        /// <returns></returns>
        protected async Task GetShowtimeById(string showtimeId)
        {
            var result = await Mediator.Send(new GetShowtimeByIdQuery()
            { Id = Convert.ToString(showtimeId) });

            if (result.IsSuccess)
            {
                ShowtimeData = result.Data;
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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="weekDay"></param>
        /// <returns></returns>
        protected async Task GetSoldSeats(string showtimeId)
        {
            var result = await Mediator.Send(new GetSoldSeatsByShowtimeId()
            { ShowtimeId = showtimeId });

            if (result.IsSuccess)
            {
                soldSeats = result.Data;
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

        protected override void OnParametersSet()
        {
            roomSeats = BuildRoomSeats(seats);

            movieInfos.AddRange(new List<InfoItem>()
            {
                new InfoItem(CategoryResources.CategoryName, string.Join(", ", ShowtimeData.Movie.MovieCategories.Select(mc => mc.Category.CategoryName)), "fas fa-tags"),
                new InfoItem(MovieResources.Duration, $"{ShowtimeData.Movie.Duration} phút", "far fa-clock")
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

        int countdownTime = 60;
        protected override void OnAfterRender(bool firstRender)
        {
            if (firstRender)
            {
                Start(countdownTime);
            }
        }

        /// <summary>
        /// Countdown timer
        /// </summary>
        private System.Timers.Timer _timer = null!;
        private int _secondsToRun = 0;

        protected string Time { get; set; } = "00:00";

        public void Start(int secondsToRun)
        {
            _secondsToRun = secondsToRun;

            if (_secondsToRun > 0)
            {
                Time = TimeSpan.FromSeconds(_secondsToRun).ToString(@"mm\:ss");
                StateHasChanged();
                _timer.Start();
            }
        }

        protected override void OnInitialized()
        {
            _timer = new System.Timers.Timer(1000);
            _timer.Elapsed += OnTimedEvent;
            _timer.AutoReset = true;
        }

        private async void OnTimedEvent(object? sender, ElapsedEventArgs e)
        {
            _secondsToRun--;

            await InvokeAsync(() =>
            {
                Time = TimeSpan.FromSeconds(_secondsToRun).ToString(@"mm\:ss");
                StateHasChanged();
            });

            if (_secondsToRun <= 0)
            {
                _timer.Stop();
                await TimerOutCallback();
            }
        }

        public void Dispose()
        {
            _timer.Dispose();
        }

        public async Task TimerOutCallback()
        {
            selectedSeats.Clear();
            await hubConnection.SendAsync("SendUpdateProcessSeatsAsync", ShowtimeData.Id);
            Navigation.NavigateTo("home");
        }

        protected async void ToggleSelectSeat(Seat seat)
        {
            var seatIsSold = soldSeats.Find(s => s.Id == seat.Id);
            if (seatIsSold != null)
            {
                return;
            }

            var seatIsProcess = processSeats.Find(s => s.Id == seat.Id);
            if (seatIsProcess != null)
            {
                return;
            }

            var searchResult = selectedSeats.Find(s => s.Id == seat.Id);

            if (searchResult == null)
            {
                selectedSeats.Add(seat);
                totalPrice += ShowtimeData.TicketPrice;

                var result = await Mediator.Send(new CreateProcessSeatCommand()
                {
                    SeatData = seat,
                    ShowtimeData = ShowtimeData,
                });

                if (result.IsSuccess)
                {
                    // notify to all client
                    await hubConnection.SendAsync("SendUpdateProcessSeatsAsync", ShowtimeData.Id);
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
            else
            {
                selectedSeats.Remove(seat);
                totalPrice -= ShowtimeData.TicketPrice;

                var result = await Mediator.Send(new DeleteProcessSeatCommand()
                {
                    SeatData = seat,
                    ShowtimeData = ShowtimeData,
                });

                if (result.IsSuccess)
                {
                    // notify to all client
                    await hubConnection.SendAsync("SendUpdateProcessSeatsAsync", ShowtimeData.Id);
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
        }

        protected string GetSeatClasses(Seat seat)
        {
            var seatIsSold = soldSeats.Find(s => s.Id == seat.Id);
            if (seatIsSold != null)
            {
                return "seat sold";
            }

            var seatIsProcess = processSeats.Find(s => s.Id == seat.Id);
            if (seatIsProcess != null)
            {
                return "seat process";
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
