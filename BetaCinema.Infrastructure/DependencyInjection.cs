using BetaCinema.Application.Interfaces;
using BetaCinema.Application.Interfaces.Services;
using BetaCinema.Domain.Models;
using BetaCinema.Infrastructure.Persistence;
using BetaCinema.Infrastructure.Services;
using FluentEmail.MailKitSmtp;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace BetaCinema.Infrastructure
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configuration)
        {
            // Add DB Context
            services.AddDbContextFactory<AppDbContext>(options => options.UseNpgsql("Server=localhost;Port=5432;Database=beta_cinema;Uid=postgres;Pwd=MyAl1705!!!;"));

            services.AddTransient<IAppDbContext>(provider => provider.GetRequiredService<IDbContextFactory<AppDbContext>>().CreateDbContext());

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

            // Add VNPAY service
            services.AddScoped<IVnPayService, VnPayService>();

            // Add mail service
            services.AddMailService(configuration);

            return services;
        }

        private static IServiceCollection AddMailService(this IServiceCollection services, IConfiguration configuration)
        {
            var smtpClientOptions = new SmtpClientOptions();
            configuration.GetSection(nameof(SmtpClientOptions)).Bind(smtpClientOptions);
            services.Configure<SmtpClientOptions>(configuration.GetSection(nameof(SmtpClientOptions)));

            services.AddSingleton(smtpClientOptions);
            services.AddScoped<IMailService, MailService>();

            // configure your sender and template choices with dependency injection.
            services.AddFluentEmail(smtpClientOptions.User)
                .AddRazorRenderer()
                .AddMailKitSender(smtpClientOptions);

            return services;
        }
    }
}
