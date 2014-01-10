package immaboid.behaviors 
{
	import flash.geom.Point;
	import net.flashpunk.FP;

	public class FollowPathBehavior extends Behavior 
	{
		private var _path:Vector.<Point>;
		/** Path for boid to follow. */
		public function get path():Vector.<Point> { return _path; }
		public function set path(value:Vector.<Point>):void { _path = value; }
		
		private var _radius:Number;
		/** [0 - inf] Min distance from current point before targeting a new point. Affects path smoothing. */
		public function get radius():Number { return _radius; }
		public function set radius(value:Number):void { _radius = (value < 0) ? 0 : value; }
		
		private var _reverse:Boolean;
		/** If true, boid follows path in reverse. */
		public function get reverse():Boolean { return _reverse; }
		public function set reverse(value:Boolean):void { _reverse = value; }
		
		private var _desired:Point;
		private var _currentIndex:int;
		
		/**
		 * This behavior makes a boid follow a path defined by a list of points.
		 * @param	path
		 * @param	radius
		 */
		public function FollowPathBehavior(path:Vector.<Point>, radius:Number = 10) 
		{
			super();
			
			_desired = new Point();
			_radius = radius;
			_path = path;
			_reverse = false;
			_currentIndex = 0;
		}
		
		override public function update(steering:Point):void 
		{
			super.update(steering);
			
			if (_path == null || _path.length < 1) return;
			
			// if distance to current point is less than radius, get a new point
			if (FP.distance(boid.x, boid.y, _path[_currentIndex].x, _path[_currentIndex].y) < _radius)
			{
				if (_reverse)
				{
					if (_currentIndex - 1 > -1) { _currentIndex--; }
					else { _currentIndex = _path.length-1; }
				}
				else
				{
					if (_currentIndex + 1 < _path.length) { _currentIndex++; }
					else { _currentIndex = 0; }
				}
			}
			
			// get desired velocity
			var a:Number = Math.atan2(_path[_currentIndex].y - boid.y, _path[_currentIndex].x - boid.x);
			_desired.x = boid.maxSpeed * Math.cos(a);
			_desired.y = boid.maxSpeed * Math.sin(a);
			
			// get steering vector
			steering.x += _desired.x - boid.velocity.x;
			steering.y += _desired.y - boid.velocity.y;
		}
		
	}

}