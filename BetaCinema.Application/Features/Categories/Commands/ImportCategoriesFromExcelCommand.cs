﻿using BetaCinema.Application.Helpers;
using BetaCinema.Application.Interfaces;
using BetaCinema.Application.Requests;
using BetaCinema.Domain.Exceptions;
using BetaCinema.Domain.Models;
using BetaCinema.Domain.Resources;
using BetaCinema.Domain.Wrappers;
using MediatR;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace BetaCinema.Application.Features.Categories.Commands
{
    public class ImportCategoriesFromExcelCommand : IRequest<ServiceResult>
    {
        public ImportRequest ImportRequest { get; set; }
    }

    /// <summary>
    /// Xử lý yêu cầu (request) để nhập dữ liệu thể loại từ file Excel
    /// </summary>
    internal sealed class ImportCategoriesFromExcelCommandHandler : IRequestHandler<ImportCategoriesFromExcelCommand, ServiceResult>
    {
        private readonly IAppDbContext _context;

        public ImportCategoriesFromExcelCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<ServiceResult> Handle(ImportCategoriesFromExcelCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var stream = new MemoryStream(request.ImportRequest.Data);

                var result = (await ImportFromExcelHelper<Category>.ImportAsync(stream, mappers: new Dictionary<string, Func<DataRow, Category, object>>
                {
                    { CategoryResources.CategoryName, (row,item) => item.CategoryName = row[CategoryResources.CategoryName].ToString() },
                }, "Sheet1"));

                var categories = result.Select(data => new Category
                {
                    Id = Guid.NewGuid().ToString(),
                    CategoryName = data.CategoryName,
                    DeleteFlag = false,
                    CreatedDate = DateTime.Now,
                    ModifiedDate = DateTime.Now,
                }).ToList();

                // Validate
                foreach (var category in categories)
                {
                    var validateResult = await ValidateAsync(category);

                    if (validateResult.Any())
                    {
                        return new ServiceResult(false, validateResult.First());
                    }
                }

                _context.Categories.AddRange(categories);
                await _context.SaveChangesAsync(cancellationToken);
                return new ServiceResult(true);
            }
            catch (Exception ex)
            {
                return new ServiceResult(false,
                    ex is BaseException baseEx ? baseEx.UserMessage : ErrorResources.UnhandledError);
            }
        }

        private async Task<List<string>> ValidateAsync(Category category)
        {
            var errors = new List<string>();

            // Validate CategoryName
            if (string.IsNullOrWhiteSpace(category.CategoryName))
            {
                errors.Add(string.Format(MessageResouces.Required, CategoryResources.CategoryName));
            }
            else
            {
                var searchResult = await _context.Categories
                    .Where(c => !c.DeleteFlag)
                    .FirstOrDefaultAsync(c => c.CategoryName.ToLower() == category.CategoryName.ToLower());

                if (searchResult != null)
                    errors.Add(string.Format(MessageResouces.Duplicated, CategoryResources.CategoryName));
            }

            return errors;
        }
    }
}
