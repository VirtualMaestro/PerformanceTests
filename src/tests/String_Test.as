/**
 * User: VirtualMaestro
 * Date: 09.06.13
 * Time: 11:42
 */
package tests
{
	import flash.utils.getTimer;

	/**
	 */
	public class String_Test extends Test
	{
		/**
		 */
		public function String_Test(testName:String = "")
		{
			super(testName);

			iterationsTest = 10000000;
		}

		/**
		 */
		override public function run():void
		{
			castIntTest();
		}

		/**
		 * Constructor cast: 121 ms (10 000 000 iterations)
		 * Concatenation cast: 109 ms (10 000 000 iterations)
		 */
		private function castIntTest():void
		{
			testName = "cast test";

			var str:String;
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				str = String(i);
//				str = i+""
			}

			timeResult = getTimer() - time;
		}
	}
}
