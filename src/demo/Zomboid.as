package demo 
{
	import immaboid.behaviors.SeekBehavior;
	import immaboid.Boid;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author 
	 */
	public class Zomboid extends Boid 
	{
		private var _image:Image;
		
		public function Zomboid(x:Number = 0, y:Number = 0, color:int = 0xFF0000, alpha:Number = 1.0)
		{
			super(x, y, graphic, mask);
			
			_image = Image.createRect(24, 24, color, alpha);
			_image.centerOO();
			graphic = _image;
			
		}
		
		override public function update():void 
		{
			super.update();
			
			_image.angle = Math.atan2(velocity.y, velocity.x) * FP.DEG;
		}
	}

}