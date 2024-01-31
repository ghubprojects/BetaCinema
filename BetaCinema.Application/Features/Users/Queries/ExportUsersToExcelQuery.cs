using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.DTOs;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Users.Queries
{
    public class ExportUsersToExcelQuery : IRequest<byte[]>
    {
        public string? Keyword { get; set; } = string.Empty;
        public List<User>? SelectedItems { get; set; } = new();
    }

    /// <summary>
    /// Xử lý yêu cầu (request) để xuất dữ liệu nhân viên ra file Excel
    /// </summary>
    internal sealed class ExportUsersToExcelQueryHandler : IRequestHandler<ExportUsersToExcelQuery, byte[]>
    {
        private readonly IAppDbContext _context;
        private readonly IWebHostEnvironment _env;
        private readonly IMapper _mapper;

        public ExportUsersToExcelQueryHandler(IAppDbContext context, IWebHostEnvironment env, IMapper mapper)
        {
            _env = env;
            _mapper = mapper;
            _context = context;
        }

        public async Task<byte[]> Handle(ExportUsersToExcelQuery request, CancellationToken cancellationToken)
        {
            // Lấy dữ liệu từ database
            var data = request.SelectedItems.Any() ? request.SelectedItems :
                await _context.Users
                .Where(x => string.IsNullOrWhiteSpace(request.Keyword) || x.UserName.ToLower().Contains(request.Keyword.ToLower()) || x.FullName.ToLower().Contains(request.Keyword.ToLower()) || x.Email.ToLower().Contains(request.Keyword.ToLower()) || x.Role.ToLower().Contains(request.Keyword.ToLower()))
                .OrderBy(u => u.Role)
                .ThenBy(u => u.UserName)
                .AsNoTracking()
                .ToListAsync(cancellationToken);

            var dataExportList = _mapper.Map<List<UserExport>>(data);

            // Define đường dẫn tới file excel mẫu
            var templateFileInfo = new FileInfo(Path.Combine(_env.ContentRootPath, "Template", "ExportTemplates", $"{typeof(User).Name}Export.xlsx"));

            // Gọi đến helper để lấy dữ liệu cho file excel
            var excelData = ExportToExcelHelper<UserExport>.GenerateExcelFile(dataExportList, templateFileInfo);

            return excelData;
        }
    }
}
