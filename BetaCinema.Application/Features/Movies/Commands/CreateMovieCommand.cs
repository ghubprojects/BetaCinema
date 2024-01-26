using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class CreateMovieCommand : IRequest<ServiceResult>
    {
        public Movie MovieInfo { get; set; }
        public List<string> Categories { get; set; }
    }

    public class CreateMovieCommandHandler : IRequestHandler<CreateMovieCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public CreateMovieCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(CreateMovieCommand request, CancellationToken cancellationToken)
        {
            // Validate
            var validateResult = await ValidateAsync(request.MovieInfo, request.Categories);

            if (validateResult.Any())
            {
                return new ServiceResult(false, validateResult.First());
            }
            else
            {
                try
                {
                    // Add Movie Info
                    request.MovieInfo.Id = Guid.NewGuid().ToString();
                    request.MovieInfo.DeleteFlag = false;
                    request.MovieInfo.CreatedDate = DateTime.Now;
                    request.MovieInfo.ModifiedDate = DateTime.Now;

                    _context.Movies.Add(request.MovieInfo);


                    // Add movie categories
                    foreach (var categoryName in request.Categories)
                    {
                        var category = await _context.Categories
                            .FirstOrDefaultAsync(c => c.CategoryName == categoryName);

                        if (category != null)
                        {
                            var movieCategory = new MovieCategory
                            {
                                Id = Guid.NewGuid().ToString(),
                                MovieId = request.MovieInfo.Id,
                                CategoryId = category.Id,
                                CreatedDate = DateTime.Now,
                                ModifiedDate = DateTime.Now
                            };

                            _context.MovieCategories.Add(movieCategory);
                        }
                    }

                    await _context.SaveChangesAsync(cancellationToken);

                    return new ServiceResult(true);
                }
                catch (Exception)
                {
                    return new ServiceResult(false, "Có lỗi xảy ra khi cập nhật phim và thể loại.");
                }
            }
        }

        private async Task<List<string>> ValidateAsync(Movie movie, List<string> categories)
        {
            var errors = new List<string>();

            // Validate MovieName
            if (string.IsNullOrWhiteSpace(movie.MovieName))
            {
                errors.Add(string.Format(MessageResouces.Required, MovieResources.MovieName));
            }

            // Validate Duration
            if (movie.Duration <= 0)
            {
                errors.Add(string.Format(MessageResouces.GreaterThan0, MovieResources.Duration));
            }

            // Validate ReleaseDate
            if (movie.ReleaseDate.HasValue && movie.ReleaseDate.Value < DateTime.Now)
            {
                errors.Add(string.Format(MessageResouces.GreaterThanNow, MovieResources.ReleaseDate));
            }

            // Validate Category List
            if (categories.Count > 0)
            {
                foreach (var categoryName in categories)
                {
                    var category = await _context.Categories
                        .FirstOrDefaultAsync(c => c.CategoryName == categoryName);

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
