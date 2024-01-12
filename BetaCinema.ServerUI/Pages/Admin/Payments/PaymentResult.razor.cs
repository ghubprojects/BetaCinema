using BetaCinema.Application.Interfaces.Services;
using BetaCinema.Domain.Requests;
using BetaCinema.Domain.Wrappers;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.WebUtilities;
using System.Security.Claims;

namespace BetaCinema.ServerUI.Pages.Admin.Payments
{
    public class PaymentResultBase : ComponentBase
    {
        [Inject] IVnPayService VnPayService { get; set; }

        [Inject] NavigationManager Navigation { get; set; }

        [Inject] IMailService MailService { get; set; }

        [Inject] protected AuthenticationStateProvider AuthenticationStateProvider { get; set; }

        protected PaymentResponse paymentResponse;

        protected override async Task OnInitializedAsync()
        {
            var uri = Navigation.ToAbsoluteUri(Navigation.Uri);
            paymentResponse = VnPayService.PaymentExecute(QueryHelpers.ParseQuery(uri.Query));
        }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (paymentResponse.Success)
            {
                var authState = await AuthenticationStateProvider.GetAuthenticationStateAsync();

                var mailRequest = new MailRequest
                {
                    From = "anhtheit2002@gmail.com",
                    To = authState.User.FindFirstValue(ClaimTypes.Email),
                    Body = $"{paymentResponse.OrderDescription}",
                    Subject = "Beta Cinema Notification"
                };

                MailService.SendAsync(mailRequest);
            }
        }
    }
}
