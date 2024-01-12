using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.Extensions.Configuration;


namespace BetaCinema.Application.Features.Slides.Commands
{
    public class DeleteSlideCommand : IRequest<ServiceResult>
    {
        public string FileName { get; set; } = null!;
    }

    public class DeleteSlideCommandHandler : IRequestHandler<DeleteSlideCommand, ServiceResult>
    {
        private readonly IConfiguration _configuration;

        public DeleteSlideCommandHandler(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public async Task<ServiceResult> Handle(DeleteSlideCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var removedFile = new FileInfo(Path.Combine(_configuration.GetValue<string>("FileStorage:Images"), "slides", request.FileName));

                removedFile.Delete();
            }
            catch (Exception ex)
            {
                return new ServiceResult(false, ex.Message);
            }

            return new ServiceResult(true);
        }
    }
}
