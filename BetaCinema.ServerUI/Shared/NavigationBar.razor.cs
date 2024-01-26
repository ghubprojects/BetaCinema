using Microsoft.AspNetCore.Components;

namespace BetaCinema.ServerUI.Shared
{
    public class NavigationBarBase : ComponentBase
    {
        [Parameter] public bool IsShowCinemaMenu { get; set; } = true;

        protected readonly List<NavItem> navItemList = new()
        {
            new NavItem("Lịch chiếu theo rạp", "showtimes"),
            new NavItem("Phim", "movies"),
            new NavItem("Giá vé", "ticket-price"),
            new NavItem("Thành viên", "member"),
        };
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
