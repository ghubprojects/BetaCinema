using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Cinemas.Commands
{
    public class DeleteCinemaCommand : IRequest<ServiceResult>
    {
        public string Id { get; set; } = null!;
    }

    public class DeleteCinemaCommandHandler : IRequestHandler<DeleteCinemaCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public DeleteCinemaCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="request"></param>
        /// <param name="cancellationToken"></param>
        /// <returns></returns>
        public async Task<ServiceResult> Handle(DeleteCinemaCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var cinema = await _context.Cinemas
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(c => c.Id == request.Id, cancellationToken);

                // If errors, return false
                if (cinema == null)
                    return new ServiceResult(false, string.Format(MessageResouces.NotExisted, CinemaResources.CinemaName));

                // Delete item
                cinema.DeleteFlag = true;
                _context.Entry(cinema).State = EntityState.Modified;
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
