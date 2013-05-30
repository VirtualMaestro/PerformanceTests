package utils
{
	import nape.geom.Vec2;
	import nape.geom.Vec2Iterator;
	import nape.geom.Vec2List;
	import nape.geom.Vec3;

	import zpp_nape.util.ZNPNode_ZPP_Vec2;

	/**
	 * Trigonometry algorithms adapted for Nape's data structures.
	 */
	public class TrigonometryNape
	{
		/**
		 * Константа перевода радиан в градусы.
		 * Приблизительно 57.295779513082320876798154814105
		 */
		static public const RAD_TO_DEG:Number = 180.0 / Math.PI;

		/**
		 * Константа перевода градусов в радианы.
		 * Приблизительно 0,017453292519943295769236907684886
		 */
		static public const DEG_TO_RAD:Number = Math.PI / 180.0;

		/**
		 */
		static public const PI:Number = Math.PI;

		/**
		 * Константа PI * 2
		 */
		static public const PI2:Number = Math.PI * 2;

		/**
		 * Возвращает угол в радианах между двумя заданными линиями.
		 * Чтобы получить угол в градусах умножьте полученное значение на константу RAD_TO_DEG.
		 */
		static public function getAngleLines(startLine1:Vec2, endLine1:Vec2, startLine2:Vec2, endLine2:Vec2):Number
		{
			var x1:Number = endLine1.x - startLine1.x;
			var y1:Number = endLine1.y - startLine1.y;
			var x2:Number = endLine2.x - startLine2.x;
			var y2:Number = endLine2.y - startLine2.y;

			return Math.acos((x1*x2 + y1*y2)/ Math.sqrt((x1*x1 + y1*y1)*(x2*x2 + y2*y2)));
		}

		/**
		 * Возвращает косинус альфа между двумя заданными линиями.
		 * Метод такой же как getAngleLines за исключением того, что не вычисляется арккосинус, тем самым не возвращает угла в радианах.
		 * Метод может быть полезным когда нет необходимости знать углы, но надо узнать является ли один угл больше/меньше другого.
		 * Чем значение меньше тем угол больше.
		 * Так как в отличии от getAngleLines метод не рассчитывает арккосинус вследствии чего работает быстрее.
		 */
		static public function getCosALines(startLine1:Vec2, endLine1:Vec2, startLine2:Vec2, endLine2:Vec2):Number
		{
			var x1:Number = endLine1.x - startLine1.x;
			var y1:Number = endLine1.y - startLine1.y;
			var x2:Number = endLine2.x - startLine2.x;
			var y2:Number = endLine2.y - startLine2.y;

			return (x1*x2 + y1*y2)/ Math.sqrt((x1*x1 + y1*y1)*(x2*x2 + y2*y2));
		}

		/**
		 * Метод вычисляет угол между двумя заданными точками.
		 * Возвращает угол в радианах.
		 * Если требуются градусы, то результат надо умножить на константу RAD_TO_DEG.
		 */
		static public function getAnglePoints(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var x:Number = x2 - x1;
			var y:Number = y2 - y1;

			return Math.atan2(y, x);
		}

		/**
		 * Метод вычисляет расстояние между точками.
		 */
		static public function getDistance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var xd:Number = x1 - x2;
			var yd:Number = y1 - y2;

			return Math.sqrt(xd*xd + yd*yd);
		}

		/**
		 * Метод возвращает квадрат расстояния между точками.
		 */
		static public function getDistanceSquare(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var xd:Number = x1 - x2;
			var yd:Number = y1 - y2;

			return xd*xd + yd*yd;
		}

		/**
		 * Возвращает точку пересечения двух линий.
		 */
		static public function getIntersectLines(startLine1:Vec2, endLine1:Vec2, startLine2:Vec2, endLine2:Vec2):Vec2
		{
			var p1x:Number = startLine1.x;
			var p1y:Number = startLine1.y;
			var p2x:Number = endLine1.x;
			var p2y:Number = endLine1.y;
			var p3x:Number = startLine2.x;
			var p3y:Number = startLine2.y;
			var p4x:Number = endLine2.x;
			var p4y:Number = endLine2.y;

			var p1xSp2x:Number = p1x - p2x;
			var p1ySp2y:Number = p1y - p2y;
			var p1xSp3x:Number = p1x - p3x;
			var p1ySp3y:Number = p1y - p3y;
			var p4xSp3x:Number = p4x - p3x;
			var p4ySp3y:Number = p4y - p3y;

			var d:Number = p1xSp2x * p4ySp3y - p1ySp2y * p4xSp3x;
			var da:Number = p1xSp3x * p4ySp3y - p1ySp3y * p4xSp3x;
			var db:Number = p1xSp2x * p1ySp3y - p1ySp2y * p1xSp3x;

			if (da == 0 || db == 0 || d == 0) return null;  // линии накладываются или параллельны

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

		/**
		 * Проверяет пересекаются ли линии.
		 */
		static public function isIntersectLines(startLine1:Vec2, endLine1:Vec2, startLine2:Vec2, endLine2:Vec2):Boolean
		{
			var p1x:Number = startLine1.x;
			var p1y:Number = startLine1.y;
			var p2x:Number = endLine1.x;
			var p2y:Number = endLine1.y;
			var p3x:Number = startLine2.x;
			var p3y:Number = startLine2.y;
			var p4x:Number = endLine2.x;
			var p4y:Number = endLine2.y;

			var p1xSp2x:Number = p1x - p2x;
			var p1ySp2y:Number = p1y - p2y;
			var p1xSp3x:Number = p1x - p3x;
			var p1ySp3y:Number = p1y - p3y;
			var p4xSp3x:Number = p4x - p3x;
			var p4ySp3y:Number = p4y - p3y;

			var d:Number = p1xSp2x * p4ySp3y - p1ySp2y * p4xSp3x;
			var da:Number = p1xSp3x * p4ySp3y - p1ySp3y * p4xSp3x;
			var db:Number = p1xSp2x * p1ySp3y - p1ySp2y * p1xSp3x;

			if (da == 0 || db == 0) // Возможно отрезки накладываются
			{
				return (p1x >= p3x && p1x <= p4x || p3x >= p1x && p4x <= p2x);
			}

			if (d == 0) return false; // Отрезки паралельны

			var ta:Number = da / d;
			var tb:Number = db / d;

			if (ta >= 0)
			{
				if (ta <= 1)
				{
					if (tb >= 0)
					{
						 if (tb <= 1) return true;
					}
				}
			}

			return false;
		}

		/**
		 * Проверяет пересекаются ли прямоугольники.
		 * Задаются прямоугольники двумя вершинами - верхняя левая и нижняя правая.
		 */
		static public function isIntersectRectangles(topLeft1:Vec2, bottomRight1:Vec2, topLeft2:Vec2, bottomRight2:Vec2):Boolean
		{
			var ltx1:Number = topLeft1.x;
			var lty1:Number = topLeft1.y;
			var rbx1:Number = bottomRight1.x;
			var rby1:Number = bottomRight1.y;

			var ltx2:Number = topLeft2.x;
			var lty2:Number = topLeft2.y;
			var rbx2:Number = bottomRight2.x;
			var rby2:Number = bottomRight2.y;

			var exp:Boolean = false;

			if (ltx2 >= ltx1)
			{
				if (ltx2 <= rbx1) exp = true;
			}

			if (!exp)
			{
				if (ltx1 >= ltx2)
				{
					if (!(ltx1 <= rbx2)) return false;
				}
				else return false;
			}

			if (lty2 >= lty1)
			{
				if (lty2 <= rby1) return true;
			}

			if (lty1 >= lty2)
			{
				if (lty1 <= rby2) return true;
			}

			return false;
		}

		/**
		 * Проверяет пресекаются ли линия с кругом.
		 */
		static public function isIntersectLineCircle(startLine:Vec2, endLine:Vec2, circlePosition:Vec2, radius:Number):Boolean
		{
			var x1:Number = startLine.x - circlePosition.x;
			var y1:Number = startLine.y - circlePosition.y;
			var x2:Number = endLine.x - circlePosition.x;
			var y2:Number = endLine.y - circlePosition.y;

			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;

			var a:Number = dx*dx + dy*dy;
			var b:Number = 2.0*(x1*dx + y1*dy);
			var c:Number = x1*x1 + y1*y1 - radius*radius;

			if (-b < 0) return (c < 0);
			if(-b < (2.0*a)) return (((4.0*a*c) - b*b) < 0);

			return ((a+b+c) < 0);
		}

		/**
		 * Возвращает массив точек пересечения линии с кругом.
		 * Возможны два результата:
		 * - возвращается null, это значит, что пересечения нету;
		 * - возвращается массив из (одной или двух) точек. Первая точка - первое пересечение (ближайшее), вторая - второе.
		 *
		 * Если isRay = true, тогда отрезок будет восприниматься как луч,
		 * это значит даже если отрезок не дотягивает до круга, то он будет продолжен ввиде луча.
		 * И если луч пересекает круг будет возвращен результат из двух точек (даже если пересечение касательное, все-равно будут две точки, только одинаковые).
		 * Если isRay = false, тогда будет возвращен результат по факту пересечения отрезка с кругом.
		 * В этом случае может быть две точки, если отрезок полностью пересекает круг, одна точка если не полностью и null, если отрезок не дотягивает до круга.
		 * (при isRay = true, метод работает быстрее)
		 *
		 */
		static public function getIntersectLineCircle(startLine:Vec2, endLine:Vec2, circlePosition:Vec2, radius:Number, isRay:Boolean = false):Array
		{
			var slX:Number = startLine.x;
			var slY:Number = startLine.y;
			var elX:Number = endLine.x;
			var elY:Number = endLine.y;
			var cX:Number = circlePosition.x;
			var cY:Number = circlePosition.y;
			var x1:Number = slX - cX;
			var y1:Number = slY - cY;
			var x2:Number = elX - cX;
			var y2:Number = elY - cY;

			var result:Array = null;

			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;

			//
			var a:Number = dx*dx + dy*dy;
			var a2:Number = a * 2;
			var b:Number = (x1*dx + y1*dy) * 2;
			var c:Number = x1*x1 + y1*y1 - radius*radius;
			var discriminant:Number = b*b - 2*a2*c;

			if (discriminant >= 0)
			{
				if ((dx+dy) == 0) return [Vec2.get(cX, cY)];

				var firstPoint:Vec2;
				var secondPoint:Vec2;
				var min:Number;
				var max:Number;

				discriminant = Math.sqrt(discriminant);

				var t1:Number = (-b + discriminant)/a2;
				var t2:Number = (-b - discriminant)/a2;

				//
				if (isRay)
				{
					if (t1 < t2)
					{
						min = t1;
						max = t2;
					}
					else
					{
						min = t2;
						max = t1;
					}

					firstPoint = Vec2.get(((elX - slX)*min + slX), ((elY - slY)*min + slY));
					secondPoint = Vec2.get(((elX - slX)*max + slX), ((elY - slY)*max + slY));
					result = [firstPoint, secondPoint];
				}
				else
				{
					var isSolutionT1:Boolean = false;
					var isSolutionT2:Boolean = false;

					if (t1 >= 0)
					{
						if (t1 < 1.0000001 ) isSolutionT1 = true;
					}

					if (t2 >= 0)
					{
						if (t2 < 1.0000001) isSolutionT2 = true;
					}

	                //
					if (isSolutionT1 || isSolutionT2)
					{
						result = [];

						if (isSolutionT1 && isSolutionT2)
						{
							if (t1 < t2)
							{
								min = t1;
								max = t2;
							}
							else
							{
								min = t2;
								max = t1;
							}

							firstPoint = Vec2.get(((elX - slX)*min + slX), ((elY - slY)*min + slY));
							secondPoint = Vec2.get(((elX - slX)*max + slX), ((elY - slY)*max + slY));
							result[0] = firstPoint;
							result[1] = secondPoint;
						}
						else
						{
							min = isSolutionT1 ? t1 : t2;
							firstPoint = Vec2.get(((elX - slX)*min + slX), ((elY - slY)*min + slY));
							result[0] = firstPoint;
						}
					}
				}
			}

			return result;
		}

		/**
		 * Находит точку пересечения луча и круга.
		 * Метод работает также как и intersectLineCircle с настройками isRay = true.
		 * Разница в том, что он находит только первую точку пересечения и возвращает ее.
		 * Благодаря этому работает быстрее в 2,5 раза.
		 */
		static public function getIntersectRayCircle(startLine:Vec2, endLine:Vec2, circlePosition:Vec2, radius:Number):Vec2
		{
			var slX:Number = startLine.x;
			var slY:Number = startLine.y;
			var elX:Number = endLine.x;
			var elY:Number = endLine.y;
			var cX:Number = circlePosition.x;
			var cY:Number = circlePosition.y;
			var x1:Number = slX - cX;
			var y1:Number = slY - cY;
			var x2:Number = elX - cX;
			var y2:Number = elY - cY;

			var result:Vec2 = null;

			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;

			//
			var a:Number = dx*dx + dy*dy;
			var a2:Number = a * 2;
			var b:Number = (x1*dx + y1*dy) * 2;
			var c:Number = x1*x1 + y1*y1 - radius*radius;
			var discriminant:Number = b*b - 2*a2*c;

			if (discriminant >= 0)
			{
				if ((dx+dy) == 0) return Vec2.get(cX, cY);

				discriminant = Math.sqrt(discriminant);

				var t1:Number = (-b + discriminant)/a2;
				var t2:Number = (-b - discriminant)/a2;
				var min:Number = (t1<t2) ? t1 : t2;

				result = Vec2.get(((elX - slX)*min + slX), ((elY - slY)*min + slY));
			}

			return result;
		}

		/**
		 * Возвращает вектор направления отрезка.
		 */
		static public function getDirection(startLine:Vec2, endLine:Vec2):Vec2
		{
			var x:Number = endLine.x - startLine.x;
			var y:Number = endLine.y - startLine.y;
			var len:Number = Math.sqrt(x*x + y*y);

			return Vec2.get(x/len, y/len);
		}

		/**
		 * Определяет ближайшую точку из списка точек к заданной.
		 */
		static public function getNearestPointToPoint(listPoints:Vec2List, measuringPoint:Vec2):Vec2
		{
			var nearestPoint:Vec2;
			var point:Vec2;
			var minLen:Number = Number.POSITIVE_INFINITY;
			var lsq:Number;
			var tx:Number;
			var ty:Number;
			var node:ZNPNode_ZPP_Vec2 = listPoints.zpp_inner.inner.head;

			while(node)
			{
				point = node.elt.outer;
				tx = point.x - measuringPoint.x;
				ty = point.y - measuringPoint.y;
				lsq = tx*tx + ty*ty;

 				if (minLen > lsq)
 				{
 					minLen = lsq;
 					nearestPoint = point;
 				}

				node = node.next;
			}

			return nearestPoint;
		}


		/**
		 * Возвращает ближайшее расстояние между заданной линией и точкой.
		 * limitLineSegment - если значение true, тогда поиск ближайшего расстояния будет ограничен сигментом линии, если false то проекцией на продолжение линии.
		 * squareLength - если true, тогда вернется квадрат расстояния (не вычисляется корень квадратный).
		 */
		static public function getDistanceFromPointToLine(startLine:Vec2, endLine:Vec2, measuringPoint:Vec2, limitLineSegment:Boolean = true, squareLength:Boolean = false):Number
		{
			var x1:Number = startLine.x;
			var y1:Number = startLine.y;
			var x2:Number = endLine.x;
			var y2:Number = endLine.y;
			var x3:Number = measuringPoint.x;
			var y3:Number = measuringPoint.y;

			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;

			var x0:Number;
			var y0:Number;

			if ((dx == 0) && (dy == 0))
			{
				x0 = x1;
				y0 = y1;
			}
			else
			{
				var t:Number = ((x3 - x1) * dx + (y3 - y1) * dy) / (dx * dx + dy * dy);
				if (limitLineSegment) t = min(max(0, t), 1);    //Math.min(Math.max(0, t), 1);
				x0 = x1 + t * dx;
				y0 = y1 + t * dy;
			}

			return squareLength ? getDistanceSquare(x3, y3, x0, y0) : getDistance(x3, y3, x0, y0);
		}

		/**
		 * Возвращает ближайшую точку на линии к заданной точке.
		 * limitLineSegment - если значение true, тогда поиск ближайшего расстояния будет ограничен сигментом линии,
		 *                    если false, то проекцией на продолжение линии.
		 */
		static public function getNearestPointOnLine(startLine:Vec2, endLine:Vec2, measuringPoint:Vec2, limitLineSegment:Boolean = true):Vec2
		{
			var x1:Number = startLine.x;
			var y1:Number = startLine.y;
			var x2:Number = endLine.x;
			var y2:Number = endLine.y;
			var x3:Number = measuringPoint.x;
			var y3:Number = measuringPoint.y;

			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;

			var x0:Number;
			var y0:Number;

			if ((dx == 0) && (dy == 0))
			{
				x0 = x1;
				y0 = y1;
			}
			else
			{
				var t:Number = ((x3 - x1) * dx + (y3 - y1) * dy) / (dx * dx + dy * dy);
				if (limitLineSegment) t = min(max(0, t), 1);
				x0 = x1 + t * dx;
				y0 = y1 + t * dy;
			}

			return Vec2.get(x0, y0);
		}

		/**
		 * Метод возвращает ближайшую точку на полигоне к заданной точки.
		 * Также, третим параметром (z) возвращает квадрат расстояния между заданной точкой и найденой.
		 */
		static public function getNearestPointOnPolygon(vertexList:Vec2List, measuringPoint:Vec2):Vec3
		{
			var nearestOnPolygon:Vec2;
			var nearestOnPolygonLength:Number = Number.POSITIVE_INFINITY;
			var nearestOnLine:Vec2;
			var nearestOnLineLength:Number;

			var curPoint:Vec2;
			var prevPoint:Vec2;
			var firstPoint:Vec2;

			var mx:Number = measuringPoint.x;
			var my:Number = measuringPoint.y;
			var tx:Number;
			var ty:Number;

			var node:ZNPNode_ZPP_Vec2 = vertexList.zpp_inner.inner.head;
			firstPoint = node.elt.outer;
			prevPoint = firstPoint;
			node = node.next;

			while(node)
			{
				curPoint = node.elt.outer;
				nearestOnLine = getNearestPointOnLine(prevPoint, curPoint, measuringPoint);
				tx = nearestOnLine.x - mx;
				ty = nearestOnLine.y - my;
				nearestOnLineLength = tx*tx + ty*ty;

				if (nearestOnLineLength < nearestOnPolygonLength)
				{
					nearestOnPolygon = nearestOnLine;
					nearestOnPolygonLength = nearestOnLineLength;
				}

				node = node.next;
			}

			nearestOnLine = getNearestPointOnLine(curPoint, firstPoint, measuringPoint);
			tx = nearestOnLine.x - mx;
			ty = nearestOnLine.y - my;
			nearestOnLineLength = tx*tx + ty*ty;

			if (nearestOnLineLength < nearestOnPolygonLength)
			{
				nearestOnPolygon = nearestOnLine;
				nearestOnPolygonLength = nearestOnLineLength;
			}

			return Vec3.get(nearestOnPolygon.x, nearestOnPolygon.y, nearestOnPolygonLength);
		}

		/**
		 * Метод возвращает ближайшую точку на круге к заданной точке.
		 */
		static public function getNearestPointOnCircle(circlePosition:Vec2, radius:Number, measuringPoint:Vec2):Vec3
		{
			var mx:Number = measuringPoint.x;
			var my:Number = measuringPoint.y;
			var dx:Number = circlePosition.x - mx;
			var dy:Number = circlePosition.y - my;

			if (dx == 0 || dy == 0) dx = dy =  radius;

			var distanceToCircle:Number = Math.sqrt(dx*dx + dy*dy);

			var dirX:Number = dx/distanceToCircle;
			var dirY:Number = dy/distanceToCircle;

			distanceToCircle -= radius;

			var npX:Number = mx + dirX*distanceToCircle;
			var npY:Number = my + dirY*distanceToCircle;

			return Vec3.get(npX, npY, distanceToCircle);
		}

		/**
		 * Проверяет пересекаются ли полигоны.
		 * (вершины полигонов должны быть упорядочены по часовой стрелке)
		 */
		static public function isIntersectPolygons(polygon1:Vec2List, polygon2:Vec2List):Boolean
		{
			var iterator1:Vec2Iterator = polygon1.iterator();
			var iterator2:Vec2Iterator = polygon2.iterator();

			var startPoint1:Vec2 = iterator1.next();
			var firstPoint1:Vec2 = startPoint1;
			var endPoint1:Vec2;

			var startPoint2:Vec2 = iterator2.next();
			var firstPoint2:Vec2 = startPoint2;
			var endPoint2:Vec2;

			while(iterator1.hasNext())
			{
				endPoint1 = iterator1.next();

				startPoint2 = iterator2.next();
				while(iterator2.hasNext())
				{
					endPoint2 = iterator2.next();

					if (isIntersectLines(startPoint1, endPoint1, startPoint2, endPoint2))
					{
						return true;
					}

					startPoint2 = endPoint2;
				}

				if (isIntersectLines(startPoint1, endPoint1, startPoint2, firstPoint2))
				{
					return true;
				}

				iterator2 = polygon2.iterator();

				startPoint1 = endPoint1;
			}

			startPoint2 = iterator2.next();
			while(iterator2.hasNext())
			{
				endPoint2 = iterator2.next();

				if (isIntersectLines(startPoint1, firstPoint1, startPoint2, endPoint2))
				{
					return true;
				}

				startPoint2 = endPoint2;
			}

			return isIntersectLines(startPoint1, firstPoint1, startPoint2, firstPoint2);
		}

		/**
		 * Returns two points which make the biggest angle between given measuring point.
		 * Return array with two objects of Vec2 type.
		 */
		static public function getPointsMakeBiggestAngel(verticies:Array, measuring:Vec2):Array
		{
			var biggestAngel:Number = Number.POSITIVE_INFINITY;
			var tAngel:Number = 0;
			var bigVertex1:Vec2;
			var bigVertex2:Vec2;

			var len:int = verticies.length;
			for (var i:int = 0; i < len-1; i++)
			{
				for (var j:int = i+1; j < len; j++)
				{
					tAngel = getCosALines(measuring, verticies[i], measuring, verticies[j]);

					if (tAngel < biggestAngel)
					{
						biggestAngel = tAngel;
						bigVertex1 = verticies[i];
						bigVertex2 = verticies[j];
					}
				}
			}

			return [bigVertex1, bigVertex2];
		}

		/**
		 * Return perpendicular vector to given.
		 * If normalize = true, vector is normalized.
		 */
		static public function getPerpendicular(vecStart:Vec2, vecEnd:Vec2, normalize:Boolean = false):Vec2
		{
			var perpX:Number = -(vecEnd.y - vecStart.y);
			var perpY:Number = vecEnd.x - vecStart.x;

			if (normalize && (perpX + perpY) != 0)
			{
				var len:Number = Math.sqrt(perpX*perpX + perpY*perpY);
				perpX /= len;
				perpY /= len;
			}

			return Vec2.get(perpX, perpY);
		}

		//////
		/**
		 * Возвращает минимальное число из двух заданных.
		 */
		static public function min(val1: Number, val2: Number): Number
		{
			return (val1 < val2) ? val1 : val2;
		}

		/**
		 * Возвращает большее число из двух заданных.
		 */
		static public function max(val1: Number, val2: Number): Number
		{
			return (val1 > val2) ? val1 : val2;
		}

	}
}
