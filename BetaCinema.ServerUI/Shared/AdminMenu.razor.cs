﻿using Microsoft.AspNetCore.Components;

namespace BetaCinema.ServerUI.Shared
{
    public class AdminMenuBase : ComponentBase
    {
        protected readonly List<SidebarItem> sidebarItems = new()
        {
            new SidebarItem("Slides", "admin/slides", "fas fa-image"),
            new SidebarItem("Người dùng", "admin/users", "fas fa-user"),
            new SidebarItem("Phim", "admin/movies", "fas fa-film"),
            new SidebarItem("Rạp phim", "admin/cinemas", "fas fa-location-dot"),
            new SidebarItem("Hóa đơn", "admin/payments", "fas fa-money-bill"),
            new SidebarItem("Ghế", "admin/seats", "fas fa-couch"),
        };
    }

    public class SidebarItem
    {
        public string Title { get; set; }

        public string Href { get; set; }

        public string IconClass { get; set; }


        public SidebarItem(string title, string href, string iconClass)
        {
            Title = title;
            Href = href;
            IconClass = iconClass;
        }
    }
}