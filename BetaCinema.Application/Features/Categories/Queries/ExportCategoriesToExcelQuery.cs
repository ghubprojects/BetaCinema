using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.DTOs;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Categories.Queries
{
    public class ExportCategoriesToExcelQuery : IRequest<byte[]>
    {
        public string? Keyword { get; set; } = string.Empty;

        public ExportCategoriesToExcelQuery(string? keyword)
        {
            Keyword = keyword;
        }
    }

    /// <summary>
    /// Xử lý yêu cầu (request) để xuất dữ liệu nhân viên ra file Excel
    /// </summary>
    internal sealed class ExportCategoriesToExcelQueryHandler : IRequestHandler<ExportCategoriesToExcelQuery, byte[]>
    {
        private readonly IAppDbContext _context;
        private readonly IWebHostEnvironment _env;
        private readonly IMapper _mapper;

        public ExportCategoriesToExcelQueryHandler(IAppDbContext context, IWebHostEnvironment env, IMapper mapper)
        {
            _env = env;
            _mapper = mapper;
            _context = context;
        }

        public async Task<byte[]> Handle(ExportCategoriesToExcelQuery request, CancellationToken cancellationToken)
        {
            // Lấy dữ liệu từ database
            var data = await _context.Categories
                    .OrderBy(c => c.CategoryName)
                    .AsNoTracking()
                    .ToListAsync(cancellationToken);

            var dataExport = _mapper.Map<List<CategoryExport>>(data);

            // Define đường dẫn tới file excel mẫu
            var templateFileInfo = new FileInfo(Path.Combine(_env.ContentRootPath, "Template", "ExportTemplates", $"{typeof(Category).Name}Export.xlsx"));

            // Gọi đến helper để lấy dữ liệu cho file excel
            var excelData = ExportToExcelHelper<CategoryExport>.GenerateExcelFile(dataExport, templateFileInfo);

            return excelData;
        }
    }
}
