using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;
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
        private readonly IUnitOfWork _unitOfWork;

        public ImportSeatsFromExcelCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<ServiceResult> Handle(ImportSeatsFromExcelCommand request, CancellationToken cancellationToken)
        {
            var stream = new MemoryStream(request.ImportRequest.Data);
            var result = (await ImportFromExcelHelper<Seat>.ImportAsync(stream, mappers: new Dictionary<string, Func<DataRow, Seat, object>>
            {
                { "RowNum", (row,item) => item.RowNum = row["RowNum"].ToString() },
                { "SeatNum", (row, item) => item.SeatNum = int.Parse(row["SeatNum"]?.ToString()) },
            }, "Sheet1"));

            var cinemas = result.Select(data => new Seat
            {
                Id = Guid.NewGuid().ToString(),
                RowNum = data.RowNum,
                SeatNum = data.SeatNum,
                DeleteFlag = false,
            }).ToList();

            await _unitOfWork.Repository<Seat>().AddMultipleAsync(cinemas);

            return new ServiceResult(true);
        }
    }
}
