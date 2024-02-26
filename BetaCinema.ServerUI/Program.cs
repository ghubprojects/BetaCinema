using BetaCinema.Application;
using BetaCinema.Infrastructure;
using BetaCinema.Infrastructure.Persistence;
using BetaCinema.ServerUI.Hubs;
using BetaCinema.ServerUI.Middlewares;
using Hangfire;
using MudBlazor.Services;

var builder = WebApplication.CreateBuilder(args);
{
    // Add services to the container.
    builder.Services.AddRazorPages();
    builder.Services.AddServerSideBlazor();

    // Add signalR hubs
    builder.Services.AddSignalR();

    // Add Mudblazor
    builder.Services.AddMudServices(config =>
    {
        config.SnackbarConfiguration.PositionClass = Defaults.Classes.Position.BottomRight;
        config.SnackbarConfiguration.PreventDuplicates = false;
        config.SnackbarConfiguration.NewestOnTop = true;
        config.SnackbarConfiguration.ShowCloseIcon = true;
        config.SnackbarConfiguration.VisibleStateDuration = 5000;
        config.SnackbarConfiguration.HideTransitionDuration = 300;
        config.SnackbarConfiguration.ShowTransitionDuration = 300;
        config.SnackbarConfiguration.SnackbarVariant = Variant.Filled;
    });

    // Register Fluxor
    builder.Services.AddFluxor(options =>
    {
        options.ScanAssemblies(typeof(Program).Assembly);
        //options.UseReduxDevTools();
    });

    builder.Services.AddInfrastructure(builder.Configuration).AddApplication();
}

var app = builder.Build();
{
    // Configure the HTTP request pipeline.
    if (!app.Environment.IsDevelopment())
    {
        app.UseExceptionHandler("/Error");
        // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
        app.UseHsts();
    }

    // Seeding database
    using (var scope = app.Services.CreateScope())
    {
        var initializer = scope.ServiceProvider.GetService<AppDbContextSeeder>();
        await initializer.InitilizeAsync();
    };

    app.UseHttpsRedirection();

    app.UseStaticFiles();

    app.UseRouting();

    app.UseAuthentication();
    app.UseAuthorization();

    // Using hubs 
    app.MapBlazorHub();
    app.MapHub<ProcessSeatHub>("/signalRHub");
    app.MapFallbackToPage("/_Host");

    // Using hangfire
    app.UseHangfireDashboard(); //Will be available under http://localhost:5000/hangfire"
    app.UseHangfireServer();

    app.UseMiddleware<ErrorHandlerMiddleware>();

    app.Run();
}
