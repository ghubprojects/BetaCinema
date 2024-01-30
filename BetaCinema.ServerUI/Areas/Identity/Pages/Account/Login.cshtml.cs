using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.ComponentModel.DataAnnotations;

namespace BetaCinema.ServerUI.Areas.Identity.Pages.Account
{
    public class LoginInput
    {
        [Required(ErrorMessage = "Tên ng??i dùng không ???c ?? tr?ng")]
        public string UserName { set; get; }

        [Required(ErrorMessage = "M?t kh?u không ???c ?? tr?ng")]
        [DataType(DataType.Password)]
        public string Password { get; set; }
    }

    public class LoginModel : PageModel
    {
        private readonly SignInManager<User> _signInManager;

        public LoginModel(SignInManager<User> signInManager)
        {
            _signInManager = signInManager;
        }

        [BindProperty]
        public LoginInput Input { get; set; }

        public string ReturnUrl { get; set; }

        public IList<AuthenticationScheme> ExternalLogins { get; set; }

        public async Task OnGetAsync()
        {
            ReturnUrl = Url.Content("~/");

            // Clear the existing external cookie to ensure a clean login process
            await HttpContext.SignOutAsync(IdentityConstants.ExternalScheme);

            ExternalLogins = (await _signInManager.GetExternalAuthenticationSchemesAsync()).ToList();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            ReturnUrl = Url.Content("~/");
            ExternalLogins = (await _signInManager.GetExternalAuthenticationSchemesAsync()).ToList();

            if (ModelState.IsValid)
            {
                var signInResult = await _signInManager.PasswordSignInAsync(
                Input.UserName,
                Input.Password,
                isPersistent: false,
                lockoutOnFailure: false);

                if (signInResult.Succeeded)
                {
                    return LocalRedirect(ReturnUrl);
                }
            }

            return Page();
        }
    }
}


