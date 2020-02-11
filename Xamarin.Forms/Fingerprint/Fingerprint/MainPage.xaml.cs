using System;
using System.ComponentModel;
using Plugin.Fingerprint;
using Xamarin.Forms;

namespace Fingerprint
{
    // Learn more about making custom code visible in the Xamarin.Forms previewer
    // by visiting https://aka.ms/xamarinforms-previewer
    [DesignTimeVisible(true)]
    public partial class MainPage : ContentPage
    {
        public MainPage()
        {
            InitializeComponent();
            LoginBtn.Clicked += LoginBtn_Clicked;
        }

        private async void LoginBtn_Clicked(object sender, EventArgs e)
        {
            var result = await CrossFingerprint.Current.IsAvailableAsync(true);
            if (result)
            {
                var auth = await CrossFingerprint.Current.AuthenticateAsync("Auth access to your diary");
                if (auth.Authenticated)
                {
                    await DisplayAlert(
                        "Result",
                        $"You are authenticated with {auth.Status}",
                        "OK");
                }
                else
                {
                    await DisplayAlert(
                        "Result",
                        $"You are NOT authenticated with {auth.Status}",
                        "OK");
                }
            }
        }
    }
}
