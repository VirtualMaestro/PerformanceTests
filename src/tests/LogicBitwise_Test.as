package tests
{
	import flash.utils.getTimer;

	public class LogicBitwise_Test extends Test
	{
		public function LogicBitwise_Test()
		{
			iterationsTest = 100000000;
		}


		override public function run():void
		{
//			booleanTest();   // 2 values - 380 ms; 3 values - 537 ms;
			bitwiseTest();   // 2 values - 285 ms; 3 values - 360 ms;
		}

		private function booleanTest():void
		{
			var bool1:Boolean = true;
			var bool2:Boolean = true;
			var bool3:Boolean = true;

			var count:int = iterationsTest;
			var time:int = getTimer();

			for (var i:int = 0; i < count; i++)
			{
				if (Boolean(bool1 && bool2 && bool3))
				{
					i+1;
				}
			}

			timeResult = getTimer() - time;
		}

		private function bitwiseTest():void
		{
			var bool1:int = 1;
			var bool2:int = 0;
			var bool3:int = 1;

			var count:int = iterationsTest;
			var time:int = getTimer();

			for (var i:int = 0; i < count; i++)
			{
				if ((bool1 & bool2 & bool3))
				{
					i+1;
				}
			}

			timeResult = getTimer() - time;
		}
	}
}
