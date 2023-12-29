namespace BetaCinema.Domain.Wrappers
{
    public class ServiceResult
    {
        #region Properties

        public bool IsSuccess { get; set; }

        public string Error { get; set; }

        #endregion

        public ServiceResult(bool isSuccess)
        {
            IsSuccess = isSuccess;
        }

        public ServiceResult(bool isSuccess, string error)
        {
            IsSuccess = isSuccess;
            Error = error;
        }
    }
}
