package immaboid.behaviors 
{
	import flash.geom.Point;
	import immaboid.Boid;
	
	public class FleeBehavior extends Behavior
	{
		private var _target:Boid;
		/** The target boid. */
		public function get target():Boid { return _target; }
		public function set target(value:Boid):void { _target = value; }
		
		private var _desired:Point;
		
		/**
		 * This behavior makes a boid to flee its target. Opposite of Seek.
		 * @param	target
		 */
		public function FleeBehavior(target:Boid) 
		{
			super();
			
			_desired = new Point();
			_target = target;
		}
		
		override public function update(steering:Point):void 
		{
			super.update(steering);
			
			// get desired velocity
			var a:Number = Math.atan2(_target.y - boid.y, _target.x - boid.x);
			_desired.x = boid.maxSpeed * Math.cos(a);
			_desired.y = boid.maxSpeed * Math.sin(a);
			
			// get steering vector
			steering.x -= _desired.x - boid.velocity.x;
			steering.y -= _desired.y - boid.velocity.y;
		}
		
	}

}