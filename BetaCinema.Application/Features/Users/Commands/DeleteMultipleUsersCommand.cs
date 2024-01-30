using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Users.Commands
{
    public class DeleteMultipleUsersCommand : IRequest<ServiceResult>
    {
        public List<User> RemovedList { get; set; }
    }

    public class DeleteMultipleUsersCommandHandler : IRequestHandler<DeleteMultipleUsersCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public DeleteMultipleUsersCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(DeleteMultipleUsersCommand request, CancellationToken cancellationToken)
        {
            try
            {
                // Validate exist or not
                foreach (var item in request.RemovedList)
                {
                    var user = await _context.Users
                    .Where(c => !c.DeleteFlag)
                    .AsNoTracking()
                    .FirstOrDefaultAsync(c => c.Id == item.Id, cancellationToken);

                    // If errors, return false
                    if (user == null)
                        return new ServiceResult(false, string.Format(MessageResouces.NotExisted, UserResources.User));
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
