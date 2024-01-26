using BetaCinema.Domain.Exceptions;
using OfficeOpenXml;
using System.Data;

namespace BetaCinema.Application.Helpers
{
    public static class ImportFromExcelHelper<TEntity>
    {
        public static async Task<IEnumerable<TEntity>> ImportAsync(Stream stream, Dictionary<string, Func<DataRow, TEntity, object>> mappers, string sheetName = "Sheet1")
        {
            var result = new List<TEntity>();
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            using var p = new ExcelPackage();
            stream.Position = 0;
            await p.LoadAsync(stream);

            var ws = p.Workbook.Worksheets[sheetName] ?? throw new BaseException()
            {
                UserMessage = "Sheet with name {0} does not exist!",
                DevMessage = "Sheet with name {0} does not exist!"
            };

            var dt = new DataTable();

            var titleInSheet = true;
            var headerRow = titleInSheet ? 3 : 1;

            var titlesInFirstRow = true;
            var startRow = titlesInFirstRow ? 4 : 3;

            foreach (var firstRowCell in ws.Cells[headerRow, 1, headerRow, ws.Dimension.End.Column])
            {
                dt.Columns.Add(titlesInFirstRow ? firstRowCell.Text : $"Column {firstRowCell.Start.Column}");
            }

            var headers = mappers.Keys.Select(x => x).ToList();
            var errors = new List<string>();

            foreach (var header in headers)
            {
                if (!dt.Columns.Contains(header))
                {
                    errors.Add(string.Format("Header '{0}' does not exist in table!", header));
                }
            }

            if (errors.Any())
            {
                throw new ValidateException()
                {
                    Errors = errors
                };
            }

            for (var rowNum = startRow; rowNum <= ws.Dimension.End.Row; rowNum++)
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
                catch (Exception e)
                {
                    throw new BaseException()
                    {
                        DevMessage = e.Message,
                        UserMessage = e.Message
                    };
                }
            }

            return result;
        }
    }
}
