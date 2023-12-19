using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Infrastructure.Repositories;
using Microsoft.Extensions.DependencyInjection;

namespace BetaCinema.Infrastructure
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfrastructure(this IServiceCollection services)
        {
            services.AddDbContext<ApplicationDbContext>();
            services.AddScoped(typeof(IBaseRepository<>), typeof(BaseRepository<>));
            services.AddScoped<IUnitOfWork, UnitOfWork>();
            services.AddScoped<IUserRepository, UserRepository>();

            return services;
        }
    }
}
