using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Domain.DTOs;
using BetaCinema.Domain.Models;

namespace BetaCinema.Application.Mappings
{
    public class CategoryProfile : Profile
    {
        public CategoryProfile()
        {
            CreateMap<Category, CategoryExport>()
                .ForMember(des => des.DeleteFlag, otp => otp.MapFrom(src => ExportStringHelper.DeleteFlagToString(src.DeleteFlag)));
        }
    }
}
