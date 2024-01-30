using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class UpdateSeatCommand : IRequest<ServiceResult>
    {
        public Seat Data { get; set; }
        public Seat OldData { get; set; }
    }

    public class UpdateSeatCommandHandler : IRequestHandler<UpdateSeatCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public UpdateSeatCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(UpdateSeatCommand request, CancellationToken cancellationToken)
        {
            try
            {
                // Validate
                var validateResult = await ValidateAsync(request.Data, request.OldData);

                // If errors, return false
                if (validateResult.Any())
                    return new ServiceResult(false, validateResult.First());

                // Update item
                request.Data.ModifiedDate = DateTime.Now;
                _context.Entry(request.Data).State = EntityState.Modified;
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }

        private async Task<List<string>> ValidateAsync(Seat seat, Seat old)
        {
            var errors = new List<string>();

            // Validate RowNum
            if (string.IsNullOrWhiteSpace(seat.RowNum))
            {
                errors.Add(string.Format(MessageResouces.Required, SeatResources.RowNum));
            }

            // Validate SeatNum
            if (seat.SeatNum <= 0)
            {
                errors.Add(string.Format(MessageResouces.GreaterThan0, SeatResources.SeatNum));
            }

            // Check duplicated seat
            if (!string.IsNullOrWhiteSpace(seat.RowNum) && seat.SeatNum > 0)
            {
                if (seat.RowNum.ToLower() != old.RowNum.ToLower() || seat.SeatNum != old.SeatNum)
                {
                    var searchResult = await _context.Seats
                        .Where(s => !s.DeleteFlag)
                        .FirstOrDefaultAsync(s => s.RowNum.ToLower() == seat.RowNum.ToLower() && s.SeatNum == seat.SeatNum);

                    if (searchResult != null)
                        errors.Add(string.Format(MessageResouces.Duplicated, SeatResources.Seat));
                }
            }

            return errors;
        }
    }
}
