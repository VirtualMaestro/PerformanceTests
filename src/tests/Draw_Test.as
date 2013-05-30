/**
 * User: VirtualMaestro
 * Date: 26.03.13
 * Time: 11:08
 */
package tests
{
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;

	/**
	 */
	public class Draw_Test extends Test
	{

		private var _rect:Rectangle;
		private var _point:Point;
		private var _cameraCanvas:BitmapData;
		private var _canvas:BitmapData;
		private var _textureBitmapData:BitmapData;
		private var _matrix:Matrix;
		private var _colorTransform:ColorTransform;

		private var _width:int = 800;
		private var _height:int = 600;
		private var _texWidth:int = 800;
		private var _texHeight:int = 600;

		/**
		 */
		public function Draw_Test(testName:String = "")
		{
			super(testName);

			iterationsTest = 10000000;

			_rect = new Rectangle(0,0, _width,_height);
			_point = new Point();
			_cameraCanvas = new BitmapData(_width, _height);
			_canvas = new BitmapData(_width, _height);
			_textureBitmapData = new BitmapData(_texWidth, _texHeight);
			_textureBitmapData.fillRect(new Rectangle(0,0, _texWidth, _texHeight), 0xff0000);

			_matrix = new Matrix();
			_colorTransform = new ColorTransform();
		}

		/**
		 */
		override public function run():void
		{
//			copyPixelTest();
//			drawTest();

			absTest();
		}

		//
		private const PRECISE_SCALE:Number = 0.01;

		/**
		 * 10 000 000 iterations
		 *
		 * 1-st:
		 * scale = 1.0; 180 ms
		 * scale < 1.0; 203 ms
		 *
		 * 2-st:
		 * scale = 1.0; 150 ms
		 * scale < 1.0; 152 ms          213
		 */
		private function absTest():void
		{
			var totalScale:Number = 0.9;
			var totalScaleABS:Number;

			var time:int = getTimer();
			for (var i:int = 0; i < iterationsTest; i++)
			{
//				totalScaleABS = 1.0 - Math.abs(totalScale);
//				if (totalScale == 1.0 || (totalScaleABS > 0 && totalScaleABS < PRECISE_SCALE))
//				{
//
//				}

				//
				totalScaleABS = Math.abs(1.0 - Math.abs(totalScale));
				if (totalScaleABS < PRECISE_SCALE)
				{

				}
			}

			timeResult = getTimer() - time;
		}

		/**
		 *  Dirty canvas method
		 *  texture 800/600 - canvas 800/600
		 *  465 ms - 1000 iter with 'mergeAlpha' true
		 *  315 ms - 1000 iter with 'mergeAlpha' false
		 *
		 *  Single draw method
		 *  texture 800/600 - canvas 800/600
		 *  238 ms - 1000 iter with 'mergeAlpha' true
		 *  165 ms - 1000 iter with 'mergeAlpha' false
		 */
		private function copyPixelTest():void
		{
			testName = "copyPixelTest";

			var time:int = getTimer();
			for (var i:int = 0; i < iterationsTest; i++)
			{
				_rect.setTo(0, 0, _textureBitmapData.width, _textureBitmapData.height);
				_point.setTo(0, 0);

				// 1
				_point.setTo(_point.x - 0, _point.y - 0);
				_cameraCanvas.copyPixels(_textureBitmapData, _rect, _point, null, null, false);
				_point.setTo(0, 0);
				_rect.setTo(0,0, _cameraCanvas.width, _cameraCanvas.height);
				_canvas.copyPixels(_cameraCanvas, _rect, _point, null, null, false);

				// 2
//				_canvas.copyPixels(_textureBitmapData, _rect, _point, null, null, false);
			}

			timeResult = getTimer() - time;
		}

		/**
		 * text 800/600 - canvas 800/600
		 * 430 ms - 1000 iter - 'smoothing' true - with 'clipRect' - with 'ColorTransform'
		 * 430 ms - 1000 iter - 'smoothing' true - with 'clipRect' - without 'ColorTransform'
		 * 430 ms - 1000 iter - 'smoothing' true - without 'clipRect' - with 'ColorTransform'
		 *
		 * 430 ms - 1000 iter - 'smoothing' false - with 'clipRect' - with 'ColorTransform'
		 * 430 ms - 1000 iter - 'smoothing' false - without 'clipRect' - with 'ColorTransform'
		 * 238 ms - 1000 iter - 'smoothing' false - with 'clipRect' - with 'ColorTransform' - without transformation
		 *
		 */
		private function drawTest():void
		{
			testName = "drawTest";

			var time:int = getTimer();
			for (var i:int = 0; i < iterationsTest; i++)
			{
				_colorTransform.redMultiplier = 1;
				_colorTransform.greenMultiplier = 1;
				_colorTransform.blueMultiplier = 1;
				_colorTransform.alphaMultiplier = 1;

				_matrix.identity();
				_matrix.scale(1, 1);
				_matrix.translate(0, 0);
				_matrix.rotate(0);
				_matrix.translate(0, 0);


				_canvas.draw(_textureBitmapData, _matrix, _colorTransform, null, _rect, false);
			}

			timeResult = getTimer() - time;
		}
	}
}
