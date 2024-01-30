using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Exceptions;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace BetaCinema.Application.Features.Seats.Commands
{
    public class ImportSeatsFromExcelCommand : IRequest<ServiceResult>
    {
        public ImportRequest ImportRequest { get; set; }
    }

    /// <summary>
    /// Xử lý yêu cầu (request) để nhập dữ liệu phim từ file Excel
    /// </summary>
    internal sealed class ImportSeatsFromExcelCommandHandler : IRequestHandler<ImportSeatsFromExcelCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public ImportSeatsFromExcelCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(ImportSeatsFromExcelCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var stream = new MemoryStream(request.ImportRequest.Data);

                var result = (await ImportFromExcelHelper<Seat>.ImportAsync(stream, mappers: new Dictionary<string, Func<DataRow, Seat, object>>
                {
                    { SeatResources.RowNum, (row,item) => item.RowNum = row[SeatResources.RowNum].ToString() },
                    { SeatResources.SeatNum, (row, item) => item.SeatNum = int.Parse(row[SeatResources.SeatNum]?.ToString()) },
                }, "Sheet1"));

                var seats = result.Select(data => new Seat
                {
                    Id = Guid.NewGuid().ToString(),
                    RowNum = data.RowNum,
                    SeatNum = data.SeatNum,
                    DeleteFlag = false,
                    CreatedDate = DateTime.Now,
                    ModifiedDate = DateTime.Now,
                }).ToList();

                // Validate
                foreach (var seat in seats)
                {
                    var validateResult = await ValidateAsync(seat);

                    if (validateResult.Any())
                    {
                        return new ServiceResult(false, validateResult.First());
                    }
                }

                _context.Seats.AddRange(seats);
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception ex)
            {
                return new ServiceResult(false,
                    ex is BaseException baseEx ? baseEx.UserMessage : ErrorResources.UnhandledError);
            }
        }

        private async Task<List<string>> ValidateAsync(Seat seat)
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
                var searchResult = await _context.Seats
                    .Where(s => !s.DeleteFlag)
                    .FirstOrDefaultAsync(s => s.RowNum.ToLower() == seat.RowNum.ToLower() && s.SeatNum == seat.SeatNum);

                if (searchResult != null)
                    errors.Add(string.Format(MessageResouces.Duplicated, SeatResources.Seat));
            }

            return errors;
        }
    }
}
