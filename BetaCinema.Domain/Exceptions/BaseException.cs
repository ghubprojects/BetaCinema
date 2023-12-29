namespace BetaCinema.Domain.Exceptions
{
    /// <summary>
    /// Lớp cơ sở cho việc xử lý ngoại lệ trong hệ thống
    /// </summary>
    public class BaseException : Exception
    {
        #region Properties

        /// <summary>
        /// Mã lỗi
        /// </summary>
        public int ErrorCode { get; set; }

        /// <summary>
        /// Thông điệp dành cho nhà phát triển (Developer Message)
        /// </summary>
        public string? DevMessage { get; set; }

        /// <summary>
        /// Thông điệp dành cho người dùng (User Message)
        /// </summary>
        public string? UserMessage { get; set; }

        /// <summary>
        /// Định danh truy vết (Trace ID)
        /// </summary>
        public string? TraceId { get; set; }

        /// <summary>
        /// Thông tin bổ sung liên quan đến lỗi (More Information)
        /// </summary>
        public string? MoreInfo { get; set; }

        #endregion
    }
}
