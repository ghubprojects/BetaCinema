using AutoMapper;
using BetaCinema.Application.Helpers;
using BetaCinema.Domain.DTOs;
using BetaCinema.Domain.Models;

namespace BetaCinema.Application.Mappings
{
    public class PaymentProfile : Profile
    {
        public PaymentProfile()
        {
            CreateMap<Payment, PaymentExport>()
                .ForMember(des => des.UserName, otp => otp.MapFrom(src => src.Reservation.User.UserName))
                .ForMember(des => des.Email, otp => otp.MapFrom(src => src.Reservation.User.Email))
                .ForMember(des => des.TotalPrice, otp => otp.MapFrom(src => string.Format("{0} đ", src.TotalPrice.ToString("#,##0"))))
                .ForMember(des => des.PaymentTime, otp => otp.MapFrom(src => src.CreatedDate.ToString("dd/MM/yyyy HH:mm:ss")))
                .ForMember(des => des.DeleteFlag, otp => otp.MapFrom(src => ExportStringHelper.DeleteFlagToString(src.DeleteFlag)));
        }
    }
}
