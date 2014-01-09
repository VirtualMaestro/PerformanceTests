package tests
{
	import assets.CustomNode;
	import assets.Node;

	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	/**
	 */
	public class Dictionary_Test extends Test
	{
		private var _objects:Array;
		private var _dictionary:Dictionary;

		private var _head:Node;
		private var _tail:Node;

		/**
		 */
		public function Dictionary_Test()
		{
			iterationsTest = 100;

			_objects = [];
			for (var i:int = 0; i < iterationsTest; i++)
			{
//				_objects[i] = {};

				var node:Node = new Node();

				if (_tail)
				{
					_tail.next = node;
					node.prev = _tail;
					_tail = node;
				}
				else _head = _tail = node;
			}

			node = new CustomNode();
			_tail.next = node;
			node.prev = _tail;
			_tail = node;

			_dictionary = new Dictionary();
			_dictionary[Node] = new Node();
			_dictionary[CustomNode] = new CustomNode();
		}

		/**
		 */
		override public function run():void
		{
			dllVSDic();
//			writeTest();   // 270
//			deleteTest();  // 74
		}

		/**
		 */
		private function dllVSDic():void
		{
			var node:Node;
			var time:int = getTimer();

			for (var i:int = 0; i < 1000; i++)
			{
//				node = _head;
//				while(node)
//				{
//					if (node is CustomNode)
//					{
//						break;
//					}
//					node = node.next;
//				}

				//
				node = _dictionary[CustomNode];
			}

			timeResult = getTimer() - time;
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
				for (i = 0; i < iterationsTest; i++)
				{
					_dictionary[_objects[i]] = "1";
				}
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
