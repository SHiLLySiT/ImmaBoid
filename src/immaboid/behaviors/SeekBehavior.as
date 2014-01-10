package immaboid.behaviors 
{
	import flash.geom.Point;
	import immaboid.behaviors.Behavior;
	import immaboid.Boid;
	import net.flashpunk.FP;
	
	public class SeekBehavior extends Behavior 
	{
		private var _target:Boid;
		/** The target boid. */
		public function get target():Boid { return _target; }
		public function set target(value:Boid):void { _target = value; }
		
		private var _desired:Point;
		
		/**
		 * This behavior makes a boid to seek its target. Opposite of Flee.
		 * @param	target
		 */
		public function SeekBehavior(target:Boid) 
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
			steering.x += _desired.x - boid.velocity.x;
			steering.y += _desired.y - boid.velocity.y;
		}
		
	}

}