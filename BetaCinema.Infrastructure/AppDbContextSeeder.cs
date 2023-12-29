using BetaCinema.Domain.Enums;
using BetaCinema.Domain.Models;
using Microsoft.AspNetCore.Identity;

namespace BetaCinema.Infrastructure
{
    public class AppDbContextSeeder
    {
        private readonly UserManager<User> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;

        public AppDbContextSeeder(UserManager<User> userManager, RoleManager<IdentityRole> roleManager)
        {
            _userManager = userManager;
            _roleManager = roleManager;
        }

        public async Task InitilizeAsync()
        {
            // Add Admin Role
            var adminRole = new IdentityRole(UserRole.Admin.ToString());

            var existAdminRole = await _roleManager.FindByNameAsync(UserRole.Admin.ToString());

            if (existAdminRole == null)
            {
                await _roleManager.CreateAsync(adminRole);
            }

            // Add Customer Role
            var customerRole = new IdentityRole(UserRole.Customer.ToString());

            var existCustomerRole = await _roleManager.FindByNameAsync(UserRole.Customer.ToString());

            if (existCustomerRole == null)
            {
                await _roleManager.CreateAsync(customerRole);
            }

            // Add Admin User
            var user = new User
            {
                UserName = "Admin",
                FullName = "Admin",
                Email = "admin@gmail.com",
                Password = "000000",
                Role = UserRole.Admin.ToString(),
                DeleteFlag = false,
            };

            await _userManager.CreateAsync(user, user.Password);
            await _userManager.AddToRoleAsync(user, user.Role.ToString());
        }
    }
}
