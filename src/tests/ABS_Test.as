package tests
{
	import flash.utils.getTimer;

	/**
	 */
	public class ABS_Test extends Test
	{
		public function ABS_Test()
		{
			super();
			iterationsTest = 10000000;
		}

		public var absNum:int = 0;

		/**
		 * Built-in:   115 ms,  iteration 10 000 000
		 * Local abs:  234 ms, inline 150, iteration 10 000 000
		 * Local abs1: 218 ms, inline 120,  iteration 10 000 000
		 * Local absT: 209 ms, inline 130,  iteration 10 000 000
		 */
		override public function run():void
		{
			var value:Number = -0.3;

			var time:int = getTimer();
			for (var i:int = 0; i < iterationsTest; i++)
			{
//				Math.abs(value);
				abs(value);
//				abs1(value);
//				absT(value);
			}

			timeResult = getTimer() - time;
		}

		[Inline]
		final private function abs(val:Number):Number
		{
			return (val + (val >> 31)) ^ (val >> 31);
		}

		[Inline]
		final private function abs1(val:Number):Number
		{
			if (val < 0) return -val;
			return val;
		}

		[Inline]
		final private function absT(p_val:Number):Number
		{
			return p_val < 0 ? -p_val : p_val;
		}
	}
}
