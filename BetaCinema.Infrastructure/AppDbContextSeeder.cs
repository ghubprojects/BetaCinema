using BetaCinema.Domain.Enums;
using Microsoft.AspNetCore.Identity;

namespace BetaCinema.Infrastructure
{
    public class AppDbContextSeeder
    {
        private readonly RoleManager<IdentityRole> _roleManager;

        public AppDbContextSeeder(RoleManager<IdentityRole> roleManager)
        {
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
        }
    }
}
