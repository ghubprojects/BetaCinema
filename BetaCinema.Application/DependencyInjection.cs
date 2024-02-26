using Hangfire;
using Hangfire.PostgreSql;
using Microsoft.Extensions.DependencyInjection;
using System.Reflection;

namespace BetaCinema.Application
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddApplication(this IServiceCollection services)
        {
            // Cấu hình AutoMapper để ánh xạ các đối tượng.
            services.AddAutoMapper(Assembly.GetExecutingAssembly());

            // DI mediator to implement CQRS
            services.AddMediatR(cfg => cfg.RegisterServicesFromAssembly(Assembly.GetExecutingAssembly()));

            // Add Hangfire
            services.AddHangfire(x => x.UsePostgreSqlStorage("Server=localhost;Port=5432;Database=beta_cinema.hangfire;Uid=postgres;Pwd=MyAl1705!!!;"));

            return services;
        }
    }
}
