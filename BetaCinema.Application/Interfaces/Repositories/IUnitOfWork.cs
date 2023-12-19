namespace BetaCinema.Application.Interfaces.Repositories
{
    public interface IUnitOfWork
    {
        IBaseRepository<T> Repository<T>() where T : class;
    }
}
