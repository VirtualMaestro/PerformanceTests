package tests
{
	import bb.signals.BBSignal;
	import bb.signals.BBSignal;

	import flash.events.Event;

	import flash.events.EventDispatcher;

	import flash.utils.getTimer;

	import org.osflash.signals.Signal;

	/**
	 * Test different signal's implementations.
	 */
	public class Signals_Test extends Test
	{
		private var _time:int = 0;
		private var _count:int = 0;

		private var _signalFast:BBSignal;
		private var _bbSignal:BBSignal;
		private var _as3Signal:Signal;
		private var _dispatcher:EventDispatcher;
		private var _event:Event;

		/**
		 */
		public function Signals_Test()
		{
			iterationsTest = _count = 1000;

//			_signalFast = new BBSignalFast(null);
//			var once:Boolean = false;
//
//			for (var i:int = 0; i <_count; i++)
//			{
//				_signalFast.add(function(signal:BBSignalFast):void{}, once);
//			}

//			_as3Signal = new Signal();
//			for (var i:int = 0; i < _count; i++)
//			{
//				_as3Signal.add(function():void{});
//			}

//			_bbSignal = new BBSignal();
//			for (var i:int = 0; i < _count; i++)
//			{
//				_bbSignal.add(function():void{});
//			}

//			_event = new Event("someEvent");
//			_dispatcher = new EventDispatcher();
//			for (var i:int = 0; i < _count; i++)
//			{
//				_dispatcher.addEventListener("someEvent", function(event:Event):void{});
//			}
		}

		/**
		 */
		override public function run():void
		{
//			testNull();

			// Test for adding listeners
//			addingAS3Signals();         //  1420 iter: 10000
//			addingBBSignalFast();       //  30  iter: 10000 // with cache: 176  without: 178  // iter: 100000
//			addingBBSignal();           //  30 iter: 10000
//			nativeAddingEvent();        //  30 iter: 10000

			// Test for dispatching
//			dispatchBBSignalFast();     // 110 iter: 1 000 000
//			dispatchAS3Signals();       // Не смог добавить в сигнал 100 000 слушателей потому не смог провести этот тест
//			dispatchBBSignal();         // 94 iter: 1 000 000 //
//			nativeDispatchEvent();      // 260 iter: 1000 // очень медленно

			// Test for removing all listeners
			// Test for dispatching 'add once' listeners
		}

		/**
		 */
		private function testNull():void
		{
			var variable:Object = null;
			_time = getTimer();

			for (var i:int = 0; i < _count; i++)
			{
//				if (variable == null) {} // 124 ms
//				if (variable != null) {} // 124 ms
//				if (variable) {}         // 73 ms
			}

			timeResult = getTimer() - _time;
		}

		/**
		 */
		private function addingAS3Signals():void
		{
			testName = "addingAS3Signals";
			var signal:Signal = new Signal();
			_time = getTimer();

			for (var i:int = 0; i < _count; i++)
			{
				signal.add(function():void{});
			}

			timeResult = getTimer() - _time;
		}

		/**
		 */
		private function addingBBSignalFast():void
		{
			testName = "addingBBSignalFast";
			var signal:BBSignal = new BBSignal();
			_time = getTimer();
			for (var i:int = 0; i < _count; i++)
			{
				signal.add(function(signal:BBSignal):void{trace("Handler: " + i);});
			}

			timeResult = getTimer() - _time;
		}

		/**
		 */
		private function addingBBSignal(disableTimeResult:Boolean = false):void
		{
			testName = "addingBBSignal";
			_bbSignal = new BBSignal();
			_time = getTimer();
			for (var i:int = 0; i < _count; i++)
			{
				_bbSignal.add(function(signal:BBSignal):void{});
			}

			if (!disableTimeResult) timeResult = getTimer() - _time;
		}

		/**
		 */
		private function nativeAddingEvent():void
		{
			testName = "nativeAddingEvent";
			_dispatcher = new EventDispatcher();
			_time = getTimer();
			for (var i:int = 0; i < _count; i++)
			{
				_dispatcher.addEventListener("someEvent", function(event:Event):void{});
			}

			timeResult = getTimer() - _time;
		}

		/**
		 */
		private function nativeDispatchEvent():void
		{
			var event:Event = _event;
			testName = "nativeDispatchEvent";
			_time = getTimer();
			for (var i:int = 0; i < _count; i++)
			{
				_dispatcher.dispatchEvent(new Event("someEvent"));
			}

			timeResult = getTimer() - _time;
		}

		/**
		 */
		private function dispatchBBSignal():void
		{
			testName = "dispatchBBSignal";
			_time = getTimer();
			_bbSignal.dispatch();
			timeResult = getTimer() - _time;
		}

		/**
		 */
		private function dispatchAS3Signals():void
		{
			testName = "dispatchAS3Signals";
			_time = getTimer();
			_as3Signal.dispatch();
			timeResult = getTimer() - _time;
		}

		/**
		 */
		private function dispatchBBSignalFast():void
		{
			testName = "dispatchBBSignalFast";
			_time = getTimer();
			_signalFast.dispatch();
			timeResult = getTimer() - _time;
		}
	}
}
