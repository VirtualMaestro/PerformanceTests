/**
 * User: VirtualMaestro
 * Date: 02.05.13
 * Time: 12:16
 */
package tests
{
	import flash.utils.getTimer;

	/**
	 */
	public class XMLTest extends Test
	{
		private var _testedXML:XML;
		private var _type:int = 0;

		/**
		 */
		public function XMLTest(testName:String = "XML Test")
		{
			super(testName);

			iterationsTest = 100000;

			_testedXML =
			<joint name="" type="pivot">
				<jointedActorName value="circle" type="string"/>
				<active value="true" type="boolean"/>
				<ignore value="true" type="boolean"/>
				<stiff value="true" type="boolean"/>
				<breakUnderError value="false" type="boolean"/>
				<breakUnderForce value="false" type="boolean"/>
				<removeOnBreak value="true" type="boolean"/>
				<damping value="1" type="number"/>
				<frequency value="1" type="number"/>
				<maxError value="Infinity" type="number"/>
				<maxForce value="Infinity" type="number"/>
				<thisAnchor value="45,-45" type="point"/>
				<jointedAnchor value="-100,0" type="point"/>
			</joint>;

			//
			switch (_type)
			{
				case 0:
				{
					_testedXML =
					<joint name="" type="pivot">
						<jointedActorName value="circle" type="string"/>
						<active value="true" type="boolean"/>
						<ignore value="true" type="boolean"/>
						<stiff value="true" type="boolean"/>
						<breakUnderError value="false" type="boolean"/>
						<breakUnderForce value="false" type="boolean"/>
						<removeOnBreak value="true" type="boolean"/>
						<damping value="1" type="number"/>
						<frequency value="1" type="number"/>
						<maxError value="Infinity" type="number"/>
						<maxForce value="Infinity" type="number"/>
						<thisAnchor value="45,-45" type="point"/>
						<jointedAnchor type="point">-100,0</jointedAnchor>
					</joint>;

					break;
				}

				case 1:
				{
					_testedXML =
					<joint name="" type="pivot">
						<jointedActorName value="circle" type="string"/>
						<active value="true" type="boolean"/>
						<ignore value="true" type="boolean"/>
						<stiff value="true" type="boolean"/>
						<breakUnderError value="false" type="boolean"/>
						<breakUnderForce value="false" type="boolean"/>
						<removeOnBreak value="true" type="boolean"/>
						<damping value="1" type="number"/>
						<frequency value="1" type="number"/>
						<maxError value="Infinity" type="number"/>
						<maxForce value="Infinity" type="number"/>
						<thisAnchor>
							<x value="45" type="number"/>
							<y value="-45" type="number"/>
						</thisAnchor>
						<jointedAnchor value="-100,0" type="point"/>
					</joint>;

					break;
				}

				case 2:
				{
					_testedXML =
					<joint name="" type="pivot">
						<jointedActorName value="circle" type="string"/>
						<active value="true" type="boolean"/>
						<ignore value="true" type="boolean"/>
						<stiff value="true" type="boolean"/>
						<breakUnderError value="false" type="boolean"/>
						<breakUnderForce value="false" type="boolean"/>
						<removeOnBreak value="true" type="boolean"/>
						<damping value="1" type="number"/>
						<frequency value="1" type="number"/>
						<maxError value="Infinity" type="number"/>
						<maxForce value="Infinity" type="number"/>
						<thisAnchorX type="number">45</thisAnchorX>
						<thisAnchorY type="number">-45</thisAnchorY>
						<jointedAnchor value="-100,0" type="point"/>
					</joint>;

					break;
				}

				case 3:
				{
					_testedXML =
					<joint name="" type="pivot">
						<jointedActorName value="circle" type="string"/>
						<active value="true" type="boolean"/>
						<ignore value="true" type="boolean"/>
						<stiff value="true" type="boolean"/>
						<breakUnderError value="false" type="boolean"/>
						<breakUnderForce value="false" type="boolean"/>
						<removeOnBreak value="true" type="boolean"/>
						<damping value="12" type="number"/>
						<frequency>9</frequency>
						<maxError value="Infinity" type="number"/>
						<maxForce value="Infinity" type="number"/>
						<thisAnchorX type="number">45</thisAnchorX>
						<thisAnchorY type="number">-45</thisAnchorY>
						<jointedAnchor value="-100,0" type="point"/>
					</joint>;

					break;
				}

				case 4:
				{
					_testedXML =
					<joint name="" type="pivot">
						<jointedActorName value="circle" type="string"/>
						<active value="true" type="boolean"/>
						<ignore value="true" type="boolean"/>
						<stiff value="true" type="boolean"/>
						<breakUnderError value="false" type="boolean"/>
						<breakUnderForce value="false" type="boolean"/>
						<removeOnBreak value="true" type="boolean"/>
						<damping value="12" type="number"/>
						<frequency>9</frequency>
						<maxError value="Infinity" type="number"/>
						<maxForce value="Infinity" type="number"/>
						<thisAnchorX type="number">45</thisAnchorX>
						<thisAnchorY type="number">-45</thisAnchorY>
						<jointedAnchor value="-100,0" type="point"/>
					</joint>;

					break;
				}

				case 5:
				{
					_testedXML =
					<joint name="" type="pivot">
						<jointedActorName value="circle" type="string"/>
						<active value="true" type="boolean"/>
						<ignore value="true" type="boolean"/>
						<stiff value="true" type="boolean"/>
						<breakUnderError value="false" type="boolean"/>
						<breakUnderForce value="false" type="boolean"/>
						<removeOnBreak value="true" type="boolean"/>
						<damping value="12" type="number"/>
						<frequency>9</frequency>
						<maxError value="Infinity" type="number"/>
						<maxForce value="Infinity" type="number"/>
						<thisAnchorX type="number">45</thisAnchorX>
						<thisAnchorY type="number">-45</thisAnchorY>
						<jointedAnchor value="-100,0" type="point"/>
					</joint>;

					break;
				}

			}
		}

		/**
		 * tests run with 100 000 iterations
		 */
		override public function run():void
		{
			switch (_type)
			{
				case 0:
				{
					testWithSplit();
					break;
				}

				case 1:
				{
					testWithDirectAccess();
					break;
				}

				case 2:
				{
					testWithDirectValues();
					break;
				}

				case 3:
				{
					testDirectAccessOneProp();
					break;
				}

				case 4:
				{
					testElementsOneProp();
					break;
				}

				case 5:
				{
					testChildOneProp();
					break;
				}

			}
		}

		/**
		 * id=0
		 * with attribute - 355 ms
		 * with direct value - 220 ms
		 */
		private function testWithSplit():void
		{
			testName = "testWithSplit";
			var num1:Number;
			var num2:Number;
			var arr:Array;

			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
//				arr = String(_testedXML.elements("thisAnchor").@value).split(",");
				arr = String(_testedXML.elements("jointedAnchor")).split(",");
				num1 = arr[0];
				num2 = arr[1];
			}

			timeResult = getTimer() - time;
		}

		/**
		 * id=1
		 * 760 ms
		 */
		private function testWithDirectAccess():void
		{
			testName = "testWithDirectAccess";
			var num1:Number;
			var num2:Number;
			var anchorXML:XMLList;

			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				anchorXML = _testedXML.thisAnchor;
				num1 = anchorXML.thisAnchor.x.@value;
				num2 = anchorXML.thisAnchor.y.@value;
			}

			timeResult = getTimer() - time;
		}

		/**
		 * id=2
		 * 394 ms
		 */
		private function testWithDirectValues():void
		{
			testName = "testWithDirectValues";
			var num1:Number;
			var num2:Number;

			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
				num1 = _testedXML.thisAnchorX;
				num2 = _testedXML.thisAnchorY;
			}

			timeResult = getTimer() - time;
		}

		/**
		 * id=3
		 * with attributes - 315 ms
		 * with direct value - 205 ms
		 */
		private function testDirectAccessOneProp():void
		{
			testName = "testDirectAccessOneProp";
			var num1:Number;
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
//				num1 = _testedXML.damping.@value;
				num1 = _testedXML.frequency;
			}

			timeResult = getTimer() - time;
		}

		/**
		 * id=4
		 * with attributes - 307 ms
		 * with direct value - 196 ms
		 */
		private function testElementsOneProp():void
		{
			testName = "testElementsOneProp";
			var num1:Number;
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
//				num1 = _testedXML.elements("damping").@value;
				num1 = _testedXML.elements("frequency");
			}

			timeResult = getTimer() - time;
		}

		/**
		 * id=5
		 * with attributes - 295 ms
		 * with direct value - 205 ms
		 */
		private function testChildOneProp():void
		{
			testName = "testChildOneProp";
			var num1:Number;
			var time:int = getTimer();

			for (var i:int = 0; i < iterationsTest; i++)
			{
//				num1 = _testedXML.child("damping").@value;
				num1 = _testedXML.child("frequency");
			}

			timeResult = getTimer() - time;
		}


	}
}
