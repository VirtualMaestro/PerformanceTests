package tests
{
	import assets.Node;

	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	/**
	 */
	public class Dictionary_Test extends Test
	{
		private var _objects:Vector.<Point>;
		private var _dictionary:Dictionary;
		private var _specialNode:Node;

		private var _head:Node;
		private var _tail:Node;

		/**
		 */
		public function Dictionary_Test()
		{
			iterationsTest = 1000000;

			initObjects();
//			initDLL();
		}

		/**
		 */
		private function initObjects():void
		{
			var point:Point;

			_objects = new <Point>[];
			_dictionary = new Dictionary();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				point = new Point();
				_objects[i] = point;
				_dictionary[point] = point;
			}
		}

		/**
		 */
		private function initDLL():void
		{
			_dictionary = new Dictionary();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				addToList(new Node());
			}

			_specialNode = new Node();
			addToList(_specialNode);
		}

		/**
		 */
		private function addToList(p_node:Node):void
		{
			if (_tail)
			{
				_tail.next = p_node;
				p_node.prev = _tail;
				_tail = p_node;
			}
			else _head = _tail = p_node;

			_dictionary[p_node] = p_node;
		}

		/**
		 */
		override public function run():void
		{
//			dllVSDicSearchTest();
//			deleteFromDLLTest();
//			writeToDicTest();
//			deleteFromDicTest();
//			forDicTest();
			vectorIterationTest();
		}

		/**
		 * Searching traversal by DLL: 845 ms, 100 iteration by 1 000 000 elements
		 * Searching traversal by DLL:  63 ms, 1 000 000 iteration by 10 elements
		 * Searching traversal by DLL: 487 ms, 100 000 iteration by 1000 elements
		 * Searching traversal by DLL:  64 ms, 100 000 iteration by 100 elements
		 *
		 * Searching by dictionary:  0 ms, 100 iteration by 1 000 000 elements
		 * Searching by dictionary: 70 ms, 1 000 000 iteration by 10 elements
		 * Searching by dictionary: 13 ms, 100 000 iteration by 1000 elements
		 * Searching by dictionary: 14 ms, 100 000 iteration by 100 elements
		 */
		private function dllVSDicSearchTest():void
		{
			testName = "dllVSDicSearchTest";

			var node:Node;
			var time:int = getTimer();

			for (var i:int = 0; i < 100000; i++)
			{
				node = _head;
				while (node)
				{
					if (node == _specialNode)
					{
						break;
					}

					node = node.next;
				}

				//
//				node = _dictionary[_specialNode];
			}

			timeResult = getTimer() - time;
		}

		/**
		 * 30 ms, 1 000 000 iterations
		 */
		private function deleteFromDLLTest():void
		{
			testName = "deleteFromDLLTest";

			initDLL();

			var node:Node = _head;
			var curNode:Node;

			var time:int = getTimer();

			while (node)
			{
				curNode = node;
				node = node.next;

				//
				if (curNode == _head)
				{
					_head = _head.next;

					if (_head == null) _tail = null;
					else _head.prev = null;
				}
				else if (curNode == _tail)
				{
					_tail = _tail.prev;

					if (_tail == null) _head = null;
					else _tail.next = null;
				}
				else
				{
					var prevBullet:Node = curNode.prev;
					var nextBullet:Node = curNode.next;
					prevBullet.next = nextBullet;
					nextBullet.prev = prevBullet;
				}
			}

			timeResult = getTimer() - time;
		}

		/**
		 * 183 ms, 1 000 000 iterations
		 */
		private function writeToDicTest():void
		{
			testName = "writeToDicTest";

			var point:Point;
			var num:int = iterationsTest;
			_dictionary = new Dictionary();

			var time:int = getTimer();

			for (var i:int = 0; i < num; i++)
			{
				point = _objects[i];
				_dictionary[point] = point;
			}

			timeResult = getTimer() - time;
		}

		/**
		 * 67 ms, 1 000 000 iterations
		 */
		private function deleteFromDicTest():void
		{
			testName = "deleteFromDicTest";

			var i:int;
			var num:int = iterationsTest;
			var point:Point;
			_dictionary = new Dictionary();

			for (i = 0; i < num; i++)
			{
				point = _objects[i];
				_dictionary[point] = point;
			}

			var time:int = getTimer();

			for (i = 0; i < num; i++)
			{
				delete _dictionary[_objects[i]];
			}

			timeResult = getTimer() - time;
		}

		/**
		 * For each: 107 ms, 1 000 000 iterations
		 * For: 88 ms, 1 000 000 iterations
		 */
		private function forDicTest():void
		{
			testName = "forDicTest";

			var time:int = getTimer();

//			for each(var point:Point in _dictionary) {}
			for (var point:Object in _dictionary)
			{
			}

			timeResult = getTimer() - time;
		}

		/**
		 * 10 ms, 1 000 000 iterations
		 */
		private function vectorIterationTest():void
		{
			testName = "vectorIterationTest";
			var point:Point;
			var num:int = iterationsTest;

			var time:int = getTimer();

			for (var i:int = 0; i < num; i++)
			{
				point = _objects[i];
			}

			timeResult = getTimer() - time;

		}
	}
}
