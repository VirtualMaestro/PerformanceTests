package tests
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.sampler.getSize;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;

	import nape.geom.Vec2;
	import nape.geom.Vec2List;
	import nape.geom.Vec3;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.shape.Shape;

	import utils.TrigonometryNape;

	import vm.classes.ClassUtil;

	import vm.math.rand.RandUtil;

	public class Intersect_Test extends Test
	{
		private var _rand:RandUtil = RandUtil.getInstance();

		public function Intersect_Test()
		{
			super("");
			iterationsTest = 1000000;
		}

		private var p1:Vec2 = Vec2.get(100, 50);
		private var p2:Vec2 = Vec2.get(255/* + _rand.getIntRange(-100, 100)*/, 250 /*+ _rand.getIntRange(-100, 100)*/);
		private var p3:Vec2 = Vec2.get(100, 200);
		private var p4:Vec2 = Vec2.get(400, 50);
		private var circlePos:Vec2 = Vec2.get(150, 200);
		private var radius:Number = 50;

		override public function run():void
		{
//			graphics.clear();
//
//			// ray circle
//			stage.addEventListener(MouseEvent.CLICK, mouseHandler);
////			p2.setxy(circlePos.x, circlePos.y);
//
//			var interPoint:Vec2 = TrigonometryNape.intersectRayCircle(p1, p2, circlePos, radius);
//			if (interPoint) drawCircle(interPoint, 5, 0x00ff00);
//
//
//			// line circle
////			var intersectPoints:Array = TrigonometryNape.intersectLineCircle(p1, p2, circlePos, radius);
////
////			if (intersectPoints != null)
////			{
////				drawCircle(intersectPoints[0], 5, 0x00ff00);
////				if (intersectPoints.length == 2) drawCircle(intersectPoints[1], 5, 0x00ff00);
////			}
//
////			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
//
//			drawLine(p1, p2);
//			drawCircle(circlePos, radius, 0x0000ff);
//
//			return;



			var result:Vec2 = new Vec2(2345, 2345);
			result.dispose();
			var result3:Vec3 = new Vec3();
			var array:Array = [];
			var vertex:Vertex = new Vertex();
			var point:Point = new Point();
			var body:Body = new Body();
			var vertices:Array = [Vec2.get(), Vec2.get(1,1), Vec2.get(2)];
			var polygon:Polygon = new Polygon(Polygon.box(50, 50));
			polygon.localVerts.clear();
			polygon.worldVerts.clear();
			var circle:Circle = new Circle(10);
			var ii:Boolean = true;

//			trace("Size Vec2: " + getSize(result));
//			trace("Size Vec3: " + getSize(result3));
//			trace("Size Array: " + getSize(array));
//			trace("Size Vertex: " + getSize(vertex));
//			trace("Size Point: " + getSize(point));
//			trace("Size Body: " + getSize(body));
//			trace("Size Polygon: " + getSize(polygon));
//			trace("Size Circle: " + getSize(circle));
//			trace("Size vertices: " + getSize(vertices));
//
//			return;



			memoryStamp();
			var time:int = getTimer();
			for (var i:int = 0; i < iterationsTest; i++)
			{
//				getPointOfLinesIntersection_1(p1, p2, p3, p4);
//				getPointOfLinesIntersection_2(p1, p2, p3, p4);
//				TrigonometryNape.intersectLineWithCircle_slow(p1, p2, circlePos, radius);    // 907
//				TrigonometryNape.intersectLineCircle(p1, p2, circlePos, radius, true);         // 781
//				result = TrigonometryNape.intersectRayCircle(p1, p1, circlePos, radius);  // 654
//				result.dispose(); // 420

//				result = new Vec2();    // 474
//				result3 = new Vec3();    // 463

//				result = Vec2.get();  // 266
//				result.dispose();

//				array = [];         // 246

//				point = new Point();   // 184

//				vertex = new Vertex(); // 150

//				body = new Body();    // 8500

//				polygon = new Polygon(vertices); // 20000

//				circle = new Circle(10);        // 5000

//				body = new Body(BodyType.DYNAMIC, new Vec2(100, 100));   // 38324
//				body.shapes.add(new Polygon(Polygon.box(50, 50)));

//				body.type = BodyType.DYNAMIC;                //  17000
//				body.position.setxy(100, 100);
//				polygon.localVerts.merge(Vec2List.fromArray(Polygon.box(50, 50)));
//				body.shapes.add(polygon);
//
//				body.shapes.clear();
//				polygon.localVerts.clear();
//				polygon.worldVerts.clear();


//				body = new Body(BodyType.DYNAMIC, new Vec2(100, 100));
//				body.shapes.add(new Circle(50));

			}

			timeResult = getTimer() - time;
		}

		private function mouseHandler(event:MouseEvent):void
		{
			graphics.clear();

			p1.setxy(event.stageX, event.stageY);
			var interPoint:Vec2 = TrigonometryNape.getIntersectRayCircle(p1, p2, circlePos, radius);
			if (interPoint) drawCircle(interPoint, 5, 0x00ff00);

			drawLine(p1, p2);
			drawCircle(circlePos, radius, 0x0000ff);
		}

		private function keyboardHandler(event:KeyboardEvent):void
		{
			var shiftX:Number = 0;
			var shiftY:Number = 0;
			var shift:Number = 1;

			switch (event.keyCode)
			{
				case Keyboard.LEFT:
				{
					shiftX-=shift;
					break;
				}
				case Keyboard.RIGHT:
				{
					shiftX+=shift;
					break;
				}
				case Keyboard.UP:
				{
					shiftY-=shift;
					break;
				}
				case Keyboard.DOWN:
				{
					shiftY+=shift;
					break;
				}
			}

			p2.x += shiftX;
			p2.y += shiftY;

			var intersectPoints:Array = TrigonometryNape.getIntersectLineCircle(p1, p2, circlePos, radius, false);

			graphics.clear();
			drawLine(p1, p2);
			drawCircle(circlePos, radius, 0x0000ff);

			// ray circle
//			var interPoint:Vec2 = TrigonometryNape.intersectRayCircle(p1, p2, circlePos, radius);
//			if (interPoint) drawCircle(interPoint, 5, 0x00ff00);


			// line circle
			if (intersectPoints != null)
			{
				trace("intersectPoints.length: " + intersectPoints.length);
				drawCircle(intersectPoints[0], 5, 0x00ff00);
				if (intersectPoints.length == 2) drawCircle(intersectPoints[1], 5, 0x00ff00);
			}
		}

		private function getPointOfLinesIntersection_1(p1:Vec2, p2:Vec2, p3:Vec2, p4:Vec2):Vec2
		{
			var d:Number = (p1.x - p2.x) * (p4.y - p3.y) - (p1.y - p2.y) * (p4.x - p3.x);
			var da:Number = (p1.x - p3.x) * (p4.y - p3.y) - (p1.y - p3.y) * (p4.x - p3.x);
			var db:Number = (p1.x - p2.x) * (p1.y - p3.y) - (p1.y - p2.y) * (p1.x - p3.x);

			var ta:Number = da / d;
			var tb:Number = db / d;

			if (ta >= 0 && ta <= 1 && tb >= 0 && tb <= 1)
			{
				var dx:Number = p1.x + ta * (p2.x - p1.x);
				var dy:Number = p1.y + ta * (p2.y - p1.y);

				return Vec2.get(dx, dy);
			}

			return null;
		}

		/**
		 */
		private function getPointOfLinesIntersection_2(p1:Vec2, p2:Vec2, p3:Vec2, p4:Vec2):Vec2
		{
			var p1x:Number = p1.x;
			var p1y:Number = p1.y;

			var p2x:Number = p2.x;
			var p2y:Number = p2.y;

			var p3x:Number = p3.x;
			var p3y:Number = p3.y;

			var p4x:Number = p4.x;
			var p4y:Number = p4.y;

			var p1xSp2x:Number = p1x - p2x;
			var p4xSp3x:Number = p4x - p3x;
			var p4ySp3y:Number = p4y - p3y;
			var p1ySp2y:Number = p1y - p2y;
			var p1xSp3x:Number = p1x - p3x;
			var p1ySp3y:Number = p1y - p3y;

			var d:Number  = p1xSp2x*p4ySp3y - p1ySp2y*p4xSp3x;
			var da:Number = p1xSp3x*p4ySp3y - p1ySp3y*p4xSp3x;
			var db:Number = p1xSp2x*p1ySp3y - p1ySp2y*p1xSp3x;

			var ta:Number = da / d;
			var tb:Number = db / d;

			if (ta >= 0)
			{
				if (ta <= 1)
				{
					if (tb >= 0)
					{
						if (tb <= 1)
						{
							var dx:Number = p1x + ta * (p2x - p1x);
							var dy:Number = p1y + ta * (p2y - p1y);

							return Vec2.get(dx, dy);
						}
					}
				}
			}

			return null;
		}

		private function drawLine(start:Vec2, end:Vec2, color:int = 0xff0000):void
		{
			graphics.lineStyle(1, color);
			graphics.moveTo(start.x, start.y);
			graphics.lineTo(end.x, end.y);
		}

		private function drawCircle(pos:Vec2, radius:Number = 3, color:int = 0xff0000):void
		{
			graphics.lineStyle(1, color);
			graphics.beginFill(color, 0.05);
			graphics.drawCircle(pos.x, pos.y, radius);
			graphics.endFill();
		}
	}
}

internal class Vertex
{
	public var x:Number = 0;
	public var y:Number = 0;

	public function Vertex(xp:Number = 0, yp:Number = 0)
	{
		x = xp;
		y = yp;
	}
}