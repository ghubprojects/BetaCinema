using System.ComponentModel.DataAnnotations;

namespace BetaCinema.Domain.DTOs
{
    public class RegisterUserDto
    {
        [Required]
        public string Fullname { get; set; }

        [Required]
        public string Email { get; set; }

        [Required]
        public string Password { get; set; }
    }
}
