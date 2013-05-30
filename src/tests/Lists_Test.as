package tests
{
	import de.polygonal.ds.DLL;
	import de.polygonal.ds.DLLIterator;
	import de.polygonal.ds.DLLNode;

	import flash.utils.getTimer;

	import nape.phys.Body;
	import nape.phys.BodyIterator;

	import nape.phys.BodyList;

	import zpp_nape.util.ZNPNode_ZPP_Body;

	/**
	 */
	public class Lists_Test extends Test
	{
		private var _dsList:DLL;
		private var _napeList:BodyList;

		//
		private var _isNape:Boolean = false;

		/**
		 */
		public function Lists_Test()
		{
			super("");

			iterationsTest = 10000000;

			if (_isNape) _napeList = napeListWriteTest(false, false);
			else _dsList = dsListWriteTest(false, false);
		}

		override public function run():void
		{
			if (_isNape)
			{
//				napeListWriteTest();        // 300 ms  (1 000 000)
//				napeListReadDirectTest();  //  70 ms   (10 000 000)
//				napeListReadIteratorTest(); // 1030 ms (10 000 000)
//				napeListReadAtTest();      //  1677 ms (10 000 000)

//				napeListReadForeachTest();  // 1800 ms - anonymous function; 1360 ms - private method;  (10 000 000)
			}
			else
			{
//				dsListWriteTest();        // 300 ms  (1 000 000)
//				dsListReadDirectTest();   // 70 ms   (10 000 000)
//				dsListReadIteratorTest(); // 400 ms  (10 000 000)
//				dsListReadAtTest();       // 1750 ms (10 000 000)
			}
		}

		private function dsListReadAtTest():void
		{
			var bodyObj:Body;

			var time:int = getTimer();

			var len:int = _dsList.size();
			for (var i:int = 0; i < len; i++)
			{
				bodyObj = _dsList.getNodeAt(i).val as Body;
			}

			time = getTimer() - time;
			timeResult = time;
		}

		/**
		 * Nape read 'at' test
		 */
		private function napeListReadAtTest():void
		{
			var bodyObj:Body;

			var time:int = getTimer();

			var len:int = _napeList.length;
			for (var i:int = 0; i < len; i++)
			{
				bodyObj = _napeList.at(i);
			}

			time = getTimer() - time;
			timeResult = time;
		}

		/**
		 * DS read 'direct' test
		 */
		private function dsListReadDirectTest(isNeedResults:Boolean = true):void
		{
			var bodyObj:Body;
			var node:DLLNode;
			var dll:DLL = _dsList;

			var time:int = getTimer();

			node = dll.head;

			while(node)
			{
				bodyObj = node.val as Body;
				node = node.next;
			}

			time = getTimer() - time;
			if (isNeedResults) timeResult = time;
		}

		/**
		 * Nape read 'direct' test
		 */
		private function napeListReadDirectTest(isNeedResults:Boolean = true):void
		{
			var bodyObj:Body;
			var bodyList:BodyList = _napeList;
			var node:ZNPNode_ZPP_Body;

			var time:int = getTimer();

			node = bodyList.zpp_inner.inner.head;

			while(node)
			{
				bodyObj = node.elt.outer;
				node = node.next;
			}

			time = getTimer() - time;
			if (isNeedResults) timeResult = time;
		}

		/**
		 * Nape read 'foreach' test
		 */
		private function napeListReadForeachTest(isNeedResults:Boolean = true):void
		{
			var bodyObj:Body;

			var time:int = getTimer();

			_napeList.foreach(function(body:Body):void
			{
				bodyObj = body;
			});

//			_napeList.foreach(forEachBody);

			time = getTimer() - time;
			if (isNeedResults) timeResult = time;
		}

		private function forEachBody(body:Body):void
		{
			body;
		}

		/**
		 * DS read 'iterator' test
		 */
		private function dsListReadIteratorTest(isNeedResults:Boolean = true):void
		{
			var bodyObj:Body;
			var iterator:DLLIterator = _dsList.iterator() as DLLIterator;

			var time:int = getTimer();

			while(iterator.hasNext())
			{
				bodyObj = iterator.next() as Body;
			}

			time = getTimer() - time;
			if (isNeedResults) timeResult = time;
		}

		/**
		 * Nape read 'iterator' test
		 */
		private function napeListReadIteratorTest(isNeedResults:Boolean = true):void
		{
			var bodyObj:Body;
			var iterator:BodyIterator = _napeList.iterator();

			var time:int = getTimer();

			while(iterator.hasNext())
			{
				bodyObj = iterator.next();
			}

			time = getTimer() - time;
			if (isNeedResults) timeResult = time;
		}

		/**
 		 * DS write test
		 */
		private function dsListWriteTest(isNeedResults:Boolean = true, writeUnique:Boolean = false):DLL
		{
			var bodyObj:Body = new Body();
			var dll:DLL = new DLL();

			var i:int;
			var time:int;

			if (writeUnique)
			{
				time = getTimer();
				for (i = 0; i < iterationsTest; i++)
				{
					dll.append(new Body());
				}
				time = getTimer() - time;
			}
			else
			{
				time = getTimer();
				for (i = 0; i < iterationsTest; i++)
				{
					dll.append(bodyObj);
				}
				time = getTimer() - time;
			}

			if (isNeedResults) timeResult = time;

			return dll;
		}

		/**
		 * Nape write test
		 */
		private function napeListWriteTest(isNeedResults:Boolean = true, writeUnique:Boolean = false):BodyList
		{
			var bodyObj:Body = new Body();
			var bodyList:BodyList = new BodyList();

			var i:int;
			var time:int;

			if (writeUnique)
			{
				time = getTimer();
				for (i = 0; i < iterationsTest; i++)
				{
					bodyList.add(new Body());
				}
				time = getTimer() - time;
			}
			else
			{
				time = getTimer();
				for (i = 0; i < iterationsTest; i++)
				{
					bodyList.add(bodyObj);
				}
				time = getTimer() - time;
			}

			if (isNeedResults) timeResult = time;

			return bodyList;
		}
	}
}
