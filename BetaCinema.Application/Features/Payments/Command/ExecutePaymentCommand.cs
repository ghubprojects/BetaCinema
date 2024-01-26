using BetaCinema.Application.Interfaces.Services;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.AspNetCore.WebUtilities;

namespace BetaCinema.Application.Features.Payments.Commands
{
    public class ExecutePaymentCommand : IRequest<PaymentResponse>
    {
        public Uri Uri { get; set; }
    }

    public class ExecutePaymentCommandHandler : IRequestHandler<ExecutePaymentCommand, PaymentResponse>
    {
        private readonly IVnPayService _vnPayService;

        public ExecutePaymentCommandHandler(IVnPayService vnPayService)
        {
            _vnPayService = vnPayService;
        }

        public async Task<PaymentResponse> Handle(ExecutePaymentCommand request, CancellationToken cancellationToken)
        {
            return _vnPayService.PaymentExecute(QueryHelpers.ParseQuery(request.Uri.Query));
        }
    }
}
