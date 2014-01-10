package immaboid.behaviors 
{
	import flash.geom.Point;
	import immaboid.Boid;
	import net.flashpunk.FP;

	public class EvadeBehavior extends Behavior 
	{
		private var _target:Boid;
		/** The target boid. */
		public function get target():Boid { return _target; }
		public function set target(value:Boid):void { _target = value; }
		
		private var _accuracy:Number;
		/** [1 - inf] Affects how far ahead movement is predicted; larger = target movement is predicted further in the future. */
		public function get accuracy():Number { return _accuracy; }
		public function set accuracy(value:Number):void { _accuracy = (value < 1) ? 1 : value; }
		
		private var _desired:Point;
		private var _future:Point;
		
		/**
		 * This behavior is similar to flee, however, the boid will "predict" movements of target boid. Opposite of Pursuit.
		 * @param	target
		 * @param	accuracy
		 */
		public function EvadeBehavior(target:Boid, accuracy:Number = 1.0) 
		{
			super();
			
			_desired = new Point();
			_future = new Point();
			_accuracy = accuracy;
			_target = target;
		}
		
		override public function update(steering:Point):void 
		{
			super.update(steering);
			
			// get future position of target
			var t:Number = _accuracy * FP.distance(boid.x, boid.y, _target.x, _target.y) / _target.maxSpeed;
			_future.x = _target.x + _target.velocity.x * t;
			_future.y = _target.y + _target.velocity.y * t;
			
			// get desired velocity
			var a:Number = Math.atan2(_future.y - boid.y, _future.x - boid.x);
			_desired.x = boid.maxSpeed * Math.cos(a);
			_desired.y = boid.maxSpeed * Math.sin(a);
			
			// get steering vector
			steering.x -= _desired.x - boid.velocity.x;
			steering.y -= _desired.y - boid.velocity.y;
		}
		
	}

}