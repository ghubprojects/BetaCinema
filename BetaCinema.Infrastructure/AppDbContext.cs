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

                entity.ToTable("category");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");
                entity.Property(e => e.CategoryName)
                    .HasMaxLength(255)
                    .HasColumnName("category_name");
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("created_by");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("created_date");
                entity.Property(e => e.DeleteFlag).HasColumnName("delete_flag");
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("modified_by");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("modified_date");
            });

            modelBuilder.Entity<Cinema>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("cinema_pkey");

                entity.ToTable("cinema");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");
                entity.Property(e => e.CinemaLocation)
                    .HasMaxLength(255)
                    .HasColumnName("cinema_location");
                entity.Property(e => e.CinemaName)
                    .HasMaxLength(50)
                    .HasColumnName("cinema_name");
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("created_by");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("created_date");
                entity.Property(e => e.DeleteFlag).HasColumnName("delete_flag");
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("modified_by");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("modified_date");
            });

            modelBuilder.Entity<Movie>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("movie_pkey");

                entity.ToTable("movie");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");
                entity.Property(e => e.Actor)
                    .HasMaxLength(255)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("actor");
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("created_by");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("created_date");
                entity.Property(e => e.DeleteFlag).HasColumnName("delete_flag");
                entity.Property(e => e.Description).HasColumnName("description");
                entity.Property(e => e.Director)
                    .HasMaxLength(255)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("director");
                entity.Property(e => e.Duration).HasColumnName("duration");
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("modified_by");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("modified_date");
                entity.Property(e => e.MovieName)
                    .HasMaxLength(255)
                    .HasColumnName("movie_name");
                entity.Property(e => e.Poster).HasColumnName("poster");
                entity.Property(e => e.ReleaseDate).HasColumnName("release_date");
            });

            modelBuilder.Entity<MovieCategory>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("movie_category_pkey");

                entity.ToTable("movie_category");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");
                entity.Property(e => e.CategoryId).HasColumnName("category_id");
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("created_by");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("created_date");
                entity.Property(e => e.DeleteFlag).HasColumnName("delete_flag");
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("modified_by");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("modified_date");
                entity.Property(e => e.MovieId).HasColumnName("movie_id");

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

                entity.ToTable("payment");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("created_by");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("created_date");
                entity.Property(e => e.DeleteFlag).HasColumnName("delete_flag");
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("modified_by");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("modified_date");
                entity.Property(e => e.PaymentMethod)
                    .HasMaxLength(255)
                    .HasColumnName("payment_method");
                entity.Property(e => e.ReservationId).HasColumnName("reservation_id");
                entity.Property(e => e.TotalPrice).HasColumnName("total_price");

                entity.HasOne(d => d.Reservation).WithMany(p => p.Payments)
                    .HasForeignKey(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_payment_reservation_id");
            });

            modelBuilder.Entity<Reservation>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("reservation_pkey");

                entity.ToTable("reservation");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("created_by");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("created_date");
                entity.Property(e => e.DeleteFlag).HasColumnName("delete_flag");
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("modified_by");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("modified_date");
                entity.Property(e => e.ShowtimeId).HasColumnName("showtime_id");
                entity.Property(e => e.UserId).HasColumnName("user_id");

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

                entity.ToTable("reservation_item");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("created_by");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("created_date");
                entity.Property(e => e.DeleteFlag).HasColumnName("delete_flag");
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("modified_by");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("modified_date");
                entity.Property(e => e.ReservationId).HasColumnName("reservation_id");
                entity.Property(e => e.SeatId).HasColumnName("seat_id");

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

                entity.ToTable("seat");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("created_by");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("created_date");
                entity.Property(e => e.DeleteFlag).HasColumnName("delete_flag");
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("modified_by");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("modified_date");
                entity.Property(e => e.RowNum)
                    .HasMaxLength(1)
                    .HasColumnName("row_num");
                entity.Property(e => e.SeatNum).HasColumnName("seat_num");
            });

            modelBuilder.Entity<Showtime>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("showtime_pkey");

                entity.ToTable("showtime");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");
                entity.Property(e => e.CinemaId).HasColumnName("cinema_id");
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("created_by");
                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("created_date");
                entity.Property(e => e.DeleteFlag).HasColumnName("delete_flag");
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("modified_by");
                entity.Property(e => e.ModifiedDate)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("modified_date");
                entity.Property(e => e.MovieId).HasColumnName("movie_id");
                entity.Property(e => e.StartTime)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("start_time");
                entity.Property(e => e.TicketPrice).HasColumnName("ticket_price");

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

                entity.ToTable("user");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");
                entity.Property(e => e.Avatar).HasColumnName("avatar");
                entity.Property(e => e.CreatedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("created_by");
                entity.Property(e => e.CreatedDate)
                    .HasDefaultValueSql("now()")
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("created_date");
                entity.Property(e => e.DeleteFlag).HasColumnName("delete_flag");
                entity.Property(e => e.Email)
                    .HasMaxLength(100)
                    .HasColumnName("email");
                entity.Property(e => e.Fullname)
                    .HasMaxLength(100)
                    .HasColumnName("fullname");
                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(100)
                    .HasDefaultValueSql("NULL::character varying")
                    .HasColumnName("modified_by");
                entity.Property(e => e.ModifiedDate)
                    .HasDefaultValueSql("now()")
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("modified_date");
                entity.Property(e => e.Password)
                    .HasMaxLength(25)
                    .HasColumnName("password");
                entity.Property(e => e.Role)
                    .HasMaxLength(25)
                    .HasColumnName("role");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
