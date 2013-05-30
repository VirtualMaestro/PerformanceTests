package assets
{
	public class SomeClass implements SomeInterface
	{
		static public var _count:int = 0;

		public function SomeClass()
		{
			trace("Class SomeClass. Num instance: " + ++_count);
		}
	}
}
