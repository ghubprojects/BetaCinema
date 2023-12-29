namespace BetaCinema.Application.Helpers
{
    public static class ExportStringHelper
    {
        public static string DeleteFlagToString(bool deleteFlag)
        {
            switch (deleteFlag)
            {
                case true:
                    return "Đã xóa";
                case false:
                    return "";
            }
        }
    }
}
