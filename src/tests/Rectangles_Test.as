/**
 * User: VirtualMaestro
 * Date: 15.02.13
 * Time: 11:15
 */
package tests
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;

	import utils.BBRect;

	/**
	 * Test standard Rectangle's methods with custom BBRect.
	 */
	public class Rectangles_Test extends Test
	{
		private var _stRect_1:Rectangle;
		private var _stRect_2:Rectangle;
		private var _bbRect_1:BBRect;
		private var _bbRect_2:BBRect;

		public function Rectangles_Test(testName:String = "")
		{
			super(testName);
			iterationsTest = 10000000;

			_stRect_1 = new Rectangle(100, 100, 200, 200);
			_stRect_2 = new Rectangle(110, 110, 300, 300);
			_bbRect_1 = new BBRect(_stRect_1.x, _stRect_1.y, _stRect_1.width, _stRect_1.height);
			_bbRect_2 = new BBRect(_stRect_2.x, _stRect_2.y, _stRect_2.width, _stRect_2.height);
		}

		/**
		 */
		override public function run():void
		{
//			standardRectTest();
//			bbRectTest();

//			setterTest();
			setterPointTest();
		}

		/**
		 * Intersection:
		 * - positive result: 1200 ms (10000000)
		 * - negative result: 1200 ms (10000000)
		 * - fully contains:  1200 ms (10000000)
		 *
		 * Contains:
		 * - positive result: 370 ms (10000000)
		 * - negative result: 340 ms (10000000)
		 */
		private function standardRectTest():void
		{
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
//				_stRect_1.intersects(_stRect_2);
				_stRect_1.containsRect(_stRect_2);
			}

			timeResult = getTimer() - time;
		}

		/**
		 * Intersection:
		 * - positive result: 280 ms (10000000)
		 * - negative result: 260 ms (10000000)
		 * - fully contains:  260 ms (10000000)
		 * (все результаты займут 560 мс если в методе isIntersect будут использоваться не паблик свойства, а методы-свойства)
		 *
		 * Contains:
		 * - positive result: 220 ms (10000000)
		 * - negative result: 230 ms (10000000)
		 */
		private function bbRectTest():void
		{
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
//				_bbRect_1.isIntersect(_bbRect_2);
				_bbRect_1.isInside(_bbRect_2);
			}

			timeResult = getTimer() - time;
		}

		/**
		 * setTo: 226 ms, 10 000 000 iterations
		 * direct to props: 129 ms, 10 000 000 iterations
		 */
		private function setterTest():void
		{
			var rect:Rectangle = new Rectangle();
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				rect.setTo(3, 6, 189, 435);

				//
//				rect.x = 3;
//				rect.y = 6;
//				rect.width = 189;
//				rect.height = 435;
			}

			timeResult = getTimer() - time;
		}

		/**
		 * setTo: 203 ms, 10 000 000 iterations
		 * direct to props: 124 ms, 10 000 000 iterations
		 */
		private function setterPointTest():void
		{
			var point:Point = new Point();
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
//				point.setTo(3,6);

				//
				point.x = 3;
				point.y = 6;
			}

			timeResult = getTimer() - time;
		}
	}
}
