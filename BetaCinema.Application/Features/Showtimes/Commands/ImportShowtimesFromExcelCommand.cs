using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.DTOs;
using BetaCinema.Domain.Exceptions;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;
using System.Data;
using System.Globalization;

namespace BetaCinema.Application.Features.Showtimes.Commands
{
    public class ImportShowtimesFromExcelCommand : IRequest<ServiceResult>
    {
        public ImportRequest ImportRequest { get; set; }
    }

    /// <summary>
    /// Xử lý yêu cầu (request) để nhập dữ liệu phim từ file Excel
    /// </summary>
    internal sealed class ImportShowtimesFromExcelCommandHandler : IRequestHandler<ImportShowtimesFromExcelCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public ImportShowtimesFromExcelCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(ImportShowtimesFromExcelCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var mappers = new Dictionary<string, Func<DataRow, ShowtimeImport, object>>
                {
                    {
                        MovieResources.MovieName,
                        (row, item) => item.MovieName = row[MovieResources.MovieName].ToString()
                    },
                    {
                        CinemaResources.CinemaName,
                        (row, item) => item.CinemaName = row[CinemaResources.CinemaName].ToString()
                    },
                    {
                        ShowtimeResources.StartTime,
                        (row, item) =>
                        {
                            if (DateTime.TryParseExact(row[ShowtimeResources.StartTime].ToString(), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime result))
                            {
                                item.StartTime = result;
                            }
                            return new object();
                        }
                    },
                    {
                        ShowtimeResources.TicketPrice,
                        (row, item) => item.TicketPrice = Convert.ToInt32(row[ShowtimeResources.TicketPrice])
                    }
                };

                var stream = new MemoryStream(request.ImportRequest.Data);
                var result = await ImportFromExcelHelper<ShowtimeImport>.ImportAsync(stream, mappers, "Sheet1");

                var showtimeImports = result.ToList();

                // Validate
                foreach (var showtimeImport in showtimeImports)
                {
                    var validateResult = await ValidateAsync(showtimeImport);

                    if (validateResult.Any())
                    {
                        return new ServiceResult(false, validateResult.First());
                    }
                }

                // Get showtimes list
                var showtimes = new List<Showtime>();
                foreach (var showtimeImport in showtimeImports)
                {
                    var movie = await _context.Movies
                    .Where(m => !m.DeleteFlag)
                    .FirstOrDefaultAsync(m => m.MovieName.ToLower() == showtimeImport.MovieName.ToLower(), cancellationToken);

                    var cinema = await _context.Cinemas
                        .Where(c => !c.DeleteFlag)
                        .FirstOrDefaultAsync(c => c.CinemaName.ToLower() == showtimeImport.CinemaName.ToLower(), cancellationToken);

                    showtimes.Add(new Showtime
                    {
                        Id = Guid.NewGuid().ToString(),
                        MovieId = movie.Id,
                        CinemaId = cinema.Id,
                        StartTime = showtimeImport.StartTime,
                        TicketPrice = showtimeImport.TicketPrice,
                        DeleteFlag = false,
                        CreatedDate = DateTime.Now,
                        ModifiedDate = DateTime.Now
                    });
                }

                _context.Showtimes.AddRange(showtimes);

                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception ex)
            {
                return new ServiceResult(false,
                    ex is BaseException baseEx ? baseEx.UserMessage : ErrorResources.UnhandledError);
            }
        }

        private async Task<List<string>> ValidateAsync(ShowtimeImport showtimeImport)
        {
            var errors = new List<string>();

            // Validate MovieName
            if (string.IsNullOrWhiteSpace(showtimeImport.MovieName))
            {
                errors.Add(string.Format(MessageResouces.Required, MovieResources.MovieName));
            }
            else
            {
                var searchResult = await _context.Movies
                   .Where(m => !m.DeleteFlag)
                   .FirstOrDefaultAsync(m => m.MovieName.ToLower() == showtimeImport.MovieName.ToLower());

                if (searchResult == null)
                    errors.Add(string.Format(MessageResouces.NotExisted, MovieResources.MovieName));
            }

            // Validate CinemaName
            if (string.IsNullOrWhiteSpace(showtimeImport.CinemaName))
            {
                errors.Add(string.Format(MessageResouces.Required, CinemaResources.CinemaName));
            }
            else
            {
                var searchResult = await _context.Cinemas
                   .Where(c => !c.DeleteFlag)
                   .FirstOrDefaultAsync(c => c.CinemaName.ToLower() == showtimeImport.CinemaName.ToLower());

                if (searchResult == null)
                    errors.Add(string.Format(MessageResouces.NotExisted, CinemaResources.CinemaName));
            }

            // Check duplicated showtime by movieId and cinemaId
            if (!string.IsNullOrWhiteSpace(showtimeImport.MovieName) && !string.IsNullOrWhiteSpace(showtimeImport.CinemaName))
            {
                var movie = await _context.Movies
                    .Where(m => !m.DeleteFlag)
                    .FirstOrDefaultAsync(m => m.MovieName.ToLower() == showtimeImport.MovieName.ToLower());

                var cinema = await _context.Cinemas
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(c => c.CinemaName.ToLower() == showtimeImport.CinemaName.ToLower());

                var showtimeExists = _context.Showtimes
                    .Any(s => s.MovieId == movie.Id && s.CinemaId == cinema.Id && s.StartTime == showtimeImport.StartTime);

                if (showtimeExists)
                {
                    errors.Add(string.Format(MessageResouces.Duplicated, ShowtimeResources.StartTime));
                }
            }

            // Validate StartTime
            if (!showtimeImport.StartTime.HasValue)
            {
                errors.Add(string.Format(MessageResouces.Required, ShowtimeResources.StartTime));
            }
            else if (showtimeImport.StartTime.Value < DateTime.Now)
            {
                errors.Add(string.Format(MessageResouces.GreaterThanNow, ShowtimeResources.StartTime));
            }

            // Validate TicketPrice
            if (showtimeImport.TicketPrice <= 0)
            {
                errors.Add(string.Format(MessageResouces.GreaterThan0, ShowtimeResources.TicketPrice));
            }

            return errors;
        }
    }
}
