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
		 * Local abs:  234 ms,  iteration 10 000 000
		 * Local abs1: 218 ms,  iteration 10 000 000
		 */
		override public function run():void
		{
			var value:Number = -0.3;

			var time:int = getTimer();
			for (var i:int = 0; i < iterationsTest; i++)
			{
				Math.abs(value);
//				absNum +=  NumberUtil.math.abs(5);
//				abs(value);
//				abs1(value);
			}

			timeResult = getTimer() - time;
		}

		private function abs(val:Number):Number
		{
			return (val + (val >> 31)) ^ (val >> 31);
		}

		private function abs1(val:Number):Number
		{
			if (val < 0) return -val;
			return val;
		}
	}
}
