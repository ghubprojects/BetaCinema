using BetaCinema.Application.Interfaces;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace BetaCinema.Application.Features.Movies.Commands
{
    public class UploadPosterMovieCommand : IRequest<ServiceResult>
    {
        public Movie MovieData { get; set; }

        public UploadRequest UploadRequest { get; set; }

        /// <summary>
        /// 
        /// </summary>
        internal sealed class UploadPosterMovieCommandHandler : IRequestHandler<UploadPosterMovieCommand, ServiceResult>
        {
            private readonly IConfiguration _configuration;

            private readonly IAppDbContext _context;

            public UploadPosterMovieCommandHandler(IConfiguration configuration, IAppDbContext context)
            {
                _configuration = configuration;
                _context = context;
            }

            public async Task<ServiceResult> Handle(UploadPosterMovieCommand request, CancellationToken cancellationToken)
            {
                var posterFile = request.UploadRequest.UploadedFiles[0];

                try
                {
                    // create file name
                    string newFileName = Path.ChangeExtension(Path.GetRandomFileName(), Path.GetExtension(posterFile.Name));

                    // get path
                    string path = Path.Combine(_configuration.GetValue<string>("FileStorage:Images")!,
                        "posters", newFileName);

                    // add to folder
                    Directory.CreateDirectory(Path.Combine(_configuration.GetValue<string>("FileStorage:Images")!, "posters"));

                    await using FileStream fs = new(path, FileMode.Create);
                    await posterFile.OpenReadStream(request.UploadRequest.MaxFileSize).CopyToAsync(fs);

                    // update to database
                    request.MovieData.Poster = newFileName;
                    request.MovieData.ModifiedDate = DateTime.Now;
                    _context.Entry(request.MovieData).State = EntityState.Modified;
                    await _context.SaveChangesAsync(cancellationToken);
                    return new ServiceResult(true);
                }
                catch (Exception ex)
                {
                    return new ServiceResult(false, ex.Message);
                }
            }
        }
    }
}
