﻿using BetaCinema.Domain.Enums;

namespace BetaCinema.Application.Requests
{
    public class ImportRequest
    {
        public string FileName { get; set; }

        public string Extension { get; set; }

        public UploadType UploadType { get; set; }

        public byte[] Data { get; set; }
    }
}