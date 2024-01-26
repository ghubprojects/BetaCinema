﻿using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.DTO;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Hosting;

namespace BetaCinema.Application.Features.Users.Queries
{
    public class ExportUsersToExcelQuery : IRequest<byte[]>
    {
        public string? Keyword { get; set; } = string.Empty;

        public ExportUsersToExcelQuery(string? keyword)
        {
            Keyword = keyword;
        }
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
            var dataExportList = _mapper.Map<List<UserExport>>(_context.Users);

            // Define đường dẫn tới file excel mẫu
            var templateFileInfo = new FileInfo(Path.Combine(_env.ContentRootPath, "Template", "ExportTemplates", $"{typeof(User).Name}Export.xlsx"));

            // Gọi đến helper để lấy dữ liệu cho file excel
            var excelData = ExportToExcelHelper<UserExport>.GenerateExcelFile(dataExportList, templateFileInfo);

            return excelData;
        }
    }
}
