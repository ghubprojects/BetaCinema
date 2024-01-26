using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class UpdateMovieCommand : IRequest<ServiceResult>
    {
        public Movie OldData { get; set; }
        public Movie MovieInfo { get; set; }
        public List<string> Categories { get; set; }
    }

    public class UpdateMovieCommandHandler : IRequestHandler<UpdateMovieCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public UpdateMovieCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(UpdateMovieCommand request, CancellationToken cancellationToken)
        {
            // Validate
            var validateResult = await ValidateAsync(request.MovieInfo, request.OldData, request.Categories);

            if (validateResult.Any())
            {
                return new ServiceResult(false, validateResult.First());
            }
            else
            {
                try
                {
                    // Update Movie Info
                    request.MovieInfo.ModifiedDate = DateTime.Now;
                    _context.Entry(request.MovieInfo).State = EntityState.Modified;

                    // Update categories for the movie
                    var existingCategories = await _context.MovieCategories
                        .Where(mc => mc.MovieId == request.MovieInfo.Id)
                        .ToListAsync();

                    // Remove existing categories
                    _context.MovieCategories.RemoveRange(existingCategories);

                    // Add new categories
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

        private async Task<List<string>> ValidateAsync(Movie movie, Movie old, List<string> categories)
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
            if (movie.ReleaseDate.HasValue && movie.ReleaseDate.Value != old.ReleaseDate.Value && movie.ReleaseDate.Value < DateTime.Now)
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
