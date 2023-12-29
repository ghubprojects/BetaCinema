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

            services.AddMediatR(cfg => cfg.RegisterServicesFromAssembly(Assembly.GetExecutingAssembly()));

            return services;
        }
    }
}
