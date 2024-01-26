using System;
using System.Collections.Generic;

namespace BetaCinema.Domain.Models;

public partial class MovieCategory
{
    public string Id { get; set; } = null!;

    public string MovieId { get; set; } = null!;

    public string CategoryId { get; set; } = null!;

    public bool DeleteFlag { get; set; }

    public DateTime CreatedDate { get; set; }

    public string? CreatedBy { get; set; }

    public DateTime ModifiedDate { get; set; }

    public string? ModifiedBy { get; set; }

    public virtual Category Category { get; set; } = null!;

    public virtual Movie Movie { get; set; } = null!;
}
