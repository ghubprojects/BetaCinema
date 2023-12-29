namespace BetaCinema.Application.Interfaces.Repositories
{
    public interface IBaseRepository<T> where T : class
    {
        IQueryable<T> Entities { get; }

        Task<T> GetByIdAsync(string id);

        Task<List<T>> GetAllByAdminAsync();

        Task<List<T>> GetAllAsync();

        Task AddAsync(T entity);

        Task AddMultipleAsync(List<T> entities);

        Task UpdateAsync(T entity);

        Task DeleteAsync(T entity);
    }
}