using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.DTOs;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Reservations.Queries
{
    public class ExportReservationsToExcelQuery : IRequest<byte[]>
    {
        public string? Keyword { get; set; } = string.Empty;

        public ExportReservationsToExcelQuery(string? keyword)
        {
            Keyword = keyword;
        }
    }

    /// <summary>
    /// Xử lý yêu cầu (request) để xuất dữ liệu ra file Excel
    /// </summary>
    internal sealed class ExportReservationsToExcelQueryHandler : IRequestHandler<ExportReservationsToExcelQuery, byte[]>
    {
        private readonly IAppDbContext _context;
        private readonly IWebHostEnvironment _env;
        private readonly IMapper _mapper;

        public ExportReservationsToExcelQueryHandler(IAppDbContext context, IWebHostEnvironment env, IMapper mapper)
        {
            _env = env;
            _mapper = mapper;
            _context = context;
        }

        public async Task<byte[]> Handle(ExportReservationsToExcelQuery request, CancellationToken cancellationToken)
        {
            // Lấy dữ liệu từ database
            var data = await _context.Reservations
                    .Include(r => r.Showtime)
                        .ThenInclude(s => s.Movie)
                    .Include(r => r.Showtime)
                        .ThenInclude(s => s.Cinema)
                    .Include(r => r.ReservationItems)
                        .ThenInclude(ri => ri.Seat)
                    .Include(r => r.User)
                    .OrderBy(r => r.CreatedDate)
                    .AsNoTracking()
                    .ToListAsync(cancellationToken);

            // Lấy dữ liệu
            var dataExport = _mapper.Map<List<ReservationExport>>(data);

            // Define đường dẫn tới file excel mẫu
            var templateFileInfo = new FileInfo(Path.Combine(_env.ContentRootPath, "Template", "ExportTemplates", $"{typeof(Reservation).Name}Export.xlsx"));

            // Gọi đến helper để lấy dữ liệu cho file excel
            var excelData = ExportToExcelHelper<ReservationExport>.GenerateExcelFile(dataExport, templateFileInfo);

            return excelData;
        }
    }
}
