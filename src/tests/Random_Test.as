/**
 * User: VirtualMaestro
 * Date: 12.07.13
 * Time: 14:07
 */
package tests
{
	import flash.utils.getTimer;

	import vm.math.rand.RandUtil;

	/**
	 */
	public class Random_Test extends Test
	{
		public function Random_Test(testName:String = "")
		{
			super(testName);

			iterationsTest = 10000000;
		}

		/**
		 */
		override public function run():void
		{
			randTest();
		}

		/**
		 * OS: Win7 x64
		 * Compilers: MXMLC 4.6 / ASC2.0
		 * FP: 11.8
		 *
		 * Standard random: MXMLC 385 ms, ASC2: 385 ms (10 000 000)
		 * Custom fast rand:
		 *  - RandUtil.getFloat(): MXMLC 250 ms, ASC2: 265/245 ms (10 000 000)
		 *  - RandUtil.getFloatUnsign(): MXMLC 270 ms, ASC2: 270/280 ms (10 000 000)
		 *  - RandUtil.getFloatRange(): MXMLC 730 ms, ASC2: 700/750 ms (10 000 000)
		 *
		 * Gaussian random: 1080 ms (10 000 000)
		 */
		private function randTest():void
		{
			var result:Number;
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
//				result = Math.random();
//				result = RandUtil.getFloat();
//				result = RandUtil.getFloatUnsign();
//				result = RandUtil.getFloatRange(0, 1);
				result = RandUtil.getGaussian();
			}

			timeResult = getTimer() - time;
		}
	}
}
