package tests
{
	import assets.Node;

	import flash.utils.getTimer;

	/**
	 * ...
	 * @author VirtualMaestro
	 */
	public class Pool_Test extends Test
	{

		public function Pool_Test()
		{
			super();

			iterationsTest = 1000000;

			//preCache(iterationsCount);
			//preCacheNodes(iterationsCount);
		}

		/**
		 */
		override public function run():void
		{
			getVSCreationTest();
			//dllCacheTest();
		}

		/**
		 * Creation: 86 ms, 4.14 Mb (1 000 000)
		 *
		 * Get pool: 10 ms, 36.58 Mb (1 000 000)
		 * Get pool with immideately nullify in pool: 80 ms, 14.05 Mb (1 000 000)
		 * Get and put: 33 ms, 36.58 Mb  (1 000 000)
		 * Get and put with rid: 120 ms, 13.44 Mb  (1 000 000)
		 *
		 * Get: rid with nullObject: 83 ms, 13.39 Mb (1 000 000)
		 * Get: rid with nullObject and shrink: 84 ms, 13.620 Mb (1 000 000)
		 * Get: rid with null and shrink: 95 ms, 14.560 Mb (1 000 000)
		 */
		private function getVSCreationTest():void
		{
			preCache(iterationsTest);

			var len:int = iterationsTest;
			var point:Node;
			var time:int = getTimer();

			for (var i:int = 0; i < len; i++)
			{
				//point = new Node();
				point = get();
				put(point);
			}

			rid(true);

			timeResult = getTimer() - time;
		}

		/**
		 * Get node: 76 ms, 6.52 Mb (1 000 000)
		 * Get and put: 41 ms, 30.48 Mb  (1 000 000)
		 * Get and put with rid: 106 ms, 6.52 Mb  (1 000 000)
		 */
		private function dllCacheTest():void
		{
			preCacheNodes(iterationsTest);

			var len:int = iterationsTest;
			var point:Node;
			var time:int = getTimer();

			for (var i:int = 0; i < len; i++)
			{
				point = getNode();
				putNode(point);
			}

			ridNodePool();

			timeResult = getTimer() - time;
		}

		// POOL //
		static private var _pool:Vector.<Node> = new <Node>[];
		static private var _size:int = 0;
		static private const nullObject:Node = new Node();

		/**
		 */
		static public function get():Node
		{
			var point:Node;

			if (_size > 0)
			{
				point = _pool[--_size];
				//_pool[_size] = nullObject;
			}
			else point = new Node();

			return point;
		}

		/**
		 */
		static public function put(p_point:Node):void
		{
			_pool[_size++] = p_point;
		}

		/**
		 */
		static public function preCache(p_num:int):void
		{
			for (var i:int = 0; i < p_num; i++)
			{
				put(new Node());
			}
		}

		/**
		 */
		static public function rid(p_shrink:Boolean = false):void
		{
			var len:int = _pool.length;
			for (var i:int = 0; i < len; i++)
			{
				//_pool[i] = nullObject;
				_pool[i] = null;
			}

			_size = 0;

			if (p_shrink) _pool.length = 0;
		}

		// pool
		static private var _headPool:Node = null;
		static private var _numInPool:int = 0;

		/**
		 * Returns Node instance.
		 * Uses pool, so in order to put it back to pool need to call method 'dispose'.
		 */
		static public function getNode():Node
		{
			var node:Node;
			if (_headPool)
			{
				node = _headPool;
				_headPool = _headPool.next;
				node.next = null;
				--_numInPool;
			}
			else node = new Node();

			return node;
		}

		/**
		 */
		static public function putNode(p_node:Node):void
		{
			if (_headPool) p_node.next = _headPool;
			else p_node.next = null;

			_headPool = p_node;
			++_numInPool;
		}

		/**
		 */
		static public function preCacheNodes(p_num:int):void
		{
			for (var i:int = 0; i < p_num; i++)
			{
				putNode(new Node());
			}
		}

		static public function ridNodePool():void
		{
			var node:Node = _headPool;
			var curNode:Node;

			while (node)
			{
				curNode = node;
				node = node.next;

				curNode.next = null;
			}
		}
	}

}