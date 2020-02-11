using System;
using System.ComponentModel;
using FormsUIPlay.Controls;
using FormsUIPlay.iOS.Renderers;
using UIKit;
using Xamarin.Forms;
using Xamarin.Forms.Platform.iOS;

[assembly: ExportRenderer(typeof(SketchView), typeof(SketchViewRenderer))]
namespace FormsUIPlay.iOS.Renderers
{
    public class SketchViewRenderer : Xamarin.Forms.Platform.iOS.ViewRenderer<SketchView, UIView>
    {
        public SketchViewRenderer()
        {
        }

        protected override void OnElementChanged(ElementChangedEventArgs<SketchView> e)
        {
            base.OnElementChanged(e);

            if (Control == null) 
            {
                SetNativeControl(new UIView());
            }
        }

        protected override void OnElementPropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            base.OnElementPropertyChanged(sender, e);

            if (e.PropertyName.Equals(SketchView.MultiTouchEnabledProperty.PropertyName))
            {
                Control.MultipleTouchEnabled = Element.MultiTouchEnabled;
            }

            if (e.PropertyName.Equals(SketchView.InkColorProperty.PropertyName))
            {
                Control.BackgroundColor = Element.InkColor.ToUIColor();
            }
        }
    }
}
