package tests
{
	import flash.utils.getTimer;

	/**
	 */
	public class Array_Test extends Test
	{
		public function Array_Test()
		{
			iterationsTest = 10000000;
		}

		override public function run():void
		{
//			testArrayAdding();
//			testVectorAdding();
			testListAdding();
//			testLengthPerformance();
		}

		/**
		 * iterationsTest = 10 000 000
		 * with length = 95 ms
		 * with local  = 42 ms
		 */
		private function testLengthPerformance():void
		{
			testName = "test length performance";

			var array:Array = [];
			var len:int = array.length = iterationsTest;

			var time:int = getTimer();

			for (var i:int = 0; i < array.length;)
//			for (var i:int = 0; i < len;)
			{
				i++;
			}

			timeResult = getTimer() - time;
		}

		/**
		 * Array (10 000 000 iterations):
		 * push - 600 ms
		 * length - 530 ms
		 */
		private function testArrayAdding():void
		{
			testName = "Add to array via push";
//			testName = "Add to array via [length]";

			var array:Array = [];
			var obj:Object = {};

			var iterationTestCount:int = iterationsTest;
			var time:int = getTimer();

			for (var i:int = 0; i < iterationTestCount; i++)
			{
				array.push(obj);    //
//				array[array.length] = obj; //
			}

			timeResult = getTimer() - time;
		}

		/**
		 * Vector (10 000 000 iterations):
		 * Int
		 * push -  920 ms
		 * length - 660 ms
		 *
		 * Object
		 * push - 823 ms
		 * length - 465 ms
		 */
		private function testVectorAdding():void
		{
//			testName = "Add to vector via push";
			testName = "Add to vector via [length]";

//			var vector:Vector.<int> = new <int>[];
			var vector:Vector.<Object> = new <Object>[];
			var obj:Object = {};

			var iterationTestCount:int = iterationsTest;
			var time:int = getTimer();

			for (var i:int = 0; i < iterationTestCount; i++)
			{
				vector.push(obj);    //
//				vector[vector.length] = obj; //
			}

			timeResult = getTimer() - time;
		}

		/**
		 * Single list (10 000 000):
		 * add method: 380 ms
		 * direct add: 283 ms
		 */
		private function testListAdding():void
		{
			testName = "Add to list";

			var box:Box = new Box();
			var tBox:Box;
			var boxResult:BoxResult = new BoxResult();
			var iterationTestCount:int = iterationsTest;
			var time:int = getTimer();

			for (var i:int = 0; i < iterationTestCount; i++)
			{
//				boxResult.add(box);

				boxResult.tail.next = box;
				boxResult.tail = box;
			}

			timeResult = getTimer() - time;
		}
	}
}

internal class Box
{
	public var next:Box;
}

internal class BoxResult
{
	public var head:Box;
	public var tail:Box;

	public function BoxResult()
	{
		head = new Box();
		tail = head;
	}

	/**
	 */
	public function add(p_box:Box):void
	{
		tail.next = p_box;
		tail = p_box;
	}

	/**
	 */
	public function getResult():Box
	{
		return head.next;
	}

	/**
	 */
	public function reset():void
	{
		head.next = null;
		tail = head;
	}
}