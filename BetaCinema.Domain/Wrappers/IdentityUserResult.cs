namespace BetaCinema.Domain.Wrappers
{
    public class IdentityUserResult
    {
        public bool IsSuccess { get; set; }

        public string AddUserError { get; set; }

        public string AddUserRoleError { get; set; }

        public IdentityUserResult(bool isSuccess)
        {
            IsSuccess = isSuccess;
        }

        public IdentityUserResult(bool isSuccess, string addUserErr, string addUserRoleErr)
        {
            IsSuccess = isSuccess;
            AddUserError = addUserErr;
            AddUserRoleError = addUserRoleErr;
        }
    }
}
