using BetaCinema.Domain.DTOs;

namespace BetaCinema.Application.Interfaces.Services
{
    public interface IIdentityService
    {
        Task<string> RegisterAsync(RegisterUserDto model);
    }
}
