using MediatR;
using Microsoft.Extensions.Configuration;

namespace BetaCinema.Application.Features.Slides.Queries
{
    public class GetAllSlidesQuery : IRequest<List<string>> { }

    public class GetAllSlidesQueryHandler : IRequestHandler<GetAllSlidesQuery, List<string>>
    {
        private readonly IConfiguration _configuration;

        public GetAllSlidesQueryHandler(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public async Task<List<string>> Handle(GetAllSlidesQuery request, CancellationToken cancellationToken)
        {
            var slideFiles = Directory.GetFiles(Path.Combine(_configuration.GetValue<string>("FileStorage:Images"), "slides"))
                .OrderBy(filePath => Math.Abs((File.GetCreationTime(filePath) - DateTime.Now).Ticks))
                .ToList();

            var slideNames = new List<string>();

            foreach (var slideFile in slideFiles)
            {
                slideNames.Add(slideFile.Split("\\").Last());
            }

            return slideNames;
        }
    }
}
