using BetaCinema.Application.Features.Slides.Commands;
using BetaCinema.Application.Features.Slides.Queries;
using BetaCinema.Application.Requests;
using BetaCinema.ServerUI.Components.Dialog;
using BetaCinema.ServerUI.Resources;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Forms;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Slides
{
    public class TableBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        protected List<string>? slideNames;

        protected override async Task OnInitializedAsync()
        {
            slideNames = await Mediator.Send(new GetAllSlidesQuery());
        }

        protected async Task Delete(string fileName)
        {
            if (await js.InvokeAsync<bool>("confirm", $"Do you want to delete this slide ?"))
            {
                var result = await Mediator.Send(new DeleteSlideCommand() { FileName = fileName });

                if (result.IsSuccess)
                {
                    SnackBar.Add("Delete successfully", Severity.Success);
                    await OnInitializedAsync();
                }
            }
        }

        protected IList<IBrowserFile> files = new List<IBrowserFile>();
        private readonly int maxAllowedFiles = 3;

        protected async Task UploadFiles(IReadOnlyList<IBrowserFile> inputFiles)
        {
            foreach (var file in inputFiles)
            {
                files.Add(file);
            }

            if (files.Any())
            {
                if (files.Count > maxAllowedFiles)
                {
                    DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
                    new DialogParameters<ErrorMessageDialog>
                    {
                        { x => x.ContentText, $"Attempting to upload {files.Count} files, but only {maxAllowedFiles} files are allowed"},
                        { x => x.ButtonText, SharedResources.Close },
                        { x => x.Color, Color.Error }
                    },
                    new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
                }
                else
                {
                    var uploadRequest = new UploadRequest()
                    {
                        MaxFileSize = 1024 * 1024 * 3,
                        UploadedFiles = files
                    };

                    var result = await Mediator.Send(new UploadSlidesCommand() { UploadRequest = uploadRequest });

                    if (result.IsSuccess)
                    {
                        SnackBar.Add("Upload slide images successfully", Severity.Success);
                        await OnInitializedAsync();
                    }
                }

                files.Clear();
            }
        }
    }
}
