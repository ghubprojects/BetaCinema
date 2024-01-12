namespace BetaCinema.Domain.Wrappers
{
    public class ServiceResult
    {
        #region Properties

        public bool IsSuccess { get; set; }

        public string Message { get; set; }

        public dynamic Data { get; set; }

        #endregion

        public ServiceResult(bool isSuccess)
        {
            IsSuccess = isSuccess;
        }

        public ServiceResult(bool isSuccess, string message)
        {
            IsSuccess = isSuccess;
            Message = message;
        }

        public ServiceResult(bool isSuccess, string message, dynamic data)
        {
            IsSuccess = isSuccess;
            Message = message;
            Data = data;
        }
    }
}
