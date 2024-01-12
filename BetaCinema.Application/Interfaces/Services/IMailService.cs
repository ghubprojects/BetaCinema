using BetaCinema.Domain.Requests;

namespace BetaCinema.Application.Interfaces.Services
{
    public interface IMailService
    {
        Task SendAsync(MailRequest request);
    }
}
