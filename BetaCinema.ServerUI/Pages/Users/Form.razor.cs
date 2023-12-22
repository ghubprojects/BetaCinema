using BetaCinema.Domain.Enums;
using BetaCinema.Domain.Models;
using Microsoft.AspNetCore.Components;

namespace BetaCinema.ServerUI.Pages.Users
{
    public class FormBase : ComponentBase
    {
        [Parameter]
        public User User { get; set; }

        [Parameter]
        public string ButtonText { get; set; } = "Save";

        [Parameter]
        public EventCallback OnValidSubmit { get; set; }

        [Parameter]
        public FormMode Mode { get; set; }

        protected bool AllowChangeRole { get => Mode.Equals(FormMode.Create); }
    }
}
