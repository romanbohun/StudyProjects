namespace Patterns2.ChainOfResp
{
    public class Purchase
    {
        public int Id { get; set; }
        public double Value { get; set; }
        public string Description { get; set; }

        public Purchase(int id, double value, string descr)
        {
            Id = id;
            Value = value;
            Description = descr;
        }
    }
}