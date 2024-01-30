using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.ComponentModel.DataAnnotations;

namespace BetaCinema.ServerUI.Areas.Identity.Pages.Account
{
    public class RegisterInput
    {
        [Required(ErrorMessage = "Tên người dùng không được để trống")]
        [RegularExpression(@"^[a-zA-Z0-9_]*$", ErrorMessage = "Tên người dùng chỉ có thể chứa ký tự, chữ số và dấu gạch dưới.")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Họ tên không được để trống")]
        public string FullName { get; set; }

        [Required(ErrorMessage = "Email không được để trống")]
        [RegularExpression(@"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$", ErrorMessage = "Email không hợp lệ")]
        [EmailAddress]
        public string Email { get; set; }

        [Required(ErrorMessage = "Mật khẩu không được để trống")]
        [MinLength(6, ErrorMessage = "Mật khẩu phải có ít nhất 6 ký tự")]
        [DataType(DataType.Password)]
        public string Password { get; set; }
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

            if (ModelState.IsValid)
            {
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
            }

            return Page();
        }
    }
}