using BetaCinema.Application.Interfaces.Services;
using BetaCinema.Domain.Models;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Payments
{
    public class CheckoutBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] protected IHttpContextAccessor HttpContextAccessor { get; set; }

        [Inject] protected IVnPayService VnPayService { get; set; }

        [Parameter]
        public Payment PaymentData { get; set; }

        protected async override Task OnParametersSetAsync()
        {
            await Task.Run(() =>
            {
                PaymentData = new Payment()
                {
                    PaymentMethod = "VN Pay",
                    DeleteFlag = false
                };
            });
        }

        protected void CreatePaymentUrl()
        {
            var url = VnPayService.CreatePaymentUrl(PaymentData, HttpContextAccessor.HttpContext);

            Navigation.NavigateTo(url);
        }
    }
}
