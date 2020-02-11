namespace CardApp
{
	public interface ICardService
	{
		void StartCapture();

		string GetCardNumber();

		string GetCardholderName();
	}
}
