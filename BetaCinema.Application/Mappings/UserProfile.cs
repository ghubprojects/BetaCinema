using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Domain.DTOs;
using BetaCinema.Domain.Exceptions;
using BetaCinema.Domain.Models;

namespace BetaCinema.Application.Mappings
{
    public class UserProfile : Profile
    {
        public UserProfile()
        {
            CreateMap<User, UserExport>()
               .ForMember(des => des.Role, opt => opt.MapFrom(src => RoleToString(src.Role)))
               .ForMember(des => des.DeleteFlag, otp => otp.MapFrom(src => ExportStringHelper.DeleteFlagToString(src.DeleteFlag)));

            CreateMap<UserExport, User>()
               .ForMember(des => des.Role, opt => opt.MapFrom(src => StringToRole(src.Role)));
        }

        private string RoleToString(string role)
        {
            switch (role)
            {
                case "Admin":
                    return "Quản trị viên";
                case "Customer":
                    return "Khách hàng";
                default:
                    return "Không hợp lệ";
            }
        }

        private string StringToRole(string role)
        {
            try
            {
                switch (role)
                {
                    case "Quản trị viên":
                        return "Admin";
                    case "Khách hàng":
                        return "Customer";
                    default:
                        return "Customer";
                }
            }
            catch (Exception error)
            {
                throw new BaseException()
                {
                    DevMessage = error.Message,
                    UserMessage = "Vai trò không hợp lệ"
                };
            }
        }
    }
}
