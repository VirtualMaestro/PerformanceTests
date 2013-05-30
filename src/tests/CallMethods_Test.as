/**
 * User: VirtualMaestro
 * Date: 02.02.13
 * Time: 22:39
 */
package tests
{
	import flash.utils.getTimer;

	/**
	 * Test performance invokes methods.
	 */
	public class CallMethods_Test extends Test
	{
		public var dummy:DummyClass = null;
		public function CallMethods_Test(testName:String = "CallMethods_Test")
		{
			super(testName);

			iterationsTest = 10000000;
			dummy = new DummyClass();
		}

		/**
		 * Invoke one method - 35-40 ms (1 000 000) - 183 ms (10 000 000)
		 * Invoke method with nested method - 40 ms (1 000 000) - 239 ms (10 000 000)
		 * Invoke with nested method where instantiate simple variable - 36 ms (1 000 000) - 242 ms (10 000 000)
		 */
		override public function run():void
		{
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				dummy.method();
			}

			timeResult = getTimer() - time;
		}
	}
}

internal class DummyClass
{
	public function nestedMethod():void
	{
		var i:int;
	}

	public function method():void
	{
		nestedMethod();
	}
}