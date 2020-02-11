using System;
using Card.IO;
using CardApp.iOS;
using UIKit;
using Xamarin.Forms;

[assembly: Dependency(typeof(CardService))]
namespace CardApp.iOS
{
	public class CardService : CardIOPaymentViewControllerDelegate, ICardService
	{
		private UIViewController rootViewController;
		private CreditCardInfo cardInfo;

		public void StartCapture()
		{
			InitCardService();
			var paymentViewController = new CardIOPaymentViewController(this);
            paymentViewController.CollectCVV = false;
            paymentViewController.CollectCardholderName = true;
            paymentViewController.DetectionMode = DetectionMode.CardImageAndNumber;
            paymentViewController.HideCardIOLogo = true;
            paymentViewController.ScannedImageDuration = 0.05f;

			rootViewController.PresentViewController(paymentViewController, true, null);
		}

		public string GetCardNumber()
		{
			return (cardInfo != null) ? cardInfo.CardNumber : null;
		}

		public string GetCardholderName()
		{
			return (cardInfo != null) ? cardInfo.CardholderName : null;
		}

		private void InitCardService()
		{
			// Init rootViewController
			var window = UIApplication.SharedApplication.KeyWindow;
			rootViewController = window.RootViewController;
			while (rootViewController.PresentedViewController != null)
			{
				rootViewController = rootViewController.PresentedViewController;
			}
		}

		public override void UserDidCancelPaymentViewController(CardIOPaymentViewController paymentViewController)
		{
			Console.WriteLine("Scanning Canceled!");
            paymentViewController.DismissViewController(true, null);
        }

		public override void UserDidProvideCreditCardInfo(CreditCardInfo cardInfo, CardIOPaymentViewController paymentViewController)
		{
			if (cardInfo == null)
			{
				Console.WriteLine("Scanning Canceled!");
			}
			else 
			{
				this.cardInfo = cardInfo;
			}

			paymentViewController.DismissViewController(true, null);
		}
	}
}
