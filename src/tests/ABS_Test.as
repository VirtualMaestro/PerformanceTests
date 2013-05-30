package tests
{
	import flash.utils.getTimer;

	import vm.math.numbers.NumberUtil;

	/**
	 */
	public class ABS_Test extends Test
	{
		public function ABS_Test()
		{
			super();
		}

		public var absNum:int = 0;

		/**
		 */
		override public function run():void
		{
			var time:int = getTimer();
			for (var i:int = 0; i < iterationsTest; i++)
			{
				absNum += Math.abs(5);  // standart
//				absNum +=  NumberUtil.math.abs(5);
//				absNum += abs(5);
			}

			timeResult = getTimer() - time;
		}

		private function abs(val:Number):Number
		{
			return (val + (val >> 31)) ^ (val >> 31);
		}
	}
}
