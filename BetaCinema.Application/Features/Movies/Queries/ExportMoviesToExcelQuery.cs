using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.DTO;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Hosting;

namespace BetaCinema.Application.Features.Movies.Queries
{
    public class ExportMoviesToExcelQuery : IRequest<byte[]>
    {
        public string? Keyword { get; set; } = string.Empty;

        public ExportMoviesToExcelQuery(string? keyword)
        {
            Keyword = keyword;
        }
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
            // Lấy dữ liệu
            var dataExportList = _mapper.Map<List<MovieExport>>(_context.Movies);

            // Define đường dẫn tới file excel mẫu
            var templateFileInfo = new FileInfo(Path.Combine(_env.ContentRootPath, "Template", "ExportTemplates", $"{typeof(Movie).Name}Export.xlsx"));

            // Gọi đến helper để lấy dữ liệu cho file excel
            var excelData = ExportToExcelHelper<MovieExport>.GenerateExcelFile(dataExportList, templateFileInfo);

            return excelData;
        }
    }
}
