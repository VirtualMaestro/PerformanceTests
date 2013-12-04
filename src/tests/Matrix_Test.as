/**
 * User: VirtualMaestro
 * Date: 07.02.13
 * Time: 23:01
 */
package tests
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.getTimer;

	public class Matrix_Test extends Test
	{
		private var _matrix:Matrix;

		public function Matrix_Test()
		{
			iterationsTest = 1;
//			iterationsTest = 1000000;

			_matrix = new Matrix();
		}

		/**
		 */
		override public function run():void
		{
//			testCreateBox();
			transformPointTest();
		}

		/**
		 * 230 ms - 1 000 000 iterations
		 */
		private function transformPointTest():void
		{
			testName = "transformPointTest";

			_matrix.identity();
			_matrix.translate(100, 150);
			_matrix.scale(0.3, 0.4);
			_matrix.rotate(0.2);
			_matrix.translate(10, 15);
			var point:Point = new Point(230, 145);

			var time:int = getTimer();
			for (var i:int = 0; i < iterationsTest; i++)
			{
				_matrix.transformPoint(point);
			}
			timeResult = getTimer() - time;
		}

		/**
		 * iterationsTest = 1000000;
		 * by hand - 150 ms
		 * create box - 110 ms
		 */
		private function testCreateBox():void
		{
			var len:int = iterationsTest;

			var time:int = getTimer();

			for (var i:int = 0; i < len; i++)
			{
				//
//				_matrix.identity();
//				_matrix.rotate(1);
//				_matrix.scale(1,1);
//				_matrix.translate(1,1);

				//
				_matrix.createBox(1, 1, 1, 1, 1);
			}

			timeResult = getTimer() - time;
		}
	}
}
