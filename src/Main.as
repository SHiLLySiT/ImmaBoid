package 
{
	import demo.GameWorld;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	[SWF(width = "600", height = "400")]
	
	public class Main extends Engine
	{
		public function Main()
		{
			super(600, 400, 30);
		}
		
		override public function init():void
		{
			super.init();
			
			FP.console.enable();
			FP.console.visible = false;
			
			FP.world = new GameWorld();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.F1))
			{
				FP.console.visible = !FP.console.visible;
			}
		}
	}
}