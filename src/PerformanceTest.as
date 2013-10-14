package
{

	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;

	import vm.debug.DebugUtil;

	/**
	 * This project was created for performance testing of different approaches and algorithms.
	 * E.g. maths algorithms.
	 *
	 */
	[SWF(width="800", height="600", frameRate="30")]
	public class PerformanceTest extends Sprite
	{
		private var _delayBeforeRun:int = 2000;
		private var _repeatTest:int = 1;

		//
		private var _timer:Timer;
		private var _currentTest:Test;
		private var _output:TextField;

		public function PerformanceTest()
		{
//			addChild(new TheMiner());

			// tests
//			addTest(new Random_Test());
//			addTest(new PerlinNoise_Test());
//			addTest(new String_Test());
//			addTest(new ASC2_Test());
//			addTest(new XMLTest());
//			addTest(new TrigonometryTest());
//			addTest(new Draw_Test());
//			addTest(new Rectangles_Test());
//			addTest(new Numbers_Test());
//			addTest(new Matrix_Test());
//			addTest(new CallMethods_Test());
//			addTest(new Class_Test());
//			addTest(new Signals_Test());
//			addTest(new Dictionary_Test());
//			addTest(new LogicBitwise_Test());
//			addTest(new Array_Test());
//			addTest(new QueryShapeBodiesInCircle_Test());
//			addTest(new ABS_Test());
//			addTest(new Intersect_Test());
//			addTest(new Lists_Test());
//			addTest(new Singleton_VS_Static_Test());

			//
			initOutput();
			initTimer();

		}

		private function initTimer():void
		{
			_timer = new Timer(_delayBeforeRun, _repeatTest);
			_timer.addEventListener(TimerEvent.TIMER, startTesting);
			_timer.start();
		}

		private function initOutput():void
		{
			_output = DebugUtil.getTextField();
			_output.x = _output.y = 0;
			addChild(_output);
		}

		private function startTesting(event:TimerEvent):void
		{
			_currentTest.run();

			getResult();
		}

		/**
		 */
		private function addTest(test:Test):void
		{
			_currentTest = test;
			addChild(_currentTest);

			_repeatTest = _currentTest.repeatTestCount;
			_delayBeforeRun = _currentTest.delayBeforeRun;
		}

		/**
		 */
		private function getResult():void
		{
			_output.text = "Test name: " + _currentTest.testName + " \nTime: " + _currentTest.timeResult + " ms" +
					"\nAverage time: " + _currentTest.averageTime + "\nIterations: " + _currentTest.iterationsTest + "\nCount of run: " + _currentTest.currentRepeatedCount +
					"\nMemory: " + _currentTest.getMemoryStamp() + " kb";

			var additionalFields:Array = _currentTest.getOutputFields();
			var len:int = additionalFields.length;

			if (len > 0)
			{
				var field:Object;
				for (var i:int = 0; i < len; i++)
				{
					field = additionalFields[i];
					_output.appendText("\n" + field.name + ": " + field.value);
				}
			}
		}
	}
}
