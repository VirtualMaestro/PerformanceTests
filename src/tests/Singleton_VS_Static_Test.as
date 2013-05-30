package tests
{
	import flash.geom.Point;
	import flash.utils.getTimer;

	import vm.math.trigonometry.TrigUtil;

	public class Singleton_VS_Static_Test extends Test
	{
		public function Singleton_VS_Static_Test()
		{
			super("", 10000000);

		}


		override public function run():void
		{
			staticTest(); // 274
//			singletonTest(); // 257
		}

		private function staticTest():void
		{
			var p1:Point = new Point(10, 20);
			var p2:Point = new Point(50, 50);
			var p3:Point = new Point(20, 10);
			var p4:Point = new Point(100, 20);

			var time:int;

			time = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				TrigUtil.getInstance().isLinesIntersects(p1, p2, p3, p4);
			}

			time = getTimer() - time;

			timeResult = time;
		}

		private function singletonTest():void
		{
			var trigUtil:TrigUtil = TrigUtil.getInstance();

			var p1:Point = new Point(10, 20);
			var p2:Point = new Point(50, 50);
			var p3:Point = new Point(20, 10);
			var p4:Point = new Point(100, 20);

			var time:int;

			time = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				trigUtil.isLinesIntersects(p1, p2, p3, p4);
			}

			time = getTimer() - time;

			timeResult = time;
		}
	}
}
