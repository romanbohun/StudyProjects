using System;
using Xamarin.Forms;

namespace CardApp
{
	public partial class HomePage : ContentPage
	{
		public HomePage()
		{
			InitializeComponent();
		}

		private void onScanCard(object sender, EventArgs e)
		{
			DependencyService.Get<ICardService>().StartCapture();
		}
	}
}
