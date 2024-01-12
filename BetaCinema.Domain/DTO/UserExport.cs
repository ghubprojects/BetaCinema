namespace BetaCinema.Domain.DTO
{
    public class UserExport
    {
        public string UserName { get; set; } = null!;

        public string Email { get; set; } = null!;

        public string Role { get; set; } = null!;

        public string? Avatar { get; set; }

        public string DeleteFlag { get; set; }
    }
}
