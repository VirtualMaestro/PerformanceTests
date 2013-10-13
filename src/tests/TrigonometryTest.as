/**
 * User: VirtualMaestro
 * Date: 29.03.13
 * Time: 23:38
 */
package tests
{
	import flash.utils.getTimer;

	/**
	 */
	public class TrigonometryTest extends Test
	{
		public function TrigonometryTest(testName:String = "")
		{
			super(testName);

			iterationsTest = 10000000;
		}

		/**
		 */
		override public function run():void
		{
			cosTest();
		}

		/**
		 * 120 ms - 10 000 000 iterations
		 */
		private function cosTest():void
		{
			var time:int = getTimer();
			for (var i:int = 0; i < iterationsTest; i++)
			{
				Math.cos(0.2);
//				Math.sin(0.2);
			}
			timeResult = getTimer() - time;
		}
	}
}
