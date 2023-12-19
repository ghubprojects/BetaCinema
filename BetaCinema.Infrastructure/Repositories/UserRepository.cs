using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;

namespace BetaCinema.Infrastructure.Repositories
{
    public class UserRepository : IUserRepository
    {
        private readonly IBaseRepository<User> _repository;

        public UserRepository(IBaseRepository<User> repository)
        {
            _repository = repository;
        }
    }
}
