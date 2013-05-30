package tests
{
	import assets.InheritSomeClass;
	import assets.SomeClass;
	import assets.SomeInterface;

	import flash.display.MovieClip;
	import flash.display.Sprite;

	import flash.utils.describeType;

	import flash.utils.getTimer;
	import avmplus.getQualifiedClassName;

	import flash.system.ApplicationDomain;


	public class Class_Test extends  Test
	{
		private var _time:int = 0;
		private var _count:int = 0;

		public function Class_Test()
		{
			iterationsTest = _count = 1000000;
		}

		/**
		 */
		override public function run():void
		{
//			getClassTest();
//			describeTypeTest();
			isImplementsInterfaceTest();
		}

		/**
		 */
		private function getClassTest():void
		{
			var classInstance:SomeClass = new SomeClass();
			var classVar:Class;
			testName = "getClassTest";
			_time = getTimer();

			for (var i:int = 0; i < _count; i++)
			{
//				classVar = forInstance(classInstance);
//				new classVar();
				trace("Class name: "+getQualifiedClassName(SomeClass));
			}

			timeResult = getTimer() - _time;
		}

		private function isImplementsInterfaceTest():void
		{
			var classInstance:InheritSomeClass = new InheritSomeClass();
//			var classInstance:Sprite = new Sprite();
			var isImplement:Boolean;

			testName = "isImplementsInterfaceTest";
			_time = getTimer();

			for (var i:int = 0; i < _count; i++)
			{
				isImplement = classInstance is SomeInterface;
//				trace("isImplementsInterfaceTest: " + isImplement);
			}

			timeResult = getTimer() - _time;
		}

		/**
		 */
		private function describeTypeTest():void
		{
			testName = "describeTypeTest";
			_time = getTimer();

			for (var i:int = 0; i < _count; i++)
			{
				describeType(MovieClip);  // очень медленная операция - 10000 итераций за 10 секунд :)
			}

			timeResult = getTimer() - _time;
		}


		/**
		 */
		static public function forInstance(instance:*, applicationDomain:ApplicationDomain = null):Class
		{
			applicationDomain = applicationDomain ? applicationDomain : ApplicationDomain.currentDomain;
			var className:String = getQualifiedClassName(instance);
			return forName(className, applicationDomain);
		}

		/**
		 */
		static public function forName(name:String, applicationDomain:ApplicationDomain = null):Class
		{
			applicationDomain = applicationDomain ? applicationDomain : ApplicationDomain.currentDomain;

			while (!applicationDomain.hasDefinition(name))
			{
				if (applicationDomain.parentDomain) applicationDomain = applicationDomain.parentDomain;
				else break;
			}

			var result:Class;

			try
			{
				result = applicationDomain.getDefinition(name) as Class;
			}
			catch (e:Error)
			{
				throw new Error("A class with the name '" + name + "' could not be found.");
			}

			return result;
		}

	}
}

