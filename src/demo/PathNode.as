package demo 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author 
	 */
	public class PathNode extends Entity 
	{
		private var _point:Point;
		private var _image:Image;
		private var _isSelected:Boolean;
		
		public function PathNode(point:Point)
		{
			super(point.x, point.y);
			
			_point = point;
			_isSelected = false;
			_image = Image.createCircle(8, 0x696969);
			_image.centerOO();
			graphic = _image;
			
			setHitbox(16, 16, 8, 8);
		}
		
		override public function added():void 
		{
			super.added();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (!_isSelected)
			{
				if (isMouseOver && Input.mousePressed)
				{
					_isSelected = true;
				}
			}
			else
			{
				if (Input.mouseReleased)
				{
					_isSelected = false;
				}
			}
			
			if (_isSelected)
			{
				x = _point.x = world.mouseX;
				y = _point.y = world.mouseY;
			}
		}
		
	}

}