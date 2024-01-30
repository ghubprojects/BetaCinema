using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Showtimes.Commands
{
    public class GetShowtimeByIdQuery : IRequest<ServiceResult>
    {
        public string Id { get; set; } = null!;
    }

    public class GetShowtimeByIdQueryHandler : IRequestHandler<GetShowtimeByIdQuery, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public GetShowtimeByIdQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(GetShowtimeByIdQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var item = await _context.Showtimes
                .Where(s => !s.DeleteFlag)
                .Include(s => s.Movie)
                    .ThenInclude(m => m.MovieCategories)
                        .ThenInclude(mc => mc.Category)
                .Include(s => s.Cinema)
                .FirstOrDefaultAsync(s => s.Id == request.Id, cancellationToken);

                if (item == null)
                    return new ServiceResult(false, string.Format(MessageResouces.NotExisted, ShowtimeResources.Showtime));

                return new ServiceResult(true, "", item);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }
    }
}
