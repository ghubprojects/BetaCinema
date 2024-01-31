using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.DTOs;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Showtimes.Queries
{
    public class ExportShowtimesToExcelQuery : IRequest<byte[]>
    {
        public string? Keyword { get; set; } = string.Empty;
        public List<Showtime>? SelectedItems { get; set; } = new();
    }

    /// <summary>
    /// Xử lý yêu cầu (request) để xuất dữ liệu nhân viên ra file Excel
    /// </summary>
    internal sealed class ExportShowtimesToExcelQueryHandler : IRequestHandler<ExportShowtimesToExcelQuery, byte[]>
    {
        private readonly IAppDbContext _context;
        private readonly IWebHostEnvironment _env;
        private readonly IMapper _mapper;

        public ExportShowtimesToExcelQueryHandler(IAppDbContext context, IWebHostEnvironment env, IMapper mapper)
        {
            _env = env;
            _mapper = mapper;
            _context = context;
        }

        public async Task<byte[]> Handle(ExportShowtimesToExcelQuery request, CancellationToken cancellationToken)
        {
            // Lấy dữ liệu từ database
            var data = request.SelectedItems.Any() ? request.SelectedItems :
                _context.Showtimes.AsNoTracking()
                .OrderBy(s => s.StartTime.Value)
                .Include(s => s.Movie)
                .Include(s => s.Cinema).ToList()
                .Where(x => string.IsNullOrWhiteSpace(request.Keyword) || x.Movie.MovieName.ToLower().Contains(request.Keyword.ToLower()) || x.Cinema.CinemaName.ToLower().Contains(request.Keyword.ToLower()) || x.StartTime.Value.ToString("dd/MM/yyyy HH:mm:ss").ToLower().Contains(request.Keyword.ToLower()));

            var dataExport = _mapper.Map<List<ShowtimeExport>>(data);

            // Define đường dẫn tới file excel mẫu
            var templateFileInfo = new FileInfo(Path.Combine(_env.ContentRootPath, "Template", "ExportTemplates", $"{typeof(Showtime).Name}Export.xlsx"));

            // Gọi đến helper để lấy dữ liệu cho file excel
            var excelData = ExportToExcelHelper<ShowtimeExport>.GenerateExcelFile(dataExport, templateFileInfo);

            return excelData;
        }
    }
}
