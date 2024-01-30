using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Domain.DTOs;
using BetaCinema.Domain.Models;

namespace BetaCinema.Application.Mappings
{
    public class ReservationProfile : Profile
    {
        public ReservationProfile()
        {
            CreateMap<Reservation, ReservationExport>()
                .ForMember(des => des.UserName, otp => otp.MapFrom(src => src.User.UserName))
                .ForMember(des => des.Email, otp => otp.MapFrom(src => src.User.Email))
                .ForMember(des => des.MovieName, otp => otp.MapFrom(src => src.Showtime.Movie.MovieName))
                .ForMember(des => des.CinemaName, otp => otp.MapFrom(src => src.Showtime.Cinema.CinemaName))
                .ForMember(des => des.StartTime, otp => otp.MapFrom(src => src.Showtime.StartTime.Value.ToString("dd/MM/yyyy HH:mm:ss")))
                .ForMember(des => des.Seats, otp => otp.MapFrom(src => string.Join(", ", src.ReservationItems.Select(ri => $"{ri.Seat.RowNum}{ri.Seat.SeatNum}"))))
                .ForMember(des => des.DeleteFlag, otp => otp.MapFrom(src => ExportStringHelper.DeleteFlagToString(src.DeleteFlag)));
        }
    }
}
