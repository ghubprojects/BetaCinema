namespace BetaCinema.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController
    {
        [HttpGet("Export")]
        public async Task<IActionResult> ExportToExcelAsync([FromQuery] string? keyword)
        {
            //Lấy dữ liệu cho file excel
            var excelData = await _paymentBL.ExportToExcelAsync(keyword);

            // Context type dành cho file excel
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

            // Tạo 1 unique filename cho file excel
            string fileName = $"{typeof(Payment).Name}_{DateTime.Now:yyyyMMddHHmmss}.xlsx";

            // Trả về file được tự động download khi gọi API
            return File(excelData, Response.ContentType, fileName);
        }
    }
}
