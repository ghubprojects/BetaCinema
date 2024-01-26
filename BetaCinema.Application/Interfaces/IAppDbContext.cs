using BetaCinema.Domain.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace BetaCinema.Application.Interfaces
{
    public interface IAppDbContext
    {
        DbSet<Category> Categories { get; set; }

        DbSet<Cinema> Cinemas { get; set; }

        DbSet<Movie> Movies { get; set; }

        DbSet<MovieCategory> MovieCategories { get; set; }

        DbSet<Payment> Payments { get; set; }

        DbSet<Reservation> Reservations { get; set; }

        DbSet<ReservationItem> ReservationItems { get; set; }

        DbSet<Seat> Seats { get; set; }

        DbSet<Showtime> Showtimes { get; set; }

        DbSet<User> Users { get; set; }

        EntityEntry Entry(object entity);

        Task<int> SaveChangesAsync(CancellationToken cancellationToken);
    }
}

