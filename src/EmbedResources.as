/**
 * User: VirtualMaestro
 * Date: 01.12.13
 * Time: 15:34
 */
package
{
	import flash.display.Bitmap;

	public class EmbedResources
	{
		[Embed(source="../assets/inyanAvatar.png")]
		static private var _inyanImg:Class;
		static public var inYanBitmap:Bitmap;

		[Embed(source="../assets/backdrop.jpg")]
		static private var _backdropImg:Class;
		static public var backdropBitmap:Bitmap;

		[Embed(source="../assets/tux.png")]
		static private var _tuxImg:Class;
		static public var tuxBitmap:Bitmap;

		static public function init():void
		{
			inYanBitmap = new _inyanImg();
			backdropBitmap = new _backdropImg();
			tuxBitmap = new _tuxImg();
		}
	}
}
