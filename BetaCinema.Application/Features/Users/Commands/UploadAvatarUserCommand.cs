using BetaCinema.Application.Interfaces;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace BetaCinema.Application.Features.Users.Commands
{
    public class UploadAvatarUserCommand : IRequest<ServiceResult>
    {
        public User UserData { get; set; }

        public UploadRequest UploadRequest { get; set; }

        /// <summary>
        /// 
        /// </summary>
        internal sealed class UploadAvatarUserCommandHandler : IRequestHandler<UploadAvatarUserCommand, ServiceResult>
        {
            private readonly IConfiguration _configuration;

            private readonly IAppDbContext _context;

            public UploadAvatarUserCommandHandler(IConfiguration configuration, IAppDbContext context)
            {
                _configuration = configuration;
                _context = context;
            }

            public async Task<ServiceResult> Handle(UploadAvatarUserCommand request, CancellationToken cancellationToken)
            {
                try
                {
                    var avatarFile = request.UploadRequest.UploadedFiles[0];


                    // create file name
                    string newFileName = Path.ChangeExtension(Path.GetRandomFileName(), Path.GetExtension(avatarFile.Name));

                    // get path
                    string path = Path.Combine(_configuration.GetValue<string>("FileStorage:Images")!,
                        "avatars", newFileName);

                    // add to folder
                    Directory.CreateDirectory(Path.Combine(_configuration.GetValue<string>("FileStorage:Images")!, "avatars"));

                    await using FileStream fs = new(path, FileMode.Create);
                    await avatarFile.OpenReadStream(request.UploadRequest.MaxFileSize).CopyToAsync(fs);

                    // update to database
                    request.UserData.Avatar = newFileName;
                    _context.Entry(request.UserData).State = EntityState.Modified;
                    await _context.SaveChangesAsync(cancellationToken);
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
