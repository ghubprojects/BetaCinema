using BetaCinema.Application.Features.Payments.Commands;
using BetaCinema.Application.Features.ReservationItems.Commands;
using BetaCinema.Application.Features.Reservations.Commands;
using BetaCinema.Application.Features.Showtimes.Commands;
using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using BetaCinema.ServerUI.Components.Dialog;
using BetaCinema.ServerUI.Resources;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Components.Server.ProtectedBrowserStorage;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Checkout
{
    public class PaymentResultBase : ComponentBase
    {
        [Inject] private IMediator Mediator { get; set; }

        [Inject] protected AuthenticationStateProvider AuthenticationStateProvider { get; set; }

        [Inject] protected ProtectedLocalStorage BrowserStorage { get; set; }

        [Inject] NavigationManager Navigation { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        protected PaymentResponse paymentResponse = new();

        protected override async void OnInitialized()
        {
            var uri = Navigation.ToAbsoluteUri(Navigation.Uri);
            paymentResponse = await Mediator.Send(new ExecutePaymentCommand() { Uri = uri });
        }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (paymentResponse.Success)
            {
                // get user data
                var storedUserId = await BrowserStorage.GetAsync<string>("userId");
                var userDataResult = await Mediator.Send(new GetUserByIdQuery() { Id = storedUserId.Value });
                var userData = (User)userDataResult.Data;

                // get showtime data
                var showtimeId = await BrowserStorage.GetAsync<string>("showtimeId");
                var showtime = await Mediator.Send(new GetShowtimeByIdQuery() { Id = showtimeId.Value });

                // create reservation
                var createReservationResult = await Mediator.Send(new CreateReservationCommand()
                {
                    UserId = storedUserId.Value,
                    ShowtimeData = showtime
                });

                if (createReservationResult.IsSuccess)
                {
                    // create multiple reservation items if success
                    var newReservation = (Domain.Models.Reservation)createReservationResult.Data;

                    // get selected seats string
                    var selectedSeats = await BrowserStorage.GetAsync<string>("selectedSeats");

                    var createMultipleReservationItemResult = await Mediator.Send(new CreateMultipleReservationItemsCommand()
                    {
                        ReservationData = newReservation,
                        SelectedSeatList = selectedSeats.Value
                    });

                    // create payments if success
                    if (createMultipleReservationItemResult.IsSuccess)
                    {
                        // get seat count
                        var seatCount = selectedSeats.Value.Split(", ").ToList().Count;

                        // create payment
                        var createPaymentResult = await Mediator.Send(new CreatePaymentCommand()
                        {
                            ReservationData = newReservation,
                            PaymentMethod = "Ví VnPay",
                            TotalPrice = seatCount * showtime.TicketPrice
                        });

                        if (createPaymentResult.IsSuccess)
                        {
                            // send email if success
                            await Mediator.Send(new SendTicketBookingEmailCommand()
                            {
                                UserFullName = userData.FullName,
                                UserEmail = userData.Email,
                                PaymentId = ((Payment)createPaymentResult.Data).Id,
                            });

                            // clear showtime and selected seats in storage
                            await BrowserStorage.DeleteAsync("showtimeId");
                            await BrowserStorage.DeleteAsync("selectedSeats");
                        }
                    }
                }
            }
            else
            {
                DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
                    new DialogParameters<ErrorMessageDialog>
                    {
                        { x => x.ContentText, "Giao dịch thất bại" },
                        { x => x.ButtonText, SharedResources.Close },
                        { x => x.Color, Color.Error }
                    }, new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
            }

        }

        protected void NavigateToHome()
        {
            Navigation.NavigateTo("home");
        }
    }
}
