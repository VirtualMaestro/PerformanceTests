/**
 * User: VirtualMaestro
 * Date: 08.01.13
 * Time: 21:50
 */
package utils
{
	/**
	 * Represents rectangle class.
	 */
	public class BBRect
	{
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _rightBottomX:Number = 0;
		private var _rightBottomY:Number = 0;

		private var _width:Number = 0;
		private var _height:Number = 0;
		private var _halfWidth:Number = 0;
		private var _halfHeight:Number = 0;

		private var _centerX:Number = 0;
		private var _centerY:Number = 0;

		private var _greaterSide:Number = 0;

		/**
		 */
		public function BBRect(p_x:Number = 0, p_y:Number = 0, p_width:Number = 0, p_height:Number = 0)
		{
			_x = p_x;
			_y = p_y;
			_width = p_width;
			_height = p_height;
			_halfWidth = p_width*0.5;
			_halfHeight = p_height*0.5;
			_centerX = p_x + _halfWidth;
			_centerY = p_y + _halfHeight;
			_rightBottomX = p_x + p_width;
			_rightBottomY = p_y + p_height;
			_greaterSide = (p_width > p_height) ? p_width : p_height
		}

		/**
		 * Sets left-top X/Y and width/height.
		 */
		public function setTo(p_x:Number, p_y:Number, p_width:Number, p_height:Number):void
		{
			setXY(p_x, p_y);
			setSize(p_width, p_height);
		}

		/**
		 * Set left-top X and left-top Y.
		 */
		public function setXY(p_x:Number, p_y:Number):void
		{
			_x = p_x;
			_y = p_y;
			_centerX = p_x + _halfWidth;
			_centerY = p_y + _halfHeight;
			_rightBottomX = p_x + _width;
			_rightBottomY = p_y + _height;
		}

		/**
		 * Sets center position of rect.
		 */
		protected function setCenterXY(p_x:Number, p_y:Number):void
		{
			_centerX = p_x;
			_centerY = p_y;
			_x = p_x - _halfWidth;
			_y = p_y - _halfHeight;
			_rightBottomX = p_x + _halfWidth;
			_rightBottomY = p_y + _halfHeight;
		}

		/**
		 * Sets new size for rect.
		 */
		public function setSize(p_width:Number, p_height:Number):void
		{
			_width = p_width;
			_height = p_height;
			_halfWidth = p_width*0.5;
			_halfHeight = p_height*0.5;
			_centerX = _x + _halfWidth;
			_centerY = _y + _halfHeight;
			_rightBottomX = _x + p_width;
			_rightBottomY = _y + p_height;
			_greaterSide = (p_width > p_height) ? p_width : p_height
		}

		/**
		 * Method returns true if current rect is fully inside in given rect.
		 */
		[Inline]
		final public function isInside(rect:BBRect):Boolean
		{
			if (_x >= rect._x)
			{
				if (_y >= rect._y)
				{
					if (_rightBottomX <= rect._rightBottomX)
					{
						if (_rightBottomY <= rect._rightBottomY) return true;
					}
				}
			}

			return false;
		}

		/**
		 * Returns true if current rect is intersected with given rect.
		 */
		[Inline]
		final public function isIntersect(rect:BBRect):Boolean
		{
			var ltx:Number = rect._x;
			var lty:Number = rect._y;
			var rbx:Number = rect._rightBottomX;
			var rby:Number = rect._rightBottomY;

			var exp:Boolean = false;

			if (_x >= ltx)
			{
				if (_x <= rbx) exp = true;
			}

			if (!exp)
			{
				if (ltx >= _x)
				{
					if (!(ltx <= _rightBottomX)) return false;
				}
				else return false;
			}

			if (_y >= lty)
			{
				if (_y <= rby) return true;
			}

			if (lty >= _y)
			{
				if (lty <= _rightBottomY) return true;
			}

			return false;
		}

		/**
		 */
		public function get x():Number
		{
			return _x;
		}

		public function get y():Number
		{
			return _y;
		}

		public function get rightBottomX():Number
		{
			return _rightBottomX;
		}

		public function get rightBottomY():Number
		{
			return _rightBottomY;
		}

		public function get width():Number
		{
			return _width;
		}

		public function get height():Number
		{
			return _height;
		}

		public function get halfWidth():Number
		{
			return _halfWidth;
		}

		public function get halfHeight():Number
		{
			return _halfHeight;
		}

		public function get centerX():Number
		{
			return _centerX;
		}

		public function get centerY():Number
		{
			return _centerY;
		}

		public function get greaterSide():Number
		{
			return _greaterSide;
		}
	}
}
