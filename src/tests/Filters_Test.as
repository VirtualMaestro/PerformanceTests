/**
 * User: VirtualMaestro
 * Date: 01.12.13
 * Time: 15:23
 */
package tests
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.getTimer;

	import utils.BBFilter;
	import utils.Filter;

	/**
	 */
	public class Filters_Test extends Test
	{
		private var _sourceBitmap:Bitmap;
		private var _sourceBitmapData:BitmapData;

		private var _canvasHolder:Bitmap;
		private var _canvas:BitmapData;

		private var _destPoint:Point;

		/**
		 */
		public function Filters_Test(testName:String = "Filters_Test")
		{
			super(testName);

			iterationsTest = 100;

			_sourceBitmap = EmbedResources.inYanBitmap;
			_sourceBitmapData = _sourceBitmap.bitmapData;

			_canvas = new BitmapData(800, 600);
			_canvasHolder = new Bitmap(_canvas, "auto", true);
			addChildAt(_canvasHolder, 0);

			_destPoint = new Point(100, 100);
		}

		/**
		 */
		override public function run():void
		{
//			customOriginFilter();
			customOptimizedFilter();
		}

		/**
		 * twirlFilter: 170 ms, 100 iterations, image 100x100
		 *
		 */
		private function customOriginFilter():void
		{
//			var byteArray:ByteArray = _sourceBitmapData.getPixels(_sourceBitmapData.rect);
//			trace("ByteArray: "+ byteArray);

			_canvas.fillRect(_canvas.rect, 0xffaaffff);
			_canvas.lock();

			_canvas.applyFilter(_sourceBitmapData, _sourceBitmapData.rect, new Point(100, 100), Filter.twirlFilter(_sourceBitmapData));
			_canvas.applyFilter(_sourceBitmapData, _sourceBitmapData.rect, new Point(300, 100), BBFilter.twirlFilter(_sourceBitmapData));

			_canvas.unlock();

			return;

			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				Filter.twirlFilter(_sourceBitmapData);
			}

			timeResult = getTimer() - time;
		}

		/**
		 * twirlFilter: 157 ms, 100 iterations, image 100x100
		 * twirlFilter (second optimization wave): 90 ms, 100 iterations, image 100x100
		 */
		private function customOptimizedFilter():void
		{
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				BBFilter.twirlFilter(_sourceBitmapData);
			}

			timeResult = getTimer() - time;
		}
	}
}
