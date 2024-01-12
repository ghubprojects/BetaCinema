using Microsoft.AspNetCore.Components.Forms;

namespace BetaCinema.Application.Requests
{
    public class UploadRequest
    {
        public IList<IBrowserFile> UploadedFiles { get; set; }

        public long MaxFileSize { get; set; } = 1024 * 1024 * 3; // represents 3MB
    }
}
