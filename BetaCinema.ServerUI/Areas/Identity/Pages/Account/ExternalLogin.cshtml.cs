using BetaCinema.Domain.Enums;
using BetaCinema.Domain.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Security.Claims;

namespace BetaCinema.ServerUI.Areas.Identity.Pages.Account
{
    public class ExternalLoginModel : PageModel
    {
        private readonly SignInManager<User> _signInManager;
        private readonly UserManager<User> _userManager;

        public ExternalLoginModel(
            SignInManager<User> signInManager,
            UserManager<User> userManager)
        {
            _signInManager = signInManager;
            _userManager = userManager;
        }

        public string ProviderDisplayName { get; set; }

        public string ReturnUrl { get; set; }

        public IActionResult OnGetAsync()
        {
            return RedirectToPage("./login");
        }

        public IActionResult OnPost(string provider)
        {
            // redirectUrl - là Url sẽ chuyển hướng đến - sau khi CallbackPath (/login-google) thi hành xong
            // nó bằng /external-login?handler=Callback, tức là gọi OnGetCallbackAsync 
            var redirectUrl = Url.Page("./ExternalLogin", pageHandler: "Callback");

            // Cấu hình 
            var authProperties = _signInManager.ConfigureExternalAuthenticationProperties(provider, redirectUrl);

            // Chuyển hướng đến dịch vụ ngoài (Googe, Facebook)
            return new ChallengeResult(provider, authProperties);
        }

        /// <summary>
        /// Hàm gọi lại sau khi thực hiện đăng nhập từ dịch vụ ngoài
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> OnGetCallbackAsync()
        {
            // Lấy thông tin do dịch vụ ngoài chuyển đến
            var externalLoginInfo = await _signInManager.GetExternalLoginInfoAsync();
            if (externalLoginInfo == null)
            {
                return RedirectToPage("./login");
            }

            // Đăng nhập bằng thông tin LoginProvider, ProviderKey từ info cung cấp bởi dịch vụ ngoài
            // User nào có 2 thông tin này sẽ được đăng nhập - thông tin này lưu tại bảng UserLogins của Database
            // Trường LoginProvider và ProviderKey ---> tương ứng UserId 
            var result = await _signInManager.ExternalLoginSignInAsync(externalLoginInfo.LoginProvider, externalLoginInfo.ProviderKey, isPersistent: false);

            if (result.Succeeded)
            {
                return RedirectToPage("~/");
            }
            else
            {
                string externalMail = null;
                if (externalLoginInfo.Principal.HasClaim(c => c.Type == ClaimTypes.Email))
                {
                    externalMail = externalLoginInfo.Principal.FindFirstValue(ClaimTypes.Email);
                    var newUser = new User
                    {
                        UserName = externalMail,
                        Email = externalMail,
                        Fullname = externalMail,
                        Role = UserRole.Customer.ToString(),
                        DeleteFlag = false,
                        Password = externalMail,
                    };

                    // User đăng nhập thành công vào hệ thống theo thông tin externalLoginInfo
                    var addUserResult = await _userManager.CreateAsync(newUser);
                    var addUserRoleResult = await _userManager.AddToRoleAsync(newUser, newUser.Role.ToString());
                    var identityResult = await _userManager.AddLoginAsync(newUser, externalLoginInfo);

                    if (addUserResult.Succeeded && addUserRoleResult.Succeeded && identityResult.Succeeded)
                    {
                        // Thực hiện login    
                        await _signInManager.SignInAsync(newUser, isPersistent: false);
                        return LocalRedirect("~/");
                    }
                }
            }

            return RedirectToPage("./login");
        }
    }
}
