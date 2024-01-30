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
        public Movie OldData { get; set; } = null!;

        public Movie Data { get; set; } = null!;

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
            try
            {
                // Validate
                var validateResult = await ValidateAsync(request.Data, request.OldData, request.Categories);

                // If errors, return false
                if (validateResult.Any())
                    return new ServiceResult(false, validateResult.First());

                // Update item
                request.Data.ModifiedDate = DateTime.Now;
                _context.Entry(request.Data).State = EntityState.Modified;

                // Update categories for the movie
                var existingCategories = await _context.MovieCategories
                    .Where(mc => mc.MovieId == request.Data.Id)
                    .ToListAsync(cancellationToken);

                // Remove existing categories
                _context.MovieCategories.RemoveRange(existingCategories);

                // Add new categories
                foreach (var categoryName in request.Categories)
                {
                    var category = await _context.Categories
                        .Where(c => !c.DeleteFlag)
                        .FirstOrDefaultAsync(c => c.CategoryName.ToLower() == categoryName.ToLower());

                    _context.MovieCategories.Add(new MovieCategory
                    {
                        Id = Guid.NewGuid().ToString(),
                        MovieId = request.Data.Id,
                        CategoryId = category.Id,
                        CreatedDate = DateTime.Now,
                        ModifiedDate = DateTime.Now
                    });
                }

                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }

        private async Task<List<string>> ValidateAsync(Movie data, Movie old, List<string> categories)
        {
            var errors = new List<string>();

            // Validate MovieName
            if (string.IsNullOrWhiteSpace(data.MovieName))
            {
                errors.Add(string.Format(MessageResouces.Required, MovieResources.MovieName));
            }

            // Validate Duration
            if (data.Duration <= 0)
            {
                errors.Add(string.Format(MessageResouces.GreaterThan0, MovieResources.Duration));
            }

            // Validate ReleaseDate
            if (data.ReleaseDate.HasValue && data.ReleaseDate.Value != old.ReleaseDate.Value && data.ReleaseDate.Value < DateTime.Now)
            {
                errors.Add(string.Format(MessageResouces.GreaterThanNow, MovieResources.ReleaseDate));
            }

            // Validate Category List
            if (categories.Count > 0)
            {
                foreach (var categoryName in categories)
                {
                    var category = await _context.Categories
                        .Where(c => !c.DeleteFlag)
                        .FirstOrDefaultAsync(c => c.CategoryName.ToLower() == categoryName.ToLower());

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
