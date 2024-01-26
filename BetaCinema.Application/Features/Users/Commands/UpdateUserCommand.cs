using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Users.Commands
{
    public class UpdateUserCommand : IRequest
    {
        public User Data { get; set; }
    }

    public class UpdateUserCommandHandler : IRequestHandler<UpdateUserCommand>
    {
        private readonly IAppDbContext _context;

        public UpdateUserCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task Handle(UpdateUserCommand request, CancellationToken cancellationToken)
        {
            request.Data.NormalizedEmail = request.Data.Email.ToUpper();
            request.Data.NormalizedUserName = request.Data.UserName.ToUpper();

            _context.Entry(request.Data).State = EntityState.Modified;
            await _context.SaveChangesAsync(cancellationToken);
        }
    }
}
