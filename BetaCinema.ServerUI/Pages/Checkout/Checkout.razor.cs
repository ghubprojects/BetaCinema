using BetaCinema.Application.Interfaces.Services;
using BetaCinema.ServerUI.Store.ReservationUseCase;
using Microsoft.AspNetCore.WebUtilities;

namespace BetaCinema.ServerUI.Pages.Checkout
{
    public class CheckoutBase : ComponentBase
    {
        [Inject] protected IState<ReservationState> ReservationState { get; set; }

        [Inject] protected IHttpContextAccessor HttpContextAccessor { get; set; }

        [Inject] protected IVnPayService VnPayService { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        protected string paymentMethod { get; set; } = "Ví VnPay";
        protected List<PaymentMethod> paymentMethods = new()
        {
            new PaymentMethod("ic-card-vn.png", "Thẻ nội địa", ""),
            new PaymentMethod("ic-card-gb.png", "Thẻ quốc tế", ""),
            new PaymentMethod("shopeepay.png", "Ví ShopeePay", ""),
            new PaymentMethod("momo.png", "Ví MoMo", ""),
            new PaymentMethod("zalopay.jpg", "Ví ZaloPay", ""),
            new PaymentMethod("vnpay.jpg", "Ví VnPay", ""),
        };

        protected List<InfoItem> movieInfos = new();
        protected List<InfoItem> showtimeInfos = new();
        protected int totalPrice = 0;

        protected override void OnParametersSet()
        {
            Showtime showtimeData = ReservationState.Value.Showtime;
            totalPrice = ReservationState.Value.SelectedSeat.Count * showtimeData.TicketPrice;

            movieInfos.AddRange(new List<InfoItem>()
            {
                new InfoItem(CategoryResources.CategoryName, string.Join(", ", showtimeData.Movie.MovieCategories.Select(mc => mc.Category.CategoryName)), "fas fa-tags"),
                new InfoItem(MovieResources.Duration, $"{showtimeData.Movie.Duration} phút", "far fa-clock")
            });

            showtimeInfos.AddRange(new List<InfoItem>()
            {
                new InfoItem(CinemaResources.CinemaName, showtimeData.Cinema.CinemaName, "fas fa-landmark"),
                new InfoItem(ShowtimeResources.ShowDate, showtimeData.StartTime.Value.ToString("dd/MM/yyyy"), "far fa-calendar-days"),
                new InfoItem(ShowtimeResources.StartTime, showtimeData.StartTime.Value.ToString("HH:mm"), "far fa-clock")
            });
        }

        protected void NavigateToReservation()
        {
            var query = new Dictionary<string, string>
            {
                { "id", ReservationState.Value.Showtime.Id }
            };
            var uri = QueryHelpers.AddQueryString("/reservation", query);
            Navigation.NavigateTo(uri);
        }

        protected void NavigateToExternalPayment()
        {
            var url = VnPayService.CreatePaymentUrl(new Payment()
            {
                TotalPrice = totalPrice,
                PaymentMethod = "VN Pay",
                DeleteFlag = false
            }, HttpContextAccessor.HttpContext);

            Navigation.NavigateTo(url);
        }
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

    public class PaymentMethod
    {
        public string IconPath { get; set; }
        public string Title { get; set; }
        public string Url { get; set; }
        public PaymentMethod(string iconPath, string title, string url)
        {
            IconPath = iconPath;
            Title = title;
            Url = url;
        }
    }
}
