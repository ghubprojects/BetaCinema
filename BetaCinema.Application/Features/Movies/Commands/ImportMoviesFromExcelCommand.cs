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
            try
            {
                var mappers = new Dictionary<string, Func<DataRow, MovieImport, object>>
                {
                    {
                        MovieResources.MovieName,
                        (row, item) => item.MovieName = row[MovieResources.MovieName].ToString()
                    },
                    {
                        CategoryResources.CategoryName,
                        (row, item) => item.Categories = row[CategoryResources.CategoryName].ToString().Split(',').ToList()
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
                        (row, item) => item.Director = row[MovieResources.Director].ToString()
                    },
                    {
                        MovieResources.Actor,
                        (row, item) => item.Actor = row[MovieResources.Actor].ToString()
                    },
                    {
                        MovieResources.Description,
                        (row, item) => item.Description = row[MovieResources.Description].ToString()
                    }
                };

                var stream = new MemoryStream(request.ImportRequest.Data);
                var result = await ImportFromExcelHelper<MovieImport>.ImportAsync(stream, mappers, "Sheet1");

                var movieImports = result.ToList();

                // Add multiple movies to database
                foreach (var movieImport in movieImports)
                {
                    // Validate
                    var validateResult = await ValidateAsync(movieImport);

                    if (validateResult.Any())
                    {
                        return new ServiceResult(false, validateResult.First());
                    }

                    var movie = new Movie
                    {
                        Id = Guid.NewGuid().ToString(),
                        MovieName = movieImport.MovieName,
                        Duration = movieImport.Duration,
                        ReleaseDate = movieImport.ReleaseDate,
                        Director = movieImport.Director,
                        Actor = movieImport.Actor,
                        Description = movieImport.Description,
                        DeleteFlag = false,
                        CreatedDate = DateTime.Now,
                        ModifiedDate = DateTime.Now
                    };

                    _context.Movies.Add(movie);

                    // Add movie categories
                    foreach (var categoryName in movieImport.Categories)
                    {
                        var category = await _context.Categories
                            .Where(c => !c.DeleteFlag)
                            .FirstOrDefaultAsync(c => c.CategoryName.ToLower() == categoryName.Trim().ToLower(), cancellationToken);

                        if (category != null)
                        {
                            var movieCategory = new MovieCategory
                            {
                                Id = Guid.NewGuid().ToString(),
                                MovieId = movie.Id,
                                CategoryId = category.Id,
                                CreatedDate = DateTime.Now,
                                ModifiedDate = DateTime.Now
                            };

                            _context.MovieCategories.Add(movieCategory);
                        }
                    }
                }

                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception ex)
            {
                return new ServiceResult(false,
                    ex is BaseException baseEx ? baseEx.UserMessage : ErrorResources.UnhandledError);
            }
        }

        private async Task<List<string>> ValidateAsync(MovieImport movieImport)
        {
            var errors = new List<string>();

            // Validate MovieName
            if (string.IsNullOrWhiteSpace(movieImport.MovieName))
            {
                errors.Add(string.Format(MessageResouces.Required, MovieResources.MovieName));
            }

            // Validate Duration
            if (movieImport.Duration <= 0)
            {
                errors.Add(string.Format(MessageResouces.GreaterThan0, MovieResources.Duration));
            }

            // Validate ReleaseDate
            if (movieImport.ReleaseDate.HasValue && movieImport.ReleaseDate.Value < DateTime.Now)
            {
                errors.Add(string.Format(MessageResouces.GreaterThanNow, MovieResources.ReleaseDate));
            }

            // Validate Category List
            if (movieImport.Categories.Count > 0)
            {
                foreach (var categoryName in movieImport.Categories)
                {
                    var category = await _context.Categories
                        .Where(c => !c.DeleteFlag)
                        .FirstOrDefaultAsync(c => c.CategoryName.ToLower() == categoryName.Trim().ToLower());

                    if (category == null)
                    {
                        errors.Add(string.Format(MessageResouces.NotExisted,
                            $"{MovieResources.Category} \"{categoryName}\""));
                    }
                }
            }

            return errors;
        }
    }
}
