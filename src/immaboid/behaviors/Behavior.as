
package immaboid.behaviors 
{
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import immaboid.Boid;
	
	public class Behavior 
	{
		private var _behaviorClass:Class;
		/** Class name of this behavior. */
		public function get behaviorClass():Class { return _behaviorClass; }
		
		private var _boid:Boid;
		/** Parent boid. */
		public function get boid():Boid { return _boid; }
		
		protected var _steering:Point;
		
		/**
		 * Base behavior class.
		 */
		public function Behavior() 
		{
			_behaviorClass = Class(getDefinitionByName(getQualifiedClassName(this)));
			_boid = null;
			_steering = new Point();
		}
		
		/**
		 * Called when the behavior is added to a boid.
		 * @param	boid
		 */
		public function added(boid:Boid):void
		{
			_boid = boid;
		}
		
		/**
		 * Updates the behavior.
		 */
		public function update(steering:Point):void
		{
		}
	}

}