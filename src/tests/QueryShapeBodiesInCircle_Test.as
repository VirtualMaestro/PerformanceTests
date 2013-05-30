package tests
{
	import flash.display.Graphics;
	import flash.utils.getTimer;

	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.space.Space;

	import utils.InitNape;

	import vm.math.rand.RandUtil;

	/**
	 */
	public class QueryShapeBodiesInCircle_Test extends Test
	{
		public function QueryShapeBodiesInCircle_Test()
		{
			iterationsTest = 100;
			repeatTestCount = 10;
			delayBeforeRun = 2000;

			//
			createScene();

			// additional fields
			addOutputField("Count of objects", _space.bodies.length.toString());

//			drawCircle(_positionTNT, _meters);
		}

		private var _positionTNT:Vec2 = Vec2.get(400, 300);
		private var _meters:Number = 400;
		private var _objectsCount:int = 300;

		/**
		 */
		override public function run():void
		{
			var iterations:int = iterationsTest;

			var time:int = getTimer();
			for (var i:int = 0; i < iterations; i++)
			{
				_space.shapesInCircle(_positionTNT, _meters);  // 350
//				_space.bodiesInCircle(_positionTNT, _meters);  // 410  143
			}

			timeResult = getTimer() - time;
		}


		///
		static public const APP_WIDTH:int = 800;
		static public const APP_HEIGHT:int = 600;
		static public const CENTER_X:Number = APP_WIDTH / 2;
		static public const CENTER_Y:Number = APP_HEIGHT / 2;

		private var _space:Space;
		private var _core:InitNape;
		private var _rand:RandUtil = RandUtil.getInstance();

		/**
		 */
		private function createScene():void
		{
			_core = new InitNape(APP_WIDTH, APP_HEIGHT);
			addChild(_core);
			_space = _core.space();

			//
			var alotObjects:Boolean = true;
			var isComplexBody:Boolean = true;

			//
			if (isComplexBody)
			{
				var complexBody:Body = new Body(BodyType.DYNAMIC, Vec2.weak(400, 250));
				var circleShape:Circle = new Circle(30, Vec2.weak(50, 0));
				complexBody.shapes.add(circleShape);
				var box:Polygon = new Polygon(Polygon.regular(100, 100, 8, 0.0, true));
				box.translate(Vec2.weak(-10, 0));
				complexBody.shapes.add(box);
				complexBody.space = _space;
				complexBody.align();
			}

			if (alotObjects)
			{
				for (var i:int = 0; i < _objectsCount; i++)
				{
					var sizeW:int = _rand.getIntRange(5, 20);
					var sizeH:int = _rand.getIntRange(5, 20);
					var pos:Vec2 = Vec2.get(_rand.getIntRange(200, 500), _rand.getIntRange(300, 400));

					if (sizeW%2 == 0) createBox(sizeW, sizeH, pos, BodyType.DYNAMIC);
					else createCircle(sizeW, pos, BodyType.DYNAMIC);
				}

				createBox(500, 50, Vec2.weak(400, 250), BodyType.DYNAMIC, new Material(0.4, 1.0, 2.0, 1, 0.01));
			}

			// static blocks
			createBox(150, 50, Vec2.weak(400, 300), BodyType.STATIC);

			// walls
			createBox(1000, 200, Vec2.weak(CENTER_X, APP_HEIGHT), BodyType.STATIC);
			createBox(100, 1000, Vec2.weak(APP_WIDTH, CENTER_Y), BodyType.STATIC);
			createBox(100, 1000, Vec2.weak(0, CENTER_Y), BodyType.STATIC);
		}

		/**
		 */
		private function createBox(sizeW:int, sizeH:int, pos:Vec2, type:BodyType, material:Material = null):Body
		{
			var cube:Body = new Body(type, pos);
			cube.shapes.add(new Polygon(Polygon.box(sizeW, sizeH), (material == null) ? Material.wood() : material));
			cube.space = _space;
			return cube;
		}

		private function createCircle(size:int, pos:Vec2, type:BodyType, material:Material = null):Body
		{
			var circle:Body = new Body(type, pos);
			circle.shapes.add(new Circle(size, null, (material == null) ? Material.wood() : material));
			circle.position.set(pos);
			circle.space = _space;
			return circle;
		}

		/**
		 */
		private function drawCircle(pos:Vec2, radius:Number = 3, color:int = 0xff0000):void
		{
			var gr:Graphics = graphics;
			gr.lineStyle(2, color);
			gr.beginFill(color, 0.05);
			gr.drawCircle(pos.x, pos.y, radius);
			gr.endFill();
		}

	}
}
