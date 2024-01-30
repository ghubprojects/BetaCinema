using BetaCinema.Domain.Exceptions;
using BetaCinema.Domain.Resources;
using OfficeOpenXml;
using OfficeOpenXml.Style;

namespace BetaCinema.Application.Helpers
{
    /// <summary>
    /// Lớp hỗ trợ xuất dữ liệu vào file Excel
    /// </summary>
    public static class ExportToExcelHelper<TExportEntity>
    {
        public static byte[] GenerateExcelFile(List<TExportEntity> dataList, FileInfo templateFileInfo)
        {
            try
            {
                // Thiết lập license context của EPPlus
                ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

                using (var package = new ExcelPackage(templateFileInfo))
                {
                    // Lấy trang chứa dữ liệu cần export
                    var worksheet = package.Workbook.Worksheets[0];

                    // Điền dữ liệu vào sheet bắt đầu từ hàng 4 với số thứ tự là 1
                    int currentRow = 4;
                    int index = 1;

                    // Xoá dữ liệu mẫu và border style từng hàng của file template excel
                    for (var row = currentRow; row <= worksheet.Dimension.End.Row; row++)
                    {
                        for (var col = 1; col < worksheet.Dimension.End.Column; col++)
                        {
                            worksheet.Cells[row, col].Value = "";
                        }

                        var rowRange = worksheet.Cells[row, 1, row, worksheet.Dimension.End.Column];

                        // Set background color to white
                        rowRange.Style.Fill.PatternType = ExcelFillStyle.Solid;
                        rowRange.Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.White);

                        // Remove bold style
                        rowRange.Style.Font.Bold = false;

                        rowRange.Style.Border.Top.Style = ExcelBorderStyle.None;
                        rowRange.Style.Border.Left.Style = ExcelBorderStyle.None;
                        rowRange.Style.Border.Right.Style = ExcelBorderStyle.None;
                        rowRange.Style.Border.Bottom.Style = ExcelBorderStyle.None;
                    }

                    foreach (var data in dataList)
                    {
                        // Điền số thứ tự ở cột 1
                        worksheet.Cells[currentRow, 1].Value = index;

                        // Từ cột 2 trở đi, điền dữ liệu
                        int currentCol = 2;
                        foreach (var property in typeof(TExportEntity).GetProperties())
                        {
                            var cellValue = property.GetValue(data);
                            worksheet.Cells[currentRow, currentCol].Value = cellValue;
                            currentCol++;
                        }

                        // Áp dụng border cho những hàng mới được thêm
                        var rowRange = worksheet.Cells[currentRow, 1, currentRow, worksheet.Dimension.End.Column];
                        rowRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                        rowRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                        rowRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                        rowRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;

                        index++;
                        currentRow++;
                    }

                    return package.GetAsByteArray();
                }
            }
            catch (Exception ex)
            {
                throw new BaseException()
                {
                    DevMessage = ex.Message,
                    UserMessage = ErrorResources.ExportError
                };
            }
        }
    }
}
