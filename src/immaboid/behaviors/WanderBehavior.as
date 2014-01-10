package immaboid.behaviors 
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author 
	 */
	public class WanderBehavior extends Behavior 
	{
		private var _circleRadius:Number;
		/** [1 - inf] Affects how fast the boid turns. */
		public function get circleRadius():Number { return _circleRadius; }
		public function set circleRadius(value:Number):void { _circleRadius = (value < 1) ? 1 : value; }
		
		private var _circleDistance:Number;
		/** [0 - inf] Affects how smooth the boid turns. */
		public function get circleDistance():Number { return _circleDistance; }
		public function set circleDistance(value:Number):void { _circleDistance = (value < 0) ? 0 : value; }
		
		private var _angleChange:Number;
		/** [0 - 2PI] The max angle (in radians) that the boid's wander angle changes. */
		public function get angleChange():Number { return _angleChange; }
		public function set angleChange(value:Number):void { _angleChange = value; }
		
		private var _circleCenter:Point;
		private var _displacement:Point;
		private var _wanderAngle:Number;
		private var _desired:Point;
		
		public function WanderBehavior(circleRadius:Number = 1, circleDistance:Number = 1, angleChange:Number = 1) 
		{
			super();
			
			_circleRadius = circleRadius;
			_circleDistance = circleDistance;
			_angleChange = angleChange;
			
			_desired = new Point();
			_displacement = new Point();
			_circleCenter = new Point();
			_wanderAngle = Math.random() * 6.24;
		}
		
		override public function update(steering:Point):void 
		{
			super.update(steering);
			
			// calc circle position
			_circleCenter = boid.velocity.clone();
			_circleCenter.normalize(1);
			_circleCenter.x *= _circleDistance;
			_circleCenter.y *= _circleDistance;
			
			// calc displacement
			_displacement.x = _circleRadius;
			_displacement.y = 0;
			
			// randomly change wander angle
			_wanderAngle += Math.random() * _angleChange - _angleChange * 0.5;
			
			// apply to displacement
			var len:Number = _displacement.length;
			_displacement.x = Math.cos(_wanderAngle) * len;
			_displacement.y = Math.sin(_wanderAngle) * len;
			
			// get desired velocity
			_desired.x = (_circleCenter.x + _displacement.x) * boid.maxSpeed;
			_desired.y = (_circleCenter.y + _displacement.y) * boid.maxSpeed;
			
			// get steering vector
			steering.x += _desired.x - boid.velocity.x;
			steering.y += _desired.y - boid.velocity.y;
		}
		
	}

}