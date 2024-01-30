using BetaCinema.Domain.Exceptions;
using BetaCinema.Domain.Resources;
using OfficeOpenXml;
using System.Data;

namespace BetaCinema.Application.Helpers
{
    public static class ImportFromExcelHelper<TEntity>
    {
        public static async Task<IEnumerable<TEntity>> ImportAsync(Stream stream, Dictionary<string, Func<DataRow, TEntity, object>> mappers, string sheetName = "Sheet1")
        {
            // Thiết lập license context của EPPlus
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

            using var package = new ExcelPackage();
            stream.Position = 0;
            await package.LoadAsync(stream);

            var ws = package.Workbook.Worksheets[sheetName]
                ?? throw new BaseException()
                {
                    DevMessage = string.Format(ErrorResources.NotExistedExcelSheet, sheetName),
                    UserMessage = string.Format(ErrorResources.NotExistedExcelSheet, sheetName)
                };

            var dt = new DataTable();

            // Hàng tiêu đề và hàng bắt đầu đọc dữ liệu
            var headerRow = 3;
            var startDataRow = 4;

            // Đọc header
            try
            {
                foreach (var headerCell in ws.Cells[headerRow, 1, headerRow, ws.Dimension.End.Column])
                {
                    dt.Columns.Add(headerCell.Text);
                }
            }
            catch (Exception ex)
            {
                throw new BaseException()
                {
                    DevMessage = ex.Message,
                    UserMessage = ErrorResources.ReadHeaderError
                };
            }

            // Kiểm tra tất cả cột trong sheet trùng khớp với mappers
            var headers = mappers.Keys.ToList();
            var errors = new List<string>();

            foreach (var header in headers)
            {
                if (!dt.Columns.Contains(header))
                {
                    errors.Add(string.Format(ErrorResources.NotExistedHeader, header));
                }
            }

            if (errors.Any())
            {
                throw new BaseException()
                {
                    DevMessage = errors.First(),
                    UserMessage = $"{errors.First()} {ErrorResources.NotFollowImportTemplate}"
                };
            }

            // Đọc dữ liệu
            var result = new List<TEntity>();
            for (var rowNum = startDataRow; rowNum <= ws.Dimension.End.Row; rowNum++)
            {
                try
                {
                    var wsRow = ws.Cells[rowNum, 1, rowNum, ws.Dimension.End.Column];
                    DataRow row = dt.Rows.Add();
                    var item = (TEntity)Activator.CreateInstance(typeof(TEntity));
                    foreach (var cell in wsRow)
                    {
                        row[cell.Start.Column - 1] = cell.Text;
                    }
                    headers.ForEach(x => mappers[x](row, item));
                    result.Add(item);
                }
                catch (Exception ex)
                {
                    throw new BaseException()
                    {
                        DevMessage = ex.Message,
                        UserMessage = ErrorResources.ReadDataError
                    };
                }
            }

            return result;
        }
    }
}
