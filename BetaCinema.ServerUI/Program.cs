using BetaCinema.Application;
using BetaCinema.Domain.Exceptions;
using BetaCinema.Infrastructure;
using BetaCinema.Infrastructure.Persistence;
using BetaCinema.ServerUI.Middlewares;
using Fluxor;
using MudBlazor;
using MudBlazor.Services;

var builder = WebApplication.CreateBuilder(args);
{
    // Add services to the container.
    builder.Services.AddRazorPages();
    builder.Services.AddServerSideBlazor();

    builder.Services.AddMudServices(config =>
    {
        config.SnackbarConfiguration.PositionClass = Defaults.Classes.Position.BottomRight;
        config.SnackbarConfiguration.ShowCloseIcon = true;
        config.SnackbarConfiguration.VisibleStateDuration = 3000;
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

    builder.Services.AddMvc().ConfigureApiBehaviorOptions(options =>
    {
        options.InvalidModelStateResponseFactory = context =>
        {
            throw new ValidateException()
            {
                ErrorCode = StatusCodes.Status400BadRequest,
                UserMessage = "Yêu cầu không hợp lệ",
                DevMessage = "Bad request",
                TraceId = context.HttpContext.TraceIdentifier,
                Errors = context.ModelState.ToDictionary(kvp => kvp.Key, kvp => kvp.Value.Errors.Select(error => error.ErrorMessage).ToArray())
            };
        };
    });
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

    app.MapBlazorHub();
    app.MapFallbackToPage("/_Host");

    app.UseMiddleware<ErrorHandlerMiddleware>();

    app.Run();
}
