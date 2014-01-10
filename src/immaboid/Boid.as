package immaboid 
{
	import immaboid.behaviors.Behavior;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import immaboid.behaviors.SeekBehavior;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	public class Boid extends Entity 
	{
		private var _mass:Number;
		/** [1 - inf] Mass of the boid. */
		public function get mass():Number { return _mass; }
		public function set mass(value:Number):void { _mass = value; }
		
		private var _maxSpeed:Number;
		/** [0 - inf] Max speed of the boid. */
		public function get maxSpeed():Number { return _maxSpeed; }
		public function set maxSpeed(value:Number):void { _maxSpeed = value; }
		
		private var _velocity:Point;
		/** Vector that represents boid's velocity. */
		public function get velocity():Point { return _velocity; }
		public function set velocity(value:Point):void { _velocity = value; }
		
		private var _behaviors:Dictionary;
		private var _steering:Point;
		
		/**
		 * Boid class.
		 * @param	x
		 * @param	y
		 * @param	graphic
		 * @param	mask
		 */
		public function Boid(x:Number = 0, y:Number = 0, graphic:Graphic = null, mask:Mask = null)
		{
			super(x, y, graphic, mask);
			
			_maxSpeed = 0;
			_mass = 1;
			_behaviors = new Dictionary();
			_velocity = new Point(0,0);
			_steering = new Point();
		}
		
		override public function update():void 
		{
			super.update();
			
			// update behaviors
			_steering.x = 0;
			_steering.y = 0;
			for each(var behavior:Behavior in _behaviors)
			{
				behavior.update(_steering);
			}
			_steering.x /= mass;
			_steering.y /= mass;
			
			// apply final steering
			_velocity.x += _steering.x;
			_velocity.y += _steering.y;
			
			// clamp speed and move boid
			if (_velocity.length > maxSpeed)
			{
				_velocity.normalize(maxSpeed);
			}
			x += _velocity.x * FP.elapsed;
			y += _velocity.y * FP.elapsed;
		}
		
		/**
		 * Adds a behavior to this boid.
		 * @param	behavior
		 * @return
		 */
		public function addBehavior(behavior:Behavior):Behavior
		{
			if (_behaviors[behavior.behaviorClass]) throw new Error("Boid already has a behavior by this name!");
			_behaviors[behavior.behaviorClass] = behavior;
			behavior.added(this);
			return behavior;
		}
		
		/**
		 * Removes a behavior from this boid.
		 * @param	behavior
		 * @return
		 */
		public function removeBehavior(behavior:Class):Behavior
		{
			if (!_behaviors[behavior]) throw new Error("Boid does not have a behavior by this name!");
			var b:Behavior = _behaviors[behavior];
			delete _behaviors[behavior];
			return b;
		}
		
		/**
		 * Gets a behavior from this boid.
		 * @param	behavior
		 * @return
		 */
		public function getBehavior(behavior:Class):Behavior
		{
			if (!_behaviors[behavior]) throw new Error("Boid does not have this behavior!");
			return _behaviors[behavior];
		}
		
		/**
		 * Returns true if boid has a behavior, false if otherwise.
		 * @param	behavior
		 * @return
		 */
		public function hasBehavior(behavior:Class):Boolean
		{
			if (_behaviors[behavior]) return true;
			return false;
		}
	}

}