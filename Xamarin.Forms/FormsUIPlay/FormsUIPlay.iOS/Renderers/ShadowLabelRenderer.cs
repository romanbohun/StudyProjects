using CoreGraphics;
using FormsUIPlay.Controls;
using FormsUIPlay.iOS.Renderers;
using UIKit;
using Xamarin.Forms;
using Xamarin.Forms.Platform.iOS;

[assembly: ExportRenderer(typeof(ShadowLabel), typeof(ShadowLabelRenderer))]
namespace FormsUIPlay.iOS.Renderers
{
    public class ShadowLabelRenderer : Xamarin.Forms.Platform.iOS.LabelRenderer
    {
        public ShadowLabelRenderer()
        {
        }

        protected override void OnElementChanged(ElementChangedEventArgs<Label> e)
        {
            base.OnElementChanged(e);

            //UIKit.UILabel theControl = base.Control;
            //theControl.Layer.ShadowOpacity = 1.0f;

            Control.Layer.ShadowColor = UIColor.DarkGray.CGColor;
            Control.Layer.ShadowOpacity = 1.0f;
            Control.Layer.ShadowRadius = 2f;
            Control.Layer.ShadowOffset = new CGSize(4, 4);
            Control.Layer.MasksToBounds = false;
        }
    }
}
