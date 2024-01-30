using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Domain.DTOs;
using BetaCinema.Domain.Models;

namespace BetaCinema.Application.Mappings
{
    public class ShowtimeProfile : Profile
    {
        public ShowtimeProfile()
        {
            CreateMap<Showtime, ShowtimeExport>()
                .ForMember(des => des.MovieName, otp => otp.MapFrom(src => src.Movie.MovieName))
                .ForMember(des => des.CinemaName, otp => otp.MapFrom(src => src.Cinema.CinemaName))
                .ForMember(des => des.StartTime, otp => otp.MapFrom(src => src.StartTime.Value.ToString("dd/MM/yyyy HH:mm:ss")))
                .ForMember(des => des.TicketPrice, otp => otp.MapFrom(src => src.TicketPrice.ToString("#,##0")))
                .ForMember(des => des.DeleteFlag, otp => otp.MapFrom(src => ExportStringHelper.DeleteFlagToString(src.DeleteFlag)));
        }
    }
}
