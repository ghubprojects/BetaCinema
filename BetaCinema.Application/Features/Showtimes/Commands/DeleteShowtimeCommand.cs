using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Showtimes.Commands
{
    public class DeleteShowtimeCommand : IRequest<ServiceResult>
    {
        public string Id { get; set; } = null!;
    }

    public class DeleteShowtimeCommandHandler : IRequestHandler<DeleteShowtimeCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public DeleteShowtimeCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(DeleteShowtimeCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var showtime = await _context.Showtimes
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(c => c.Id == request.Id, cancellationToken);

                // If errors, return false
                if (showtime == null)
                    return new ServiceResult(false, string.Format(MessageResouces.NotExisted, ShowtimeResources.Showtime));

                // Delete item
                showtime.DeleteFlag = true;
                _context.Entry(showtime).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }
    }
}
