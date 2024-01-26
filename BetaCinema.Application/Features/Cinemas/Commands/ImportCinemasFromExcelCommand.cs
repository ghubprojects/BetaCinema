using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
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
        private readonly IAppDbContext _context;

        public ImportCinemasFromExcelCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(ImportCinemasFromExcelCommand request, CancellationToken cancellationToken)
        {
            var stream = new MemoryStream(request.ImportRequest.Data);
            var result = (await ImportFromExcelHelper<Cinema>.ImportAsync(stream, mappers: new Dictionary<string, Func<DataRow, Cinema, object>>
            {
                { CinemaResources.CinemaName, (row,item) => item.CinemaName = row[CinemaResources.CinemaName].ToString() },
                { CinemaResources.CinemaLocation, (row, item) => item.CinemaLocation = row[CinemaResources.CinemaLocation]?.ToString() },
            }, "Sheet1"));

            var cinemas = result.Select(data => new Cinema
            {
                Id = Guid.NewGuid().ToString(),
                CinemaName = data.CinemaName,
                CinemaLocation = data.CinemaLocation,
                DeleteFlag = false,
                CreatedDate = DateTime.Now,
                ModifiedDate = DateTime.Now,
            }).ToList();

            _context.Cinemas.AddRange(cinemas);
            await _context.SaveChangesAsync(cancellationToken);
            return new ServiceResult(true);
        }
    }
}
