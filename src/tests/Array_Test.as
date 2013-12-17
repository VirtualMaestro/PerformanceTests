package tests
{
	import flash.utils.getTimer;

	/**
	 */
	public class Array_Test extends Test
	{
		private var _vectorInt:Vector.<int>;
		private var _vectorObject:Vector.<Box>;
		private var _head:Box;
		private var _tail:Box;

		/**
		 */
		public function Array_Test()
		{
			iterationsTest = 10000000;

			prepareTest();
		}

		/**
		 */
		private function prepareTest():void
		{
			_head = new Box();
			_tail = _head;

			var box:Box;
			_vectorInt = new <int>[];
			_vectorObject = new <Box>[];

			var obj:Box = new Box();

			for (var i:int = 0; i < iterationsTest; i++)
			{
//				_vectorInt[i] = i;
				_vectorObject[i] = obj;

//				box = new Box();
//				_tail.next = box;
//				box.prev = _tail;
//				_tail = box;
			}
		}

		/**
		 */
		override public function run():void
		{
//			checkingForNullTest();
//			vectorAddObjectVsNull();
			listDirectAddNode();
//			iterationVectorTest();
//			iterationDLLTest();
//			testArrayAdding();
//			testVectorAdding();
//			testListAdding();
//			testLengthPerformance();
		}

		/**
		 * Equal to null test
		 * Native null: 65 ms
		 * Custom null: 68 ms
		 *
		 * Not equal to null test
		 * Native null: 58 ms
		 * Custom null: 68 ms
		 *
		 * If exist (auto-convert to Boolean): 64 ms
		 */
		private function checkingForNullTest():void
		{
			testName = "checkingForNullTest";

			var len:int = iterationsTest;
			var nullObject:Box = new Box();

			var time:int = getTimer();

			for (var i:int = 0; i < len; i++)
			{
//			      if (_vectorObject[i] == null) {}
				if (_vectorObject[i] == nullObject)
				{
				}
//			      if (_vectorObject[i] != null) {}
//			      if (_vectorObject[i] != nullObject) {}
//				  if (_vectorObject[i]) {}
			}

			timeResult = getTimer() - time;
		}

		/**
		 * Vector created and has precreated number of Box elements.
		 * Adds instance of Box class (pseudo null) local: 153 ms
		 * Adds instance of Box class (pseudo null) field of class: 159 ms
		 * Adds instance of Box class (pseudo null, without precreate) field of class: 442 ms
		 * Adds null object: 293 ms
		 */
		private function vectorAddObjectVsNull():void
		{
			_vectorObject = new <Box>[];
			var nullObject:Box = new Box();
			var len:int = iterationsTest;

			var time:int = getTimer();

			for (var i:int = 0; i < len; i++)
			{
//		           _vectorObject[i] = null;
//			      _vectorObject[i] = nullObject;
				_vectorObject[i] = _head;
			}

			timeResult = getTimer() - time;
		}

		/**
		 * Add node: 401 ms
		 */
		private function listDirectAddNode():void
		{
			var node:Box = new Box();
			var len:int = iterationsTest;

			var time:int = getTimer();

			for (var i:int = 0; i < len; i++)
			{
				_tail.next = node;
				node.prev = _tail;
				_tail = node;
			}

			timeResult = getTimer() - time;
		}

		/**
		 * iteration with type int: 55 ms, 10 000 000 iterations
		 * iteration with type BoxResult: 54 ms, 10 000 000 iterations
		 */
		private function iterationVectorTest():void
		{
			var j:int;
			var obj:Box;
			var num:int = iterationsTest;

			var time:int = getTimer();

			for (var i:int = 0; i < num; i++)
			{
				j = _vectorInt[i];
//				obj = _vectorObject[i];
			}

			timeResult = getTimer() - time;
		}

		/**
		 * iteration with type Box: 70 ms, 10 000 000 iterations
		 */
		private function iterationDLLTest():void
		{
			var box:Box = _head;

			var time:int = getTimer();

			while (box)
			{
				box = box.next;
			}

			timeResult = getTimer() - time;
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
		 * direct - 501 ms
		 * push - 600 ms
		 * length - 530 ms
		 */
		private function testArrayAdding():void
		{
			testName = "Add to array via push";
//			testName = "Add to array via [length]";

			var array:Array = [];
			var obj:Box = new Box();

			var iterationTestCount:int = iterationsTest;
			var time:int = getTimer();

			for (var i:int = 0; i < iterationTestCount; i++)
			{
				array[i] = obj;
//				array.push(obj);    //
//				array[array.length] = obj; //
			}

			timeResult = getTimer() - time;
		}

		/**
		 * Vector (10 000 000 iterations):
		 * Int
		 * direct - 616 ms
		 * direct with preset length - 50 ms
		 * direct with preset length and then set to 0 - 479 ms
		 * push -  920 ms
		 * length - 660 ms
		 *
		 * init time of vector (1 iteration) - 0 ms
		 * init time of vector with preset length - 37 ms
		 *
		 * Object
		 * push - 823 ms
		 * length - 465 ms
		 *
		 * Box
		 * direct - 385 ms
		 * direct with preset length - 116 ms
		 */
		private function testVectorAdding():void
		{
//			testName = "Add to vector via push";
			testName = "Add to vector via [length]";

//			var vector:Vector.<int> = new <int>[];
//			var vector:Vector.<int> = new Vector.<int>(iterationsTest);
//			vector.length = 0;
//			var vector:Vector.<Box> = new <Box>[];
			var vector:Vector.<Box> = new Vector.<Box>(iterationsTest);
			var obj:Box = new Box()

			var iterationTestCount:int = iterationsTest;
			var time:int = getTimer();

//			var vector:Vector.<int> = new <int>[];
//			var vector:Vector.<int> = new Vector.<int>(iterationsTest);

			for (var i:int = 0; i < iterationTestCount; i++)
			{
//				vector.push(obj);    //
//				vector[vector.length] = obj; //
//				vector[i] = i;
				vector[i] = obj;
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
	public var prev:Box;
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