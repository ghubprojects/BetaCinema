namespace BetaCinema.Domain.Exceptions
{
    public class ValidateException : BaseException
    {
        /// <summary>
        /// Danh sách các lỗi con hoặc chi tiết thêm về lỗi (Errors)
        /// </summary>
        public object? Errors { get; set; }
    }
}
