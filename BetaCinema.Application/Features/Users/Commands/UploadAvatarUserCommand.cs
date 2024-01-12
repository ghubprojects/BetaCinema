using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Wrappers;
using MediatR;
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

            private readonly IUnitOfWork _unitOfWork;

            public UploadAvatarUserCommandHandler(IConfiguration configuration, IUnitOfWork unitOfWork)
            {
                _configuration = configuration;
                _unitOfWork = unitOfWork;
            }

            public async Task<ServiceResult> Handle(UploadAvatarUserCommand request, CancellationToken cancellationToken)
            {
                var avatarFile = request.UploadRequest.UploadedFiles[0];

                try
                {
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
                    await _unitOfWork.Repository<User>().UpdateAsync(request.UserData);

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
