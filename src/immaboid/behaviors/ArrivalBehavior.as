package immaboid.behaviors 
{
	import flash.geom.Point;
	import immaboid.Boid;
	import net.flashpunk.FP;
	
	public class ArrivalBehavior extends Behavior 
	{
		private var _target:*;
		/** The target Boid or Point. */
		public function get target():* { return _target; }
		public function set target(value:*):void
		{
			if (value is Boid || value is Point)
			{
				_target = value;
			}
			else
			{
				throw new Error("Invalid target provided!");
			}
		}
		
		private var _slowingRadius:Number;
		/** [0 - inf] min distance before the boid starts to slow down. */
		public function get slowingRadius():Number { return _slowingRadius; }
		public function set slowingRadius(value:Number):void { _slowingRadius = (value < 0) ? 0 : value; } 
		
		private var _desired:Point;
		
		/**
		 * This behavior will cause a boid to slow down before arriving at the specified target.
		 * @param	slowingRadius
		 * @param	target
		 */
		public function ArrivalBehavior(target:*, slowingRadius:Number = 100) 
		{
			super();
			
			_desired = new Point();
			_slowingRadius = slowingRadius;
			
			this.target = target;
		}
		
		override public function update(steering:Point):void 
		{
			super.update(steering);
			
			var distance:Number = FP.distance(boid.x, boid.y, _target.x, _target.y);
			var slowFactor:Number = Math.min(distance / _slowingRadius, 1.0);
			
			// get desired velocity
			var a:Number = Math.atan2(_target.y - boid.y, _target.x - boid.x);
			_desired.x = slowFactor * boid.maxSpeed * Math.cos(a);
			_desired.y = slowFactor * boid.maxSpeed * Math.sin(a);
			
			// get steering vector
			steering.x += _desired.x - boid.velocity.x;
			steering.y += _desired.y - boid.velocity.y;
		}
		
	}

}