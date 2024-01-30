using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Showtimes.Commands
{
    public class DeleteMultipleShowtimesCommand : IRequest<ServiceResult>
    {
        public List<Showtime> RemovedList { get; set; }
    }

    public class DeleteMultipleShowtimesCommandHandler : IRequestHandler<DeleteMultipleShowtimesCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public DeleteMultipleShowtimesCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(DeleteMultipleShowtimesCommand request, CancellationToken cancellationToken)
        {
            try
            {
                // Validate exist or not
                foreach (var item in request.RemovedList)
                {
                    var showtime = await _context.Showtimes
                    .Where(s => !s.DeleteFlag)
                    .AsNoTracking()
                    .FirstOrDefaultAsync(s => s.Id == item.Id, cancellationToken);

                    // If errors, return false
                    if (showtime == null)
                        return new ServiceResult(false, string.Format(MessageResouces.NotExisted, ShowtimeResources.Showtime));
                }

                // Set DeleteFlag to true
                foreach (var item in request.RemovedList)
                {
                    item.DeleteFlag = true;
                    _context.Entry(item).State = EntityState.Modified;
                }

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
