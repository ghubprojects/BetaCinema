using BetaCinema.Application.Interfaces.Services;
using BetaCinema.Domain.Exceptions;
using FluentEmail.Core;
using FluentEmail.Core.Models;
using Microsoft.Extensions.Configuration;

namespace BetaCinema.Infrastructure.Services
{
    public class MailService : IMailService
    {
        private readonly IFluentEmail _fluentEmail;
        private readonly IConfiguration _configuration;

        public MailService(IFluentEmail fluentEmail, IConfiguration configuration)
        {
            _fluentEmail = fluentEmail;
            _configuration = configuration;
        }

        public Task<SendResponse> SendAsync(string to, string subject, string body)
        {
            try
            {
                return _fluentEmail
                  .To(to)
                  .Subject(subject)
                  .Body(body, true)
                  .SendAsync();
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

        public Task<SendResponse> SendAsync(string to, string subject, string template, object model)
        {
            try
            {
                var templatePath = string.Format(_configuration.GetValue<string>("EmailTemplateFile"), template);

                return _fluentEmail
                    .To(to)
                    .Subject(subject)
                    .UsingTemplateFromFile(templatePath, model)
                    .SendAsync();
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
