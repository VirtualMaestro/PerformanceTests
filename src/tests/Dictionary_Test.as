package tests
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	/**
	 */
	public class Dictionary_Test extends Test
	{
		private var _objects:Array;
		private var _dictionary:Dictionary;

		/**
		 */
		public function Dictionary_Test()
		{
			iterationsTest = 1000000;

			_objects = [];
			for (var i:int = 0; i < iterationsTest; i++)
			{
				_objects[i] = {};
			}
		}

		/**
		 */
		override public function run():void
		{
			writeTest();   // 270
//			deleteTest();  // 74
		}

		/**
		 */
		private function writeTest():void
		{
			testName = "writeTest";
			_dictionary = new Dictionary();

			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				_dictionary[_objects[i]] = "1";
			}

			timeResult = getTimer() - time;
		}

		/**
		 */
		private function deleteTest():void
		{
			testName = "deleteTest";

			var i:int;
//			if (_dictionary == null)
			{
				_dictionary = new Dictionary();
				for (i = 0; i < iterationsTest; i++) _dictionary[_objects[i]] = "1";
			}

			var obj:Object;
			var time:int = getTimer();

			for (i = 0; i < iterationsTest; i++)
			{
				delete _dictionary[_objects[i]];
			}

			timeResult = getTimer() - time;
		}
	}
}
