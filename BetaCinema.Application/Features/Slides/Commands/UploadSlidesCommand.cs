using BetaCinema.Application.Requests;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.Extensions.Configuration;

namespace BetaCinema.Application.Features.Slides.Commands
{
    public class UploadSlidesCommand : IRequest<ServiceResult>
    {
        public UploadRequest UploadRequest { get; set; }

        /// <summary>
        /// 
        /// </summary>
        internal sealed class UploadSlidesCommandHandler : IRequestHandler<UploadSlidesCommand, ServiceResult>
        {
            private readonly IConfiguration _configuration;

            public UploadSlidesCommandHandler(IConfiguration configuration)
            {
                _configuration = configuration;
            }

            public async Task<ServiceResult> Handle(UploadSlidesCommand request, CancellationToken cancellationToken)
            {
                try
                {
                    foreach (var file in request.UploadRequest.UploadedFiles)
                    {
                        string newFileName = Path.ChangeExtension(Path.GetRandomFileName(), Path.GetExtension(file.Name));

                        string path = Path.Combine(_configuration.GetValue<string>("FileStorage:Images")!,
                            "slides", newFileName);

                        Directory.CreateDirectory(Path.Combine(_configuration.GetValue<string>("FileStorage:Images")!, "slides"));

                        await using FileStream fs = new(path, FileMode.Create);
                        await file.OpenReadStream(request.UploadRequest.MaxFileSize).CopyToAsync(fs);
                    }

                    return new ServiceResult(true);
                }
                catch (Exception)
                {
                    return new ServiceResult(false, ErrorResources.UnhandledError);
                }
            }
        }
    }
}