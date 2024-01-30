using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.Extensions.Configuration;

namespace BetaCinema.Application.Features.Slides.Queries
{
    public class GetAllSlidesQuery : IRequest<ServiceResult> { }

    public class GetAllSlidesQueryHandler : IRequestHandler<GetAllSlidesQuery, ServiceResult>
    {
        private readonly IConfiguration _configuration;

        public GetAllSlidesQueryHandler(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public async Task<ServiceResult> Handle(GetAllSlidesQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var slideFiles = Directory.GetFiles(Path.Combine(_configuration.GetValue<string>("FileStorage:Images"), "slides"))
                    .OrderBy(filePath => Math.Abs((File.GetCreationTime(filePath) - DateTime.Now).Ticks))
                    .ToList();

                var slideNames = new List<string>();

                foreach (var slideFile in slideFiles)
                {
                    slideNames.Add(slideFile.Split("\\").Last());
                }

                return new ServiceResult(true, "", slideNames);
            }
            catch (Exception)
            {
                return new ServiceResult(false, ErrorResources.UnhandledError);
            }
        }
    }
}
