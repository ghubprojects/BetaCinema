using Microsoft.AspNetCore.SignalR;

namespace BetaCinema.ServerUI.Hubs
{
    public class ProcessSeatHub : Hub
    {
        public async Task SendUpdateProcessSeatsAsync(string showtimeId)
        {
            await Clients.AllExcept(Context.ConnectionId).SendAsync("ReceiveProcessSeats", showtimeId);
        }
    }
}
