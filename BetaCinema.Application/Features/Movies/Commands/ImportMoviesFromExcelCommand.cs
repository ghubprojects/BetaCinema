using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Models;
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
        private readonly IUnitOfWork _unitOfWork;

        public ImportMoviesFromExcelCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<ServiceResult> Handle(ImportMoviesFromExcelCommand request, CancellationToken cancellationToken)
        {
            var stream = new MemoryStream(request.ImportRequest.Data);
            var result = (await ImportFromExcelHelper<Movie>.ImportAsync(stream, mappers: new Dictionary<string, Func<DataRow, Movie, object>>
            {
                { "MovieName", (row,item) => item.MovieName = row["MovieName"].ToString() },
                { "Poster", (row, item) => item.Poster = row["Poster"]?.ToString() },
                { "Duration", (row, item) => item.Duration = Convert.ToInt32(row["Duration"]) },
                { "ReleaseDate", (row, item) => item.ReleaseDate = DateTime.Parse(row["ReleaseDate"].ToString()) },
                { "Director", (row, item) => item.Director = row["Director"]?.ToString() },
                { "Actor", (row, item) => item.Actor = row["Actor"]?.ToString() },
                { "Description", (row, item) => item.Description = row["Description"]?.ToString() },
            }, "Sheet1"));

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
            }).ToList();

            await _unitOfWork.Repository<Movie>().AddMultipleAsync(movies);

            return new ServiceResult(true);
        }
    }
}
