using BetaCinema.Application.Interfaces.Repositories;
using BetaCinema.Domain.Contracts;
using BetaCinema.Domain.Models;
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

        public virtual async Task<List<T>> GetAllByAdminAsync()
        {
            return await _dbContext.Set<T>().ToListAsync();
        }

        public virtual async Task<List<T>> GetAllAsync()
        {
            var entities = await _dbContext.Set<T>().ToListAsync();

            // Check if T implements IEntity
            if (typeof(IEntity).IsAssignableFrom(typeof(T)))
            {
                entities = entities
                    .Where(entity => !(bool)typeof(T).GetMethod("GetDeleteFlag")?.Invoke(entity, null))
                    .ToList();
            }
            else if (typeof(User).IsAssignableFrom(typeof(T)))
            {
                entities = entities
                    .Where(entity => !(bool)typeof(T).GetProperty("DeleteFlag").GetValue(entity))
                    .ToList();
            }

            return entities;
        }

        public virtual async Task<T> GetByIdAsync(string id)
        {
            return await _dbContext.Set<T>().FindAsync(id);
        }

        public virtual async Task AddAsync(T entity)
        {
            _dbContext.Set<T>().Add(entity);
            await _dbContext.SaveChangesAsync();
        }

        public virtual async Task AddMultipleAsync(List<T> entities)
        {
            _dbContext.Set<T>().AddRange(entities);
            await _dbContext.SaveChangesAsync();
        }

        public virtual async Task UpdateAsync(T entity)
        {
            _dbContext.Entry(entity).State = EntityState.Modified;
            await _dbContext.SaveChangesAsync();
        }

        public virtual async Task DeleteAsync(T entity)
        {
            if (entity is IEntity entityInstance)
            {
                entityInstance.SetDeleteFlag(true);
                _dbContext.Entry(entity).State = EntityState.Modified;
            }
            else if (entity is User user)
            {
                user.DeleteFlag = true;
                _dbContext.Entry(entity).State = EntityState.Modified;
            }

            await _dbContext.SaveChangesAsync();
        }
    }
}
