using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Domain.DTO;
using BetaCinema.Domain.Models;

namespace BetaCinema.Application.Mappings
{
    public class MovieProfile : Profile
    {
        public MovieProfile()
        {
            CreateMap<Movie, MovieExport>()
                .ForMember(des => des.Duration, otp => otp.MapFrom(src => string.Format("{0} phút", src.Duration)))
                .ForMember(des => des.ReleaseDate, otp => otp.MapFrom(src => src.ReleaseDate.Value.ToShortDateString()))
                .ForMember(des => des.DeleteFlag, otp => otp.MapFrom(src => ExportStringHelper.DeleteFlagToString(src.DeleteFlag)));
        }
    }
}
