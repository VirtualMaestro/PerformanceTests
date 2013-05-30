package
{
	import flash.display.Sprite;
	import flash.system.System;

	import vm.classes.ClassUtil;

	public class Test extends Sprite
	{
		private var _testName:String = "";
		private var _timeResult:int = 0;
		private var _averageTime:int = 0;
		private var _repeatTestCount:int = 10;
		private var _currentRepeatedCount:int = 0;
		private var _timeCollector:int = 0;
		private var _memoryStamp:uint = 0;
		private var _delayBeforeRun:int = 2000;
		private var _iterationsTest:int = 100000;
		private var _outputFields:Array = [];

		/**
		 */
		public function Test(testName:String="")
		{
			_testName = (testName == "") ? ClassUtil.getClassNameWithoutPackage(this): testName;
		}

		/**
		 * Start test. Should be override in child.
		 */
		public function run():void
		{
			//
		}

		/**
		 * Parameter result time of test.
		 */
		public function set timeResult(time:int):void
		{
			_timeResult = time;
			_currentRepeatedCount++;
			_timeCollector += _timeResult;
			_averageTime = _timeCollector / _currentRepeatedCount;

			// memory manage
			if (_memoryStamp > System.totalMemory) _memoryStamp = _memoryStamp - System.totalMemory;
			else _memoryStamp = System.totalMemory - _memoryStamp;
		}

		/**
		 */
		public function get timeResult():int
		{
			return _timeResult;
		}

		/**
		 */
		public function get averageTime():int
		{
			return _averageTime;
		}

		/**
		 * Set delay before test run in milliseconds.
		 */
		public function set delayBeforeRun(value:int):void
		{
			_delayBeforeRun = value;
		}

		/**
		 */
		public function get delayBeforeRun():int
		{
			return _delayBeforeRun;
		}

		/**
		 */
		public function set repeatTestCount(value:int):void
		{
			_repeatTestCount = value;
		}

		/**
		 */
		public function get repeatTestCount():int
		{
			return _repeatTestCount;
		}

		/**
		 */
		public function get testName():String
		{
			return _testName;
		}

		/**
		 */
		public function set testName(val:String):void
		{
			_testName = val;
		}

		/**
		 */
		public function memoryStamp():void
		{
			_memoryStamp = System.totalMemory;
		}

		public function getMemoryStamp():int
		{
			return _memoryStamp / 1024;
		}

		/**
		 */
		public function set iterationsTest(value:int):void
		{
			_iterationsTest = value;
		}

		public function get iterationsTest():int
		{
			return _iterationsTest;
		}

		/**
		 */
		public function get currentRepeatedCount():int
		{
			return _currentRepeatedCount;
		}

		/**
		 */
		public function addOutputField(name:String, value:String):void
		{
			_outputFields.push({name:name, value:value});
		}

		/**
		 */
		public function getOutputFields():Array
		{
			return _outputFields;
		}

		/**
		 */
		public function resetOutputFields():void
		{
			_outputFields.length = 0;
		}
	}
}
