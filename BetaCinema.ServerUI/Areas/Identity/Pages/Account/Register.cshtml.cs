using BetaCinema.Domain.Enums;
using BetaCinema.Domain.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.ComponentModel.DataAnnotations;

namespace BetaCinema.ServerUI.Areas.Identity.Pages.Account
{
    public class RegisterInput
    {
        [Required]
        [RegularExpression(@"^[a-zA-Z0-9_]*$", ErrorMessage = "Username can only contain letters, numbers, and underscores.")]
        public string UserName { get; set; }

        [Required]
        public string FullName { get; set; }

        [Required]
        [EmailAddress]
        public string Email { get; set; }

        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Required]
        public UserRole Role { get; set; }
    }

    public class RegisterModel : PageModel
    {
        private readonly SignInManager<User> _signInManager;

        private readonly UserManager<User> _userManager;

        public RegisterModel(SignInManager<User> signInManager, UserManager<User> userManager)
        {
            _signInManager = signInManager;
            _userManager = userManager;
        }

        [BindProperty]
        public RegisterInput Input { get; set; }

        public string ReturnUrl { get; set; }

        public IList<AuthenticationScheme> ExternalLogins { get; set; }

        public async Task OnGetAsync()
        {
            ReturnUrl = Url.Content("~/");
            ExternalLogins = (await _signInManager.GetExternalAuthenticationSchemesAsync()).ToList();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            ReturnUrl = Url.Content("~/");
            ExternalLogins = (await _signInManager.GetExternalAuthenticationSchemesAsync()).ToList();

            var user = new User
            {
                UserName = Input.UserName,
                FullName = Input.FullName,
                Email = Input.Email,
                Role = UserRole.Customer.ToString(),
                DeleteFlag = false,
                Password = Input.Password,
            };

            var addUserResult = await _userManager.CreateAsync(user, user.Password);
            var addUserRoleResult = await _userManager.AddToRoleAsync(user, user.Role.ToString());

            if (addUserResult.Succeeded && addUserRoleResult.Succeeded)
            {
                await _signInManager.SignInAsync(user, isPersistent: false);
                return LocalRedirect(ReturnUrl);
            }

            return Page();
        }
    }
}