using BetaCinema.Domain.Exceptions;
using System.Text.Json;

namespace BetaCinema.ServerUI.Middlewares
{
    /// <summary>
    /// Middleware xử lý các ngoại lệ trong ứng dụng
    /// </summary>
    public class ErrorHandlerMiddleware
    {
        #region Fields


        private readonly RequestDelegate _next;
        private readonly ILogger _logger;

        #endregion

        #region Constructors

        public ErrorHandlerMiddleware(RequestDelegate next, ILogger<ErrorHandlerMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        #endregion

        #region Methods

        /// <summary>
        /// Hàm xử lý các ngoại lệ trong ứng dụng
        /// </summary>
        /// <param name="context">Đối tượng HttpContext</param>
        public async Task Invoke(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (Exception error)
            {
                var response = context.Response;
                response.ContentType = "application/json";

                var jsonSerializerOptions = new JsonSerializerOptions()
                {
                    PropertyNamingPolicy = null,
                    Encoder = System.Text.Encodings.Web.JavaScriptEncoder.Create(System.Text.Unicode.UnicodeRanges.All)
                };

                switch (error)
                {
                    case ValidateException validateException:
                        response.StatusCode = StatusCodes.Status400BadRequest;
                        await response.WriteAsJsonAsync(new ValidateException()
                        {
                            ErrorCode = validateException.ErrorCode,
                            UserMessage = error.Message,
                            DevMessage = error.Message,
                            TraceId = context.TraceIdentifier,
                            MoreInfo = error.HelpLink,
                            Errors = validateException.Errors
                        }, jsonSerializerOptions);
                        break;

                    default:
                        // unhandled error
                        _logger.LogError(error, error.Message);
                        response.StatusCode = StatusCodes.Status500InternalServerError;
                        await response.WriteAsJsonAsync(new BaseException()
                        {
                            ErrorCode = context.Response.StatusCode,
                            UserMessage = "Lỗi hệ thống. Vui lòng liên hệ Beta để được hỗ trợ.",
                            DevMessage = error.Message,
                            TraceId = context.TraceIdentifier,
                            MoreInfo = error.HelpLink
                        }, jsonSerializerOptions);
                        break;
                }
            }
        }

        #endregion
    }
}
