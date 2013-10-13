/**
 * User: VirtualMaestro
 * Date: 12.02.13
 * Time: 21:58
 */
package tests
{
	import flash.utils.getTimer;

	import vm.math.numbers.NumberUtil;

	/**
	 */
	public class Numbers_Test extends Test
	{
		/**
		 */
		public function Numbers_Test()
		{
			super();

			iterationsTest = 10000000;
		}

		/**
		 * Standard method Math.round - 117 ms (10 000 000)
		 * Custom method roundFloat  - 1441 ms (10 000 000)
		 * New Custom method round  - 417 ms (10 000 000)
		 * New Custom method round (with array)  - 600 ms (10 000 000)
		 * Inline new custom round - 117 ms (10 000 000)
		 */
		override public function run():void
		{
//			roundTest();
//			absTest();
//			divMod();
			minMaxTest();
//			floorTest();
		}

		/**
		 * Standard Math.floor: 115 ms (10000000)
		 * Custom AntMath.floor: 240 ms (10000000)
		 */
		private function floorTest():void
		{
			testName = "floorTest";
			var time:int = getTimer();

			var testValue:Number = -3.745;

			for (var i:int = 0; i < iterationsTest; i++)
			{
//				Math.floor(testValue);
//				AntMath.floor(testValue);
			}

			timeResult = getTimer() - time;
		}

		/**
		 * Standard Math.min: 256 ms (10 000 000)
		 * Own NumberUtil.min: 217 ms (10 000 000)
		 * Local min: 211  ms (10 000 000)
		 */
		private function minMaxTest():void
		{
			testName = "minMaxTest";
			var time:int = getTimer();
			var testValue1:Number = -3.745;
			var testValue2:Number = -3.67;

			for (var i:int = 0; i < iterationsTest; i++)
			{
//				Math.min(testValue1, testValue2);
//				NumberUtil.min(testValue1, testValue2);
				min(testValue1, testValue2);
			}

			timeResult = getTimer() - time;
		}

		private function min(p_val1:Number, p_val2:Number):Number
		{
			if (p_val1 < p_val2) return p_val1;
			return p_val2;
		}

		/**
		 * Results: 108 ms (10 000 000)
		 */
		private function divMod():void
		{
			testName = "divMod";
			var time:int = getTimer();
			var PI:Number = Math.PI;
			var testValue:Number = 3.67 * PI;
			var res:Number;

			for (var i:int = 0; i < iterationsTest; i++)
			{
				res = testValue % PI;
			}

			timeResult = getTimer() - time;
		}

		/**
		 * Built-in abs: 115 ms (10000000)
		 * Own abs:      220 ms (10000000)
		 */
		private function absTest():void
		{
			testName = "abs test";
			var testValue:Number = -Math.PI;

			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
//				Math.abs(testValue);
//				NumberUtil.abs(testValue);
			}

			timeResult = getTimer() - time;
		}

		/**
		 */
		private function roundTest():void
		{
			testName = "Standard round";
//			testName = "Custom round";
//			var number:Number = -359.9999999999997;
			var number:Number = 6.283185307179582;
			var period:int = 5;
			var some:Number;

			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
//				Math.round(number);
//				NumberUtil.roundFloat(number);
				NumberUtil.round(number, period);
//				some = Math.round(number * period) / period;
			}

			timeResult = getTimer() - time;
		}
	}
}
