﻿using BetaCinema.Application.Configurations;
using BetaCinema.Application.Interfaces.Services;
using BetaCinema.Domain.Exceptions;
using BetaCinema.Domain.Requests;
using MailKit.Net.Smtp;
using MailKit.Security;
using Microsoft.Extensions.Options;
using MimeKit;

namespace BetaCinema.Infrastructure.Services
{
    public class SMTPMailService : IMailService
    {
        private readonly MailConfiguration _config;

        public SMTPMailService(IOptions<MailConfiguration> config)
        {
            _config = config.Value;
        }

        public async Task SendAsync(MailRequest request)
        {
            try
            {
                var email = new MimeMessage
                {
                    Sender = new MailboxAddress(_config.DisplayName, request.From ?? _config.From),
                    Subject = request.Subject,
                    Body = new BodyBuilder { HtmlBody = request.Body }.ToMessageBody()
                };
                email.To.Add(MailboxAddress.Parse(request.To));

                using (var smtp = new SmtpClient())
                {
                    await smtp.ConnectAsync(_config.Host, _config.Port, SecureSocketOptions.StartTls);
                    await smtp.AuthenticateAsync(_config.UserName, _config.Password);
                    await smtp.SendAsync(email);
                    await smtp.DisconnectAsync(true);
                }
            }
            catch (Exception ex)
            {
                throw new BaseException()
                {
                    DevMessage = ex.Message,
                    UserMessage = "Đã xảy ra lỗi khi gửi email"
                };
            }
        }
    }
}
