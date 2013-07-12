/**
 * User: VirtualMaestro
 * Date: 10.07.13
 * Time: 20:08
 */
package tests
{
	import flash.utils.getTimer;

	import vm.math.rand.Perlin;

	/**
	 * Test of custom perlin noise.
	 */
	public class PerlinNoise_Test extends Test
	{
		public function PerlinNoise_Test(testName:String = "")
		{
			super(testName);

			iterationsTest = 100000;
		}

		/**
		 */
		override public function run():void
		{
			perlinTest();
		}

		/**
		 * OptimizedPerlin: 208 ms, ASC2: 122 ms (100000 iterations)
		 * My Perlin:        121 ms, ASC2: 95 ms (100000 iterations)
		 */
		private function perlinTest():void
		{
			var result1:Number;
			var result2:Number;
			var rand:Number = 1;

			Perlin.init();

			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
//				rand = Math.random() * 100;

//				result1 = OptimizedPerlin.noise(rand);
				result2 = Perlin.noise(rand);
			}

			timeResult = getTimer() - time;
		}
	}
}
