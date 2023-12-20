using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Contracts;
using Microsoft.EntityFrameworkCore;

namespace BetaCinema.Infrastructure.Repositories
{
    public class BaseRepository<T> : IBaseRepository<T> where T : class
    {
        private readonly AppDbContext _dbContext;

        public BaseRepository(AppDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public IQueryable<T> Entities => _dbContext.Set<T>();

        public async Task<List<T>> GetAllAsync()
        {
            var entities = await _dbContext.Set<T>().ToListAsync();

            // Check if T implements IEntity
            if (typeof(IEntity).IsAssignableFrom(typeof(T)))
            {
                // Filter entities based on the DeleteFlag property
                entities = entities
                    .Where(entity => !(bool)typeof(T).GetMethod("GetDeleteFlag")?.Invoke(entity, null))
                    .ToList();
            }

            return entities;
        }

        public async Task<T> GetByIdAsync(string id)
        {
            return await _dbContext.Set<T>().FindAsync(id);
        }

        public async Task AddAsync(T entity)
        {
            _dbContext.Set<T>().Add(entity);
            await _dbContext.SaveChangesAsync();
        }

        public async Task UpdateAsync(T entity)
        {
            _dbContext.Entry(entity).State = EntityState.Modified;
            await _dbContext.SaveChangesAsync();
        }

        public async Task DeleteAsync(T entity)
        {
            if (entity is IEntity entityInstance)
            {
                entityInstance.SetDeleteFlag(true);
                _dbContext.Entry(entity).State = EntityState.Modified;
            }

            await _dbContext.SaveChangesAsync();
        }
    }
}
