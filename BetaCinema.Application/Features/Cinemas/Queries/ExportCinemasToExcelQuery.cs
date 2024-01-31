using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.DTOs;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Cinemas.Queries
{
    public class ExportCinemasToExcelQuery : IRequest<byte[]>
    {
        public string? Keyword { get; set; } = string.Empty;
        public List<Cinema>? SelectedItems { get; set; } = new();
    }

    /// <summary>
    /// Xử lý yêu cầu (request) để xuất dữ liệu nhân viên ra file Excel
    /// </summary>
    internal sealed class ExportCinemasToExcelQueryHandler : IRequestHandler<ExportCinemasToExcelQuery, byte[]>
    {
        private readonly IAppDbContext _context;
        private readonly IWebHostEnvironment _env;
        private readonly IMapper _mapper;

        public ExportCinemasToExcelQueryHandler(IAppDbContext context, IWebHostEnvironment env, IMapper mapper)
        {
            _env = env;
            _mapper = mapper;
            _context = context;
        }

        public async Task<byte[]> Handle(ExportCinemasToExcelQuery request, CancellationToken cancellationToken)
        {
            // Lấy dữ liệu từ database
            var data = request.SelectedItems.Any() ? request.SelectedItems :
                await _context.Cinemas
                .Where(x => string.IsNullOrWhiteSpace(request.Keyword.ToLower()) || x.CinemaName.ToLower().Contains(request.Keyword.ToLower()) || x.CinemaLocation.ToLower().Contains(request.Keyword.ToLower()))
                .OrderBy(c => c.CinemaName)
                .AsNoTracking()
                .ToListAsync(cancellationToken);

            var dataExportList = _mapper.Map<List<CinemaExport>>(data);

            // Define đường dẫn tới file excel mẫu
            var templateFileInfo = new FileInfo(Path.Combine(_env.ContentRootPath, "Template", "ExportTemplates", $"{typeof(Cinema).Name}Export.xlsx"));

            // Gọi đến helper để lấy dữ liệu cho file excel
            var excelData = ExportToExcelHelper<CinemaExport>.GenerateExcelFile(dataExportList, templateFileInfo);

            return excelData;
        }
    }
}
