using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class GetMovieByIdQuery : IRequest<ServiceResult>
    {
        public string Id { get; set; } = null!;
    }

    public class GetMovieByIdQueryHandler : IRequestHandler<GetMovieByIdQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetMovieByIdQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetMovieByIdQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var item = await _context.Movies
                .Include(m => m.MovieCategories)
                    .ThenInclude(mc => mc.Category)
                .Where(m => !m.DeleteFlag)
                .FirstOrDefaultAsync(m => m.Id == request.Id, cancellationToken);

                if (item == null)
                    return new ServiceResult(false, string.Format(MessageResouces.NotExisted, CategoryResources.CategoryName));

                return new ServiceResult(true, "", item);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }
    }
}
