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

	import vm.math.rand.RandUtil;

	public class Matrix_Test extends Test
	{
		private var _matrix:Matrix;

		public function Matrix_Test()
		{
//			iterationsTest = 1;
			iterationsTest = 1000000;

			_matrix = new Matrix();
		}

		/**
		 */
		override public function run():void
		{
			testCreateBox();
//			transformPointTest();
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
		 * Invoke methods by hand: 135 ms
		 * Use create box method: 107 ms
		 * Calc manually: 95 ms
		 */
		private function testCreateBox():void
		{
			var r:Number = RandUtil.getFloatRange(-3, 3);//Math.PI/2;
			var sX:Number = RandUtil.getFloatRange(-2, 2);//2;
			var sY:Number = RandUtil.getFloatRange(-2, 2);//1.5;
			var tX:Number = 10;
			var tY:Number = 30;

			var len:int = iterationsTest;

			var time:int = getTimer();

			for (var i:int = 0; i < len; i++)
			{
				//
//				_matrix.identity();
//				_matrix.rotate(r);
//				_matrix.scale(sX,sY);
//				_matrix.translate(tX,tY);

				//
//				_matrix.createBox(sX, sY, r, tX, tY);

				//
				var cos:Number = Math.cos(r);
				var sin:Number = Math.sin(r);

				_matrix.a = cos * sX;
				_matrix.b = sin * sY;
				_matrix.c = -sin * sX;
				_matrix.d = cos * sY;
				_matrix.tx = tX;
				_matrix.ty = tY;
			}

			timeResult = getTimer() - time;
		}
	}
}
