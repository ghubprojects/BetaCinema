using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces;
using BetaCinema.Domain.DTOs;
using BetaCinema.Domain.Models;
using MediatR;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Application.Features.Payments.Queries
{
    public class ExportPaymentsToExcelQuery : IRequest<byte[]>
    {
        public string? Keyword { get; set; } = string.Empty;

        public ExportPaymentsToExcelQuery(string? keyword)
        {
            Keyword = keyword;
        }
    }

    /// <summary>
    /// Xử lý yêu cầu (request) để xuất dữ liệu ra file Excel
    /// </summary>
    internal sealed class ExportPaymentsToExcelQueryHandler : IRequestHandler<ExportPaymentsToExcelQuery, byte[]>
    {
        private readonly IAppDbContext _context;
        private readonly IWebHostEnvironment _env;
        private readonly IMapper _mapper;

        public ExportPaymentsToExcelQueryHandler(IAppDbContext context, IWebHostEnvironment env, IMapper mapper)
        {
            _env = env;
            _mapper = mapper;
            _context = context;
        }

        public async Task<byte[]> Handle(ExportPaymentsToExcelQuery request, CancellationToken cancellationToken)
        {
            // Lấy dữ liệu từ database
            var data = await _context.Payments
                .Include(p => p.Reservation)
                    .ThenInclude(r => r.User)
                .OrderByDescending(p => p.CreatedDate)
                .AsNoTracking()
                .ToListAsync(cancellationToken);

            // Lấy dữ liệu
            var dataExport = _mapper.Map<List<PaymentExport>>(data);

            // Define đường dẫn tới file excel mẫu
            var templateFileInfo = new FileInfo(Path.Combine(_env.ContentRootPath, "Template", "ExportTemplates", $"{typeof(Payment).Name}Export.xlsx"));

            // Gọi đến helper để lấy dữ liệu cho file excel
            var excelData = ExportToExcelHelper<PaymentExport>.GenerateExcelFile(dataExport, templateFileInfo);

            return excelData;
        }
    }
}
