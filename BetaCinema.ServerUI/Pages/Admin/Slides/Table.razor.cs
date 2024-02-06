using BetaCinema.Application.Features.Slides.Commands;
using BetaCinema.Application.Features.Slides.Queries;
using BetaCinema.Application.Requests;
using Microsoft.AspNetCore.Components.Forms;

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
            var result = await Mediator.Send(new GetAllSlidesQuery());

            if (result.IsSuccess)
            {
                slideNames = result.Data;
            }
            else
            {
                DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
                    new DialogParameters<ErrorMessageDialog>
                    {
                        { x => x.ContentText, result.Message },
                    }, new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
            }
        }

        protected async Task Delete(string fileName)
        {
            var dialog = DialogService.Show<DeleteConfirmation>(DialogResources.DeleteTitle, new DialogParameters<DeleteConfirmation>
            {
                { x => x.Command,  new DeleteSlideCommand() { FileName = fileName } },
                { x => x.ContentText, string.Format(DialogResources.ConfirmDelete, "slide", "Đã chọn") }
            }, new DialogOptions
            {
                MaxWidth = MaxWidth.ExtraSmall,
                DisableBackdropClick = true
            });

            var state = await dialog.Result;
            if (!state.Canceled)
            {
                await OnInitializedAsync();
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
                        { x => x.ContentText, $"Bạn đang tải lên {files.Count} tập tin. Số tập tin không được vượt quá {maxAllowedFiles}."},
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
                        SnackBar.Add(SnackbarResources.UploadSuccess, Severity.Success);
                        await OnInitializedAsync();
                    }
                    else
                    {
                        DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
                            new DialogParameters<ErrorMessageDialog>
                            {
                                { x => x.ContentText, result.Message },
                            }, new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
                    }
                }

                files.Clear();
            }
        }
    }
}
