﻿using BetaCinema.Application.Features.Seats.Commands;
using BetaCinema.Application.Features.Seats.Queries;
using BetaCinema.Application.Features.Users.Commands;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Enums;
using BetaCinema.Domain.Models;
using BetaCinema.ServerUI.Components.Dialog;
using BetaCinema.ServerUI.Resources;
using MediatR;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Forms;
using Microsoft.JSInterop;
using MudBlazor;

namespace BetaCinema.ServerUI.Pages.Admin.Seats
{
    public class TableBase : ComponentBase
    {
        [Inject] protected IJSRuntime js { get; set; }

        [Inject] protected NavigationManager Navigation { get; set; }

        [Inject] IDialogService DialogService { get; set; }

        [Inject] protected ISnackbar SnackBar { get; set; }

        [Inject] private IMediator Mediator { get; set; }

        protected List<Seat>? seats;

        protected override async Task OnInitializedAsync()
        {
            seats = await Mediator.Send(new GetAllSeatsQuery());
        }

        protected void NavigateToCreateForm()
        {
            Navigation.NavigateTo("admin/seats/create");
        }

        protected async Task Delete(string seatId)
        {
            var seat = seats.First(x => x.Id == seatId);
            if (await js.InvokeAsync<bool>("confirm", $"Do you want to delete Seat <{seat.RowNum}{seat.SeatNum}>?"))
            {
                await Mediator.Send(new DeleteSeatCommand() { Id = seatId });
                SnackBar.Add("Delete successfully", Severity.Success);
                await OnInitializedAsync();
            }
        }

        protected async Task DownloadExcelFile()
        {
            var excelBytes = await Mediator.Send(new ExportSeatsToExcelQuery(""));

            // Tạo 1 unique filename cho file excel
            string fileName = $"{typeof(Seat).Name}_{DateTime.Now:yyyyMMddHHmmss}.xlsx";

            await js.InvokeVoidAsync("saveAsFile", fileName, Convert.ToBase64String(excelBytes));
        }

        protected IList<IBrowserFile> files = new List<IBrowserFile>();

        protected async Task UploadFiles(IBrowserFile file)
        {
            files.Add(file);

            if (files.Any())
            {
                var uploadFile = files[0];

                var buffer = new byte[uploadFile.Size];
                var extension = Path.GetExtension(uploadFile.Name);
                await uploadFile.OpenReadStream(uploadFile.Size).ReadAsync(buffer);

                var importRequest = new ImportRequest
                {
                    Data = buffer,
                    FileName = uploadFile.Name,
                    UploadType = UploadType.Document,
                    Extension = extension
                };

                var result = await Mediator.Send(new ImportUsersFromExcelCommand()
                { ImportRequest = importRequest });

                if (result.IsSuccess)
                {
                    SnackBar.Add("Import successfully", Severity.Success);
                    Navigation.NavigateTo("admin/seats", true);
                }
                else
                {
                    DialogService.Show<ErrorMessageDialog>(SharedResources.Error,
                        new DialogParameters<ErrorMessageDialog>
                        {
                            { x => x.ContentText, result.Message },
                            { x => x.ButtonText, SharedResources.Close },
                            { x => x.Color, Color.Error }
                        }, new DialogOptions() { MaxWidth = MaxWidth.ExtraSmall });
                }

                files.Clear();
            }
        }
    }
}
