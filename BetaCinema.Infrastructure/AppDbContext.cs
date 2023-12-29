using BetaCinema.Domain.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Infrastructure
{
    public partial class AppDbContext : IdentityDbContext<User>
    {
        public AppDbContext()
        {
        }

        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Category> Categories { get; set; }

        public virtual DbSet<Cinema> Cinemas { get; set; }

        public virtual DbSet<Movie> Movies { get; set; }

        public virtual DbSet<MovieCategory> MovieCategories { get; set; }

        public virtual DbSet<Payment> Payments { get; set; }

        public virtual DbSet<Reservation> Reservations { get; set; }

        public virtual DbSet<ReservationItem> ReservationItems { get; set; }

        public virtual DbSet<Seat> Seats { get; set; }

        public virtual DbSet<Showtime> Showtimes { get; set; }

        public virtual DbSet<User> Users { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
            => optionsBuilder.UseNpgsql("Server=localhost;Port=5432;Database=beta_cinema;Uid=postgres;Pwd=MyAl1705!!!;");

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Bỏ tiền tố AspNet của các bảng: mặc định các bảng trong IdentityDbContext có
            // tên với tiền tố AspNet như: AspNetUserRoles, AspNetUser ...
            // Đoạn mã sau chạy khi khởi tạo DbContext, tạo database sẽ loại bỏ tiền tố đó
            foreach (var entityType in modelBuilder.Model.GetEntityTypes())
            {
                var tableName = entityType.GetTableName();
                if (tableName.StartsWith("AspNet"))
                {
                    entityType.SetTableName(tableName.Substring(6));
                }
            }

            modelBuilder.Entity<Category>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("category_pkey");

                entity.ToTable("Category");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever();
                entity.Property(e => e.CategoryName)
                    .HasMaxLength(255);
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.DeleteFlag);
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone");
            });

            modelBuilder.Entity<Cinema>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("cinema_pkey");

                entity.ToTable("Cinema");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever();
                entity.Property(e => e.CinemaLocation)
                    .HasMaxLength(255);
                entity.Property(e => e.CinemaName)
                    .HasMaxLength(50);
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.DeleteFlag);
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone");
            });

            modelBuilder.Entity<Movie>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("movie_pkey");

                entity.ToTable("Movie");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever();
                entity.Property(e => e.Actor)
                    .HasMaxLength(255)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.DeleteFlag);
                entity.Property(e => e.Description);
                entity.Property(e => e.Director)
                    .HasMaxLength(255)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.Duration);
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.MovieName)
                    .HasMaxLength(255);
                entity.Property(e => e.Poster);
                entity.Property(e => e.ReleaseDate)
                    .HasDefaultValueSql("now()")
                    .HasColumnType("timestamp without time zone");
            });

            modelBuilder.Entity<MovieCategory>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("movie_category_pkey");

                entity.ToTable("MovieCategory");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever();
                entity.Property(e => e.CategoryId);
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.DeleteFlag);
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.MovieId);

                entity.HasOne(d => d.Category).WithMany(p => p.MovieCategories)
                    .HasForeignKey(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_movie_category_category_id");

                entity.HasOne(d => d.Movie).WithMany(p => p.MovieCategories)
                    .HasForeignKey(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_movie_category_movie_id");
            });

            modelBuilder.Entity<Payment>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("payment_pkey");

                entity.ToTable("Payment");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever();
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.DeleteFlag);
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.PaymentMethod)
                    .HasMaxLength(255);
                entity.Property(e => e.ReservationId);
                entity.Property(e => e.TotalPrice);

                entity.HasOne(d => d.Reservation).WithMany(p => p.Payments)
                    .HasForeignKey(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_payment_reservation_id");
            });

            modelBuilder.Entity<Reservation>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("reservation_pkey");

                entity.ToTable("Reservation");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever();
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.DeleteFlag);
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.ShowtimeId);
                entity.Property(e => e.UserId);

                entity.HasOne(d => d.Showtime).WithMany(p => p.Reservations)
                    .HasForeignKey(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_reservation_showtime_id");

                entity.HasOne(d => d.User).WithMany(p => p.Reservations)
                    .HasForeignKey(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_reservation_user_id");
            });

            modelBuilder.Entity<ReservationItem>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("reservation_item_pkey");

                entity.ToTable("ReservationItem");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever();
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.DeleteFlag);
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.ReservationId);
                entity.Property(e => e.SeatId);

                entity.HasOne(d => d.Reservation).WithMany(p => p.ReservationItems)
                    .HasForeignKey(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_reservation_item_reservation_id");

                entity.HasOne(d => d.Seat).WithMany(p => p.ReservationItems)
                    .HasForeignKey(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_reservation_item_seat_id");
            });

            modelBuilder.Entity<Seat>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("seat_pkey");

                entity.ToTable("Seat");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever();
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.DeleteFlag);
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.RowNum)
                    .HasMaxLength(1);
                entity.Property(e => e.SeatNum);
            });

            modelBuilder.Entity<Showtime>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("showtime_pkey");

                entity.ToTable("Showtime");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever();
                entity.Property(e => e.CinemaId);
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.DeleteFlag);
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.MovieId);
                entity.Property(e => e.StartTime)
                    .HasDefaultValueSql("now()")
                    .HasColumnType("timestamp without time zone");

                entity.Property(e => e.TicketPrice);
                entity.HasOne(d => d.Cinema).WithMany(p => p.Showtimes)
                    .HasForeignKey(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_showtime_cinema_id");

                entity.HasOne(d => d.Movie).WithMany(p => p.Showtimes)
                    .HasForeignKey(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_showtime_movie_id");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("user_pkey");

                entity.ToTable("User");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever();
                entity.Property(e => e.Avatar);
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.CreatedDate)
                    .HasDefaultValueSql("now()")
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.DeleteFlag);
                entity.Property(e => e.Email)
                    .HasMaxLength(100);
                entity.Property(e => e.FullName)
                    .HasMaxLength(100);
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying");
                entity.Property(e => e.ModifiedDate)
                    .HasDefaultValueSql("now()")
                    .HasColumnType("timestamp without time zone");
                entity.Property(e => e.Password)
                    .HasMaxLength(100);
                entity.Property(e => e.Role)
                    .HasMaxLength(25);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
