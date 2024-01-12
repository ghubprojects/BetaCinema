using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Domain.DTO;
using BetaCinema.Domain.Models;

namespace BetaCinema.Application.Mappings
{
    public class SeatProfile : Profile
    {
        public SeatProfile()
        {
            CreateMap<Seat, SeatExport>()
                .ForMember(des => des.DeleteFlag, otp => otp.MapFrom(src => ExportStringHelper.DeleteFlagToString(src.DeleteFlag)));
        }
    }
}
