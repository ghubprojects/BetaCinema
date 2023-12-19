namespace BetaCinema.Domain.Contracts
{
    public interface IEntity
    {
        Guid GetId();

        void SetId(Guid id);

        bool GetDeleteFlag();

        void SetDeleteFlag(bool deleteFlag);
    }
}
