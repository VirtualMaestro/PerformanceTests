package tests
{
	import flash.geom.Matrix;
	import flash.utils.getTimer;

	/**
	 * ...
	 * @author VirtualMaestro
	 */
	public class MathTest extends Test
	{
		private const DEG_TO_RAD:Number = Math.PI / 180.0;
		private const RAD_TO_DEG:Number = 180.0 / Math.PI;

		private var _sinTable:Vector.<Number>;
		private var _cosTable:Vector.<Number>;

		private var _matrix:Matrix;
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _pivotX:Number;
		private var _pivotY:Number;
		private var _rotation:Number;
		private var _positionX:Number;
		private var _positionY:Number;

		/**
		 */
		public function MathTest()
		{
			super();
			prepareSinCosTable();

			_matrix = new Matrix();
			_scaleX = 0.3;
			_scaleY = 0.3;
			_pivotX = 30;
			_pivotY = 50;
			_rotation = 36 * DEG_TO_RAD;
			_positionX = 310;
			_positionY = 260;

			iterationsTest = 10000000;
//			iterationsTest = 1;
		}

		/**
		 */
		override public function run():void
		{
			//testIdentity();
//			matrixTest();
			//originRound();
			//customRound();

			//originSinCos();
			customSinCos();
		}

		/**
		 * Matrix.identity: 68 ms, 10 000 000 iterations
		 * Matrix.setTo: 90 ms, 10 000 000 iterations
		 * Matrix by hand: 25 ms, 10 000 000 iterations
		 */
		private function testIdentity():void
		{
			var matrix:Matrix = new Matrix();
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				//matrix.identity();
				//matrix.setTo(1,0,0,1,0,0);

				// by hand
				matrix.a = 1;
				matrix.b = 0;
				matrix.c = 0;
				matrix.d = 1;
				matrix.tx = 0;
				matrix.ty = 0;
			}

			timeResult = getTimer() - time;
		}

		/**
		 * Usual matrix's methods:  813 ms, 10 000 000 iterations
		 * By hand and setTo:       560 ms,  1 000 000 iterations
		 * By hand fully:           464 ms, 1 000 000 iterations
		 */
		private function matrixTest():void
		{
			var cosVal:Number;
			var sinVal:Number;
			var a:Number;
			var b:Number;
			var c:Number;
			var d:Number;
			var tx:Number;
			var ty:Number;

			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				// Usual matrix's methods
				//_matrix.identity();
				//_matrix.scale(_scaleX, _scaleY);
				//_matrix.translate(_pivotX, _pivotY);
				//_matrix.rotate(_rotation);
				//_matrix.translate(_positionX, _positionY);

				// by hand
				cosVal = Math.cos(_rotation);
				sinVal = Math.sin(_rotation);
				a = _scaleX;
				b = 0;
				c = 0;
				d = _scaleY;
				tx = _pivotX;
				ty = _pivotY;

				_matrix.a = a * cosVal - b * sinVal;
				_matrix.b = a * sinVal + b * cosVal;
				_matrix.c = c * cosVal - d * sinVal;
				_matrix.d = c * sinVal + d * cosVal;
				_matrix.tx = (cosVal * tx - sinVal * ty) + _positionX;
				_matrix.ty = (sinVal * tx + cosVal * ty) + _positionY;

				// By hand and setTo
				//var aa:Number =  a * cosVal - b * sinVal;
				//var bb:Number = a * sinVal + b * cosVal;
				//var cc:Number = c * cosVal - d * sinVal; 
				//var dd:Number = c * sinVal + d * cosVal;
				//var ttx:Number = (cosVal * tx - sinVal * ty) + _positionX;
				//var tty:Number = (sinVal * tx + cosVal * ty) + _positionY;
				//_matrix.setTo(aa, bb, cc, dd, ttx, tty);
			}

			timeResult = getTimer() - time;
		}

		/**
		 * Native round: 33 ms, 10 000 000 iterations
		 */
		private function originRound():void
		{
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				Math.round(-1.57);
			}

			timeResult = getTimer() - time;
		}

		/**
		 * Custom round: 22 ms, 10 000 000 iterations
		 */
		final private function customRound():void
		{
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				round(-1.57);
			}

			timeResult = getTimer() - time;
		}

		[Inline]
		final private function round(p_val:Number):int
		{
			p_val += p_val < 0 ? -0.5 : 0.5;
			return int(p_val);
		}

		/**
		 * Native Math.cos: 33 ms, 10 000 000 iterations
		 * Both: 54 ms, 10 000 000 iterations
		 */
		private function originSinCos():void
		{
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				Math.cos(0.0001365);
				Math.sin(0.0001365);
			}

			timeResult = getTimer() - time;
		}

		/**
		 * Custom approximation cos: 21 ms, 10 000 000 iterations
		 * Both: 23 ms, 10 000 000 iterations
		 */
		private function customSinCos():void
		{
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				cos(0.0001365);
				sin(0.0001365);
			}

			timeResult = getTimer() - time;
		}

		/**
		 */
		[Inline]
		final private function cos(p_angleRad:Number):Number
		{
			var angle:int = p_angleRad * RAD_TO_DEG;
			angle += angle < 0 ? 360 : 0;
			return _cosTable[angle];
		}

		/**
		 */
		[Inline]
		final private function sin(p_angleRad:Number):Number
		{
			var angle:int = p_angleRad * RAD_TO_DEG;
			angle += angle < 0 ? 360 : 0;
			return _sinTable[angle];
		}

		/**
		 */
		private function prepareSinCosTable():void
		{
			_sinTable = new <Number>[];
			_cosTable = new <Number>[];
			var angleRad:Number;

			for (var i:int = 0; i < 360; i++)
			{
				angleRad = i * DEG_TO_RAD;
				_sinTable[i] = Math.sin(angleRad);
				_cosTable[i] = Math.cos(angleRad);
			}
		}
	}
}