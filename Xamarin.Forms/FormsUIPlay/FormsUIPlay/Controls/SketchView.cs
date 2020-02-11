using System;
using Xamarin.Forms;

namespace FormsUIPlay.Controls
{
    public class SketchView : View
    {
        public static readonly BindableProperty MultiTouchEnabledProperty =
            BindableProperty.Create("MultiTouchEnabled", typeof(bool), typeof(SketchView), false);

        public bool MultiTouchEnabled
        {
            get => (bool)GetValue(MultiTouchEnabledProperty);
            set => SetValue(MultiTouchEnabledProperty, value);
        }

        public static readonly BindableProperty InkColorProperty = 
            BindableProperty.Create("InkColor", typeof(Color), typeof(SketchView), Color.Blue);

        public Color InkColor
        {
            get { return (Color)GetValue(InkColorProperty); }
            set { SetValue(InkColorProperty, value); }
        }

        public SketchView()
        {
        }
    }
}
