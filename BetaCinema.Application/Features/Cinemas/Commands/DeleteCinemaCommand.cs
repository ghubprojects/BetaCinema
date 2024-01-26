using BetaCinema.Application.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Cinemas.Commands
{
    public class DeleteCinemaCommand : IRequest
    {
        public string Id { get; set; } = null!;
    }

    public class DeleteCinemaCommandHandler : IRequestHandler<DeleteCinemaCommand>
    {
        private readonly IAppDbContext _context;

        public DeleteCinemaCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task Handle(DeleteCinemaCommand request, CancellationToken cancellationToken)
        {
            var cinema = await _context.Cinemas.FindAsync(request.Id);
            if (cinema != null)
            {
                cinema.DeleteFlag = true;
                _context.Entry(cinema).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
            }
        }
    }
}
