using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using System.Data;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class ImportMoviesFromExcelCommand : IRequest<ServiceResult>
    {
        public ImportRequest ImportRequest { get; set; }
    }

    /// <summary>
    /// Xử lý yêu cầu (request) để nhập dữ liệu phim từ file Excel
    /// </summary>
    internal sealed class ImportMoviesFromExcelCommandHandler : IRequestHandler<ImportMoviesFromExcelCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public ImportMoviesFromExcelCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(ImportMoviesFromExcelCommand request, CancellationToken cancellationToken)
        {
            var mappers = new Dictionary<string, Func<DataRow, Movie, object>>
            {
                {
                    MovieResources.MovieName,
                    (row, item) => item.MovieName = row[MovieResources.MovieName].ToString()
                },
                {
                    MovieResources.Duration,
                    (row, item) => item.Duration = Convert.ToInt32(row[MovieResources.Duration])
                },
                {
                    MovieResources.ReleaseDate,
                    (row, item) => item.ReleaseDate = DateTime.Parse(row[MovieResources.ReleaseDate].ToString())
                },
                {
                    MovieResources.Director,
                    (row, item) => item.Director = row[MovieResources.Director]?.ToString()
                },
                {
                    MovieResources.Actor,
                    (row, item) => item.Actor = row[MovieResources.Actor]?.ToString()
                },
                {
                    MovieResources.Description,
                    (row, item) => item.Description = row[MovieResources.Description]?.ToString()
                },
            };

            var stream = new MemoryStream(request.ImportRequest.Data);
            var result = (await ImportFromExcelHelper<Movie>.ImportAsync(stream, mappers, "Sheet1"));

            var movies = result.Select(data => new Movie
            {
                Id = Guid.NewGuid().ToString(),
                MovieName = data.MovieName,
                Poster = data.Poster,
                Duration = data.Duration,
                ReleaseDate = data.ReleaseDate,
                Director = data.Director,
                Actor = data.Actor,
                Description = data.Description,
                DeleteFlag = false,
                CreatedDate = DateTime.Now,
                ModifiedDate = DateTime.Now
            }).ToList();

            _context.Movies.AddRange(movies);
            await _context.SaveChangesAsync(cancellationToken);
            return new ServiceResult(true);
        }
    }
}
