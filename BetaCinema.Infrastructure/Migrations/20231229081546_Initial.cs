using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace BetaCinema.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class Initial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Category",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    CategoryName = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    DeleteFlag = table.Column<bool>(type: "boolean", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    CreatedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying"),
                    ModifiedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    ModifiedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying")
                },
                constraints: table =>
                {
                    table.PrimaryKey("category_pkey", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Cinema",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    CinemaName = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    CinemaLocation = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    DeleteFlag = table.Column<bool>(type: "boolean", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    CreatedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying"),
                    ModifiedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    ModifiedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying")
                },
                constraints: table =>
                {
                    table.PrimaryKey("cinema_pkey", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Movie",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    MovieName = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    Poster = table.Column<string>(type: "text", nullable: true),
                    Duration = table.Column<int>(type: "integer", nullable: false),
                    ReleaseDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: true, defaultValueSql: "now()"),
                    Director = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: true, defaultValueSql: "NULL::character varying"),
                    Actor = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: true, defaultValueSql: "NULL::character varying"),
                    Description = table.Column<string>(type: "text", nullable: true),
                    DeleteFlag = table.Column<bool>(type: "boolean", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    CreatedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying"),
                    ModifiedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    ModifiedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying")
                },
                constraints: table =>
                {
                    table.PrimaryKey("movie_pkey", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Roles",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    Name = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: true),
                    NormalizedName = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: true),
                    ConcurrencyStamp = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Roles", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Seat",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    RowNum = table.Column<string>(type: "character varying(1)", maxLength: 1, nullable: false),
                    SeatNum = table.Column<int>(type: "integer", nullable: false),
                    DeleteFlag = table.Column<bool>(type: "boolean", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    CreatedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying"),
                    ModifiedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    ModifiedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying")
                },
                constraints: table =>
                {
                    table.PrimaryKey("seat_pkey", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "User",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    FullName = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Password = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Role = table.Column<string>(type: "character varying(25)", maxLength: 25, nullable: false),
                    Avatar = table.Column<string>(type: "text", nullable: true),
                    DeleteFlag = table.Column<bool>(type: "boolean", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false, defaultValueSql: "now()"),
                    CreatedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying"),
                    ModifiedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false, defaultValueSql: "now()"),
                    ModifiedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying"),
                    UserName = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: true),
                    NormalizedUserName = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: true),
                    Email = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true),
                    NormalizedEmail = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: true),
                    EmailConfirmed = table.Column<bool>(type: "boolean", nullable: false),
                    PasswordHash = table.Column<string>(type: "text", nullable: true),
                    SecurityStamp = table.Column<string>(type: "text", nullable: true),
                    ConcurrencyStamp = table.Column<string>(type: "text", nullable: true),
                    PhoneNumber = table.Column<string>(type: "text", nullable: true),
                    PhoneNumberConfirmed = table.Column<bool>(type: "boolean", nullable: false),
                    TwoFactorEnabled = table.Column<bool>(type: "boolean", nullable: false),
                    LockoutEnd = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    LockoutEnabled = table.Column<bool>(type: "boolean", nullable: false),
                    AccessFailedCount = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("user_pkey", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "MovieCategory",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    MovieId = table.Column<string>(type: "text", nullable: false),
                    CategoryId = table.Column<string>(type: "text", nullable: false),
                    DeleteFlag = table.Column<bool>(type: "boolean", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    CreatedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying"),
                    ModifiedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    ModifiedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying")
                },
                constraints: table =>
                {
                    table.PrimaryKey("movie_category_pkey", x => x.Id);
                    table.ForeignKey(
                        name: "fk_movie_category_category_id",
                        column: x => x.Id,
                        principalTable: "Category",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "fk_movie_category_movie_id",
                        column: x => x.Id,
                        principalTable: "Movie",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Showtime",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    MovieId = table.Column<string>(type: "text", nullable: false),
                    CinemaId = table.Column<string>(type: "text", nullable: false),
                    StartTime = table.Column<DateTime>(type: "timestamp without time zone", nullable: true, defaultValueSql: "now()"),
                    TicketPrice = table.Column<int>(type: "integer", nullable: false),
                    DeleteFlag = table.Column<bool>(type: "boolean", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    CreatedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying"),
                    ModifiedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    ModifiedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying")
                },
                constraints: table =>
                {
                    table.PrimaryKey("showtime_pkey", x => x.Id);
                    table.ForeignKey(
                        name: "fk_showtime_cinema_id",
                        column: x => x.Id,
                        principalTable: "Cinema",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "fk_showtime_movie_id",
                        column: x => x.Id,
                        principalTable: "Movie",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "RoleClaims",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    RoleId = table.Column<string>(type: "text", nullable: false),
                    ClaimType = table.Column<string>(type: "text", nullable: true),
                    ClaimValue = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RoleClaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RoleClaims_Roles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "Roles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "UserClaims",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    UserId = table.Column<string>(type: "text", nullable: false),
                    ClaimType = table.Column<string>(type: "text", nullable: true),
                    ClaimValue = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserClaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_UserClaims_User_UserId",
                        column: x => x.UserId,
                        principalTable: "User",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "UserLogins",
                columns: table => new
                {
                    LoginProvider = table.Column<string>(type: "text", nullable: false),
                    ProviderKey = table.Column<string>(type: "text", nullable: false),
                    ProviderDisplayName = table.Column<string>(type: "text", nullable: true),
                    UserId = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserLogins", x => new { x.LoginProvider, x.ProviderKey });
                    table.ForeignKey(
                        name: "FK_UserLogins_User_UserId",
                        column: x => x.UserId,
                        principalTable: "User",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "UserRoles",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "text", nullable: false),
                    RoleId = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserRoles", x => new { x.UserId, x.RoleId });
                    table.ForeignKey(
                        name: "FK_UserRoles_Roles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "Roles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserRoles_User_UserId",
                        column: x => x.UserId,
                        principalTable: "User",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "UserTokens",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "text", nullable: false),
                    LoginProvider = table.Column<string>(type: "text", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Value = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserTokens", x => new { x.UserId, x.LoginProvider, x.Name });
                    table.ForeignKey(
                        name: "FK_UserTokens_User_UserId",
                        column: x => x.UserId,
                        principalTable: "User",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Reservation",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    ShowtimeId = table.Column<string>(type: "text", nullable: false),
                    UserId = table.Column<string>(type: "text", nullable: false),
                    DeleteFlag = table.Column<bool>(type: "boolean", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    CreatedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying"),
                    ModifiedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    ModifiedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying")
                },
                constraints: table =>
                {
                    table.PrimaryKey("reservation_pkey", x => x.Id);
                    table.ForeignKey(
                        name: "fk_reservation_showtime_id",
                        column: x => x.Id,
                        principalTable: "Showtime",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "fk_reservation_user_id",
                        column: x => x.Id,
                        principalTable: "User",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Payment",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    ReservationId = table.Column<string>(type: "text", nullable: false),
                    TotalPrice = table.Column<int>(type: "integer", nullable: false),
                    PaymentMethod = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    DeleteFlag = table.Column<bool>(type: "boolean", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    CreatedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying"),
                    ModifiedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    ModifiedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying")
                },
                constraints: table =>
                {
                    table.PrimaryKey("payment_pkey", x => x.Id);
                    table.ForeignKey(
                        name: "fk_payment_reservation_id",
                        column: x => x.Id,
                        principalTable: "Reservation",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ReservationItem",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    ReservationId = table.Column<string>(type: "text", nullable: false),
                    SeatId = table.Column<string>(type: "text", nullable: false),
                    DeleteFlag = table.Column<bool>(type: "boolean", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    CreatedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying"),
                    ModifiedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    ModifiedBy = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true, defaultValueSql: "NULL::character varying")
                },
                constraints: table =>
                {
                    table.PrimaryKey("reservation_item_pkey", x => x.Id);
                    table.ForeignKey(
                        name: "fk_reservation_item_reservation_id",
                        column: x => x.Id,
                        principalTable: "Reservation",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "fk_reservation_item_seat_id",
                        column: x => x.Id,
                        principalTable: "Seat",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_RoleClaims_RoleId",
                table: "RoleClaims",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "RoleNameIndex",
                table: "Roles",
                column: "NormalizedName",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "EmailIndex",
                table: "User",
                column: "NormalizedEmail");

            migrationBuilder.CreateIndex(
                name: "UserNameIndex",
                table: "User",
                column: "NormalizedUserName",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_UserClaims_UserId",
                table: "UserClaims",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_UserLogins_UserId",
                table: "UserLogins",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_UserRoles_RoleId",
                table: "UserRoles",
                column: "RoleId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "MovieCategory");

            migrationBuilder.DropTable(
                name: "Payment");

            migrationBuilder.DropTable(
                name: "ReservationItem");

            migrationBuilder.DropTable(
                name: "RoleClaims");

            migrationBuilder.DropTable(
                name: "UserClaims");

            migrationBuilder.DropTable(
                name: "UserLogins");

            migrationBuilder.DropTable(
                name: "UserRoles");

            migrationBuilder.DropTable(
                name: "UserTokens");

            migrationBuilder.DropTable(
                name: "Category");

            migrationBuilder.DropTable(
                name: "Reservation");

            migrationBuilder.DropTable(
                name: "Seat");

            migrationBuilder.DropTable(
                name: "Roles");

            migrationBuilder.DropTable(
                name: "Showtime");

            migrationBuilder.DropTable(
                name: "User");

            migrationBuilder.DropTable(
                name: "Cinema");

            migrationBuilder.DropTable(
                name: "Movie");
        }
    }
}
