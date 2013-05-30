/**
 * User: VirtualMaestro
 * Date: 28.05.13
 * Time: 15:59
 */
package tests
{
	import flash.utils.getTimer;

	import utils.BBRect;

	/**
	 * Need to switch to new ASC2.0 and add param to compiler -inline
	 */
	public class ASC2_Test extends Test
	{
		private var _box1:BBRect;
		private var _box2:BBRect;

		/**
		 */
		public function ASC2_Test(testName:String = "")
		{
			super(testName);

			iterationsTest = 10000000;
			_box1 = new BBRect(0,0, 100, 100);
			_box2 = new BBRect(-100,50, 200, 200);
		}

		override public function run():void
		{
			inliningTest();
		}

		/**
		 */
		private function inliningTest():void
		{
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				_box1.isIntersect(_box2);
			}

			timeResult = getTimer() - time;
		}
	}
}
