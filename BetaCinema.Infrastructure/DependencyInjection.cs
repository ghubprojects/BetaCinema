using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Models;
using BetaCinema.Infrastructure.Repositories;
using BetaCinema.Infrastructure.Services;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace BetaCinema.Infrastructure
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configuration)
        {
            // Add DB Context
            services.AddDbContext<AppDbContext>();

            // Add Identity
            services.AddIdentity<User, IdentityRole>(options =>
            {
                options.Password.RequireDigit = false;
                options.Password.RequiredLength = 6;
                options.Password.RequireLowercase = false;
                options.Password.RequireUppercase = false;
                options.Password.RequireNonAlphanumeric = false;
                options.SignIn.RequireConfirmedEmail = false;
            }).AddRoles<IdentityRole>().AddEntityFrameworkStores<AppDbContext>();

            // Add DB Seeder
            services.AddTransient<AppDbContextSeeder>();

            // Add Identity Validation
            services.AddScoped<AuthenticationStateProvider, IdentityValidationProvider<User>>();

            // Add Google Login
            services.AddAuthentication().AddGoogle(googleOptions =>
            {
                // Đọc thông tin Authentication:Google từ appsettings.json
                var googleConfig = configuration.GetSection("Authentication:Google");

                // Thiết lập ClientID và ClientSecret để truy cập API google
                googleOptions.ClientId = googleConfig["ClientId"];
                googleOptions.ClientSecret = googleConfig["ClientSecret"];
                // Cấu hình Url callback lại từ Google (không thiết lập thì mặc định là /signin-google)
                googleOptions.CallbackPath = "/login-google";
            });

            services.AddScoped(typeof(IBaseRepository<>), typeof(BaseRepository<>));
            services.AddScoped<IUnitOfWork, UnitOfWork>();

            return services;
        }
    }
}
