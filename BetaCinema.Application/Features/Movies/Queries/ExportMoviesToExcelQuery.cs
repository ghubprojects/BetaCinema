using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.DTOs;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Movies.Queries
{
    public class ExportMoviesToExcelQuery : IRequest<byte[]>
    {
        public string? Keyword { get; set; } = string.Empty;
        public List<Movie>? SelectedItems { get; set; } = new();
    }

    /// <summary>
    /// Xử lý yêu cầu (request) để xuất dữ liệu nhân viên ra file Excel
    /// </summary>
    internal sealed class ExportMoviesToExcelQueryHandler : IRequestHandler<ExportMoviesToExcelQuery, byte[]>
    {
        private readonly IAppDbContext _context;
        private readonly IWebHostEnvironment _env;
        private readonly IMapper _mapper;

        public ExportMoviesToExcelQueryHandler(IAppDbContext context, IWebHostEnvironment env, IMapper mapper)
        {
            _env = env;
            _mapper = mapper;
            _context = context;
        }

        public async Task<byte[]> Handle(ExportMoviesToExcelQuery request, CancellationToken cancellationToken)
        {
            // Lấy dữ liệu từ database
            var data = request.SelectedItems.Any() ? request.SelectedItems :
                _context.Movies.AsNoTracking()
                .Include(m => m.MovieCategories)
                    .ThenInclude(mc => mc.Category)
                .OrderByDescending(m => m.ReleaseDate).ToList()
                .Where(m => string.IsNullOrWhiteSpace(request.Keyword) || m.MovieName.ToLower().Contains(request.Keyword.ToLower()) ||
                string.Join(", ", m.MovieCategories.Select(mc => mc.Category.CategoryName)).ToLower().Contains(request.Keyword.ToLower()) || m.ReleaseDate.Value.ToString("dd/MM/yyyy").Contains(request.Keyword));

            // Lấy dữ liệu
            var dataExport = _mapper.Map<List<MovieExport>>(data);

            // Define đường dẫn tới file excel mẫu
            var templateFileInfo = new FileInfo(Path.Combine(_env.ContentRootPath, "Template", "ExportTemplates", $"{typeof(Movie).Name}Export.xlsx"));

            // Gọi đến helper để lấy dữ liệu cho file excel
            var excelData = ExportToExcelHelper<MovieExport>.GenerateExcelFile(dataExport, templateFileInfo);

            return excelData;
        }
    }
}
