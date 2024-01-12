using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;
using System.Data;

namespace BetaCinema.Application.Features.Cinemas.Commands
{
    public class ImportCinemasFromExcelCommand : IRequest<ServiceResult>
    {
        public ImportRequest ImportRequest { get; set; }
    }

    /// <summary>
    /// Xử lý yêu cầu (request) để nhập dữ liệu phim từ file Excel
    /// </summary>
    internal sealed class ImportCinemasFromExcelCommandHandler : IRequestHandler<ImportCinemasFromExcelCommand, ServiceResult>
    {
        private readonly IUnitOfWork _unitOfWork;

        public ImportCinemasFromExcelCommandHandler(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<ServiceResult> Handle(ImportCinemasFromExcelCommand request, CancellationToken cancellationToken)
        {
            var stream = new MemoryStream(request.ImportRequest.Data);
            var result = (await ImportFromExcelHelper<Cinema>.ImportAsync(stream, mappers: new Dictionary<string, Func<DataRow, Cinema, object>>
            {
                { "CinemaName", (row,item) => item.CinemaName = row["CinemaName"].ToString() },
                { "Poster", (row, item) => item.CinemaLocation = row["CinemaLocation"]?.ToString() },
            }, "Sheet1"));

            var cinemas = result.Select(data => new Cinema
            {
                Id = Guid.NewGuid().ToString(),
                CinemaName = data.CinemaName,
                CinemaLocation = data.CinemaLocation,
                DeleteFlag = false,
            }).ToList();

            await _unitOfWork.Repository<Cinema>().AddMultipleAsync(cinemas);

            return new ServiceResult(true);
        }
    }
}
