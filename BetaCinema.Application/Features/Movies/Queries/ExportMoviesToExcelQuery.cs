using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces.Repositories;
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
        private readonly IUnitOfWork _unitOfWork;
        private readonly IWebHostEnvironment _env;
        private readonly IMapper _mapper;

        public ExportMoviesToExcelQueryHandler(IUnitOfWork unitOfWork, IWebHostEnvironment env, IMapper mapper)
        {
            _env = env;
            _mapper = mapper;
            _unitOfWork = unitOfWork;
        }

        public async Task<byte[]> Handle(ExportMoviesToExcelQuery request, CancellationToken cancellationToken)
        {
            // Lấy dữ liệu từ database
            var dataList = await _unitOfWork.Repository<Movie>().GetAllByAdminAsync();

            var dataExportList = _mapper.Map<List<MovieExport>>(dataList);

            // Define đường dẫn tới file excel mẫu
            var templateFileInfo = new FileInfo(Path.Combine(_env.ContentRootPath, "Template", $"{typeof(Movie).Name}Export.xlsx"));

            // Gọi đến helper để lấy dữ liệu cho file excel
            var excelData = ExportToExcelHelper<MovieExport>.GenerateExcelFile(dataExportList, templateFileInfo);

            return excelData;
        }
    }
}
