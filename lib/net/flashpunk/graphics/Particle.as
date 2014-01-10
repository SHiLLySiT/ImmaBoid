﻿package net.flashpunk.graphics 
{
	/**
	 * Used by the Emitter class to track an existing Particle.
	 */
	public class Particle 
	{
		/**
		 * Constructor.
		 */
		public function Particle() 
		{
			
		}
		
		// Particle information.
		/** @private */ internal var _type:ParticleType;
		/** @private */ internal var _time:Number;
		/** @private */ internal var _duration:Number;
		
		// Motion information.
		/** @private */ internal var _x:Number;
		/** @private */ internal var _y:Number;
		/** @private */ internal var _moveX:Number;
		/** @private */ internal var _moveY:Number;
		
		// Rotation information.
		/** @private */ internal var _rotation:Number;
		/** @private */ internal var _totalRotation:Number;

		// Gravity information.
		/** @private */ internal var _gravity:Number;
		
		// List information.
		/** @private */ internal var _prev:Particle;
		/** @private */ internal var _next:Particle;
	}
}