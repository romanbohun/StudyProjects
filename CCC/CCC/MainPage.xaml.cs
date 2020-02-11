using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AppCenter.Crashes;
using Xamarin.Forms;

namespace CCC
{
    public partial class MainPage : ContentPage
    {
        private TestClass _testClass = new TestClass();
        private TestClass2 _testClass2 = new TestClass2(10);

        public MainPage()
        {
            InitializeComponent();

            Btn.Clicked += Btn_Clicked;
            Btn2.Clicked += Btn2_Clicked;
        }

        private void Btn_Clicked(object sender, EventArgs e)
        {
            //_testClass.RunMehtod();

            try
            {
                var vm = new ExceptionTestClass1VM();
                vm.DoSomeLogic1();
            }
            catch (AggregatedException aggEx)
            {
                System.Diagnostics.Debug.WriteLine(aggEx.FullRoute());

                //var topEx = aggEx.GetFirstException();
                //new Exception(message, topEx)
                //topEx.TargetSite.DeclaringType.Name = aggEx.FullRoute();

                var newEx = new Exception(aggEx.FullRoute());

                Crashes.TrackError(newEx);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

        private async void Btn2_Clicked(object sender, EventArgs e)
        {
            await _testClass2.RunMehtod2();
        }


        //private Exception PrepareErrorToLog(AggregatedException exception)
        //{
        //    var topEx = exception.GetFirstException();

        //}
    }
}
