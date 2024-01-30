namespace BetaCinema.Domain.DTOs
{
    public class UserExport
    {
        public string UserName { get; set; } = null!;

        public string Email { get; set; } = null!;

        public string Role { get; set; } = null!;

        public string DeleteFlag { get; set; }
    }
}
