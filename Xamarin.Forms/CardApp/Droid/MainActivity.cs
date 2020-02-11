using System;
using Android.App;
using Android.Content;
using Android.Content.PM;
using Android.Runtime;
using Android.OS;
using Card.IO;

namespace CardApp.Droid
{
	[Activity(Label = "CardApp.Droid", Icon = "@drawable/icon", Theme = "@style/MyTheme", MainLauncher = true, ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation)]
	public class MainActivity : global::Xamarin.Forms.Platform.Android.FormsAppCompatActivity
	{
		protected override void OnCreate(Bundle bundle)
		{
			TabLayoutResource = Resource.Layout.Tabbar;
			ToolbarResource = Resource.Layout.Toolbar;

			base.OnCreate(bundle);

			global::Xamarin.Forms.Forms.Init(this, bundle);

			LoadApplication(new App());
		}

		protected override void OnActivityResult(int requestCode, Result resultCode, Intent data)
		{
			base.OnActivityResult(requestCode, resultCode, data);

			if (data != null)
			{
				// Be sure to JavaCast to a CreditCard (normal cast won't work)      
				InfoShareHelper.Instance.CardInfo = data.GetParcelableExtra(CardIOActivity.ExtraScanResult).JavaCast<CreditCard>();
			}
			else
			{
				Console.WriteLine("Scanning Canceled!");
			}
		}
	}
}
