using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Domain.DTO;
using BetaCinema.Domain.Models;

namespace BetaCinema.Application.Mappings
{
    public class ShowtimeProfile : Profile
    {
        public ShowtimeProfile()
        {
            CreateMap<Showtime, ShowtimeExport>()
                .ForMember(des => des.StartTime, otp => otp.MapFrom(src => src.StartTime.Value.ToString()))
                .ForMember(des => des.DeleteFlag, otp => otp.MapFrom(src => ExportStringHelper.DeleteFlagToString(src.DeleteFlag)));
        }
    }
}
