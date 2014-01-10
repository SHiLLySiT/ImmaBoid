package demo 
{
	import flash.geom.Point;
	import immaboid.behaviors.ArrivalBehavior;
	import immaboid.behaviors.EvadeBehavior;
	import immaboid.behaviors.FleeBehavior;
	import immaboid.behaviors.FollowPathBehavior;
	import immaboid.behaviors.PursuitBehavior;
	import immaboid.behaviors.SeekBehavior;
	import immaboid.behaviors.WanderBehavior;
	import immaboid.Boid;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	public class GameWorld extends World 
	{
		private const STATE_SEEK:int = 0;
		private const STATE_FLEE:int = 1;
		private const STATE_ARRIVAL:int = 2;
		private const STATE_PURSUIT:int = 3;
		private const STATE_EVADE:int = 4;
		private const STATE_WANDER:int = 5;
		private const STATE_PATH:int = 6;
		
		private const LAST_STATE:int = STATE_PATH;
		
		private var _state:int
		private var _boids:Vector.<Boid>;
		private var _info:Text;
		private var _generalInfo:Text;
		private var _points:Vector.<Point>; // use for path behavior
		
		public function GameWorld(state:int = 0) 
		{
			super();
			
			if (state < 0) { _state = LAST_STATE; }
			else if (state > LAST_STATE) { _state = 0; }
			else { _state = state; }
			
			_boids = new Vector.<Boid>();
		}
		
		override public function begin():void 
		{
			super.begin();
			
			// info text
			_info = new Text("", 8, 8);
			_info.alpha = 0.5;
			addGraphic(_info, -100);
			
			// general info text
			_generalInfo = new Text("left/right: switch behavior demo    r: restart current demo", FP.screen.width * 0.5, FP.screen.height - 16);
			_generalInfo.centerOO();
			_generalInfo.alpha = 0.5;
			addGraphic(_generalInfo, -100); 
			
			// setup based on state
			switch (_state)
			{
				case STATE_SEEK:
					_boids[0] = new Zomboid(FP.randRange(FP.screen.width * 0.25, FP.screen.width * 0.75), FP.randRange(FP.screen.height * 0.25, FP.screen.height * 0.75), 0xFF0000);
					_boids[1] = new Zomboid(FP.randRange(FP.screen.width * 0.25, FP.screen.width * 0.75), FP.randRange(FP.screen.height * 0.25, FP.screen.height * 0.75), 0x696969, 0.0);
					
					_boids[0].addBehavior(new SeekBehavior(_boids[1]));
					_boids[0].maxSpeed = 150;
					_boids[0].mass = 10;
					
					_info.text = "SEEK\n-boid seeks mouse";
					break;
				
				case STATE_FLEE:
					_boids[0] = new Zomboid(FP.randRange(FP.screen.width * 0.25, FP.screen.width * 0.75), FP.randRange(FP.screen.height * 0.25, FP.screen.height * 0.75), 0xFF0000);
					_boids[1] = new Zomboid(FP.randRange(FP.screen.width * 0.25, FP.screen.width * 0.75), FP.randRange(FP.screen.height * 0.25, FP.screen.height * 0.75), 0x696969, 0.0);
					
					_boids[0].addBehavior(new FleeBehavior(_boids[1]));
					_boids[0].maxSpeed = 150;
					_boids[0].mass = 10;
					
					_info.text = "FLEE\n-boid flees mouse";
					break;
				
				case STATE_ARRIVAL:
					_boids[0] = new Zomboid(FP.randRange(FP.screen.width * 0.25, FP.screen.width * 0.75), FP.randRange(FP.screen.height * 0.25, FP.screen.height * 0.75), 0xFF0000);
					_boids[1] = new Zomboid(FP.randRange(FP.screen.width * 0.25, FP.screen.width * 0.75), FP.randRange(FP.screen.height * 0.25, FP.screen.height * 0.75), 0x696969);
					
					_boids[0].addBehavior(new ArrivalBehavior(_boids[1], 100));
					_boids[0].maxSpeed = 150;
					_boids[0].mass = 10;
					
					_info.text = "ARRIVAL";
					break;
					
				case STATE_PURSUIT:
					_boids[0] = new Zomboid(FP.screen.width * 0.5, FP.screen.height * 0.5, 0xFF0000);
					_boids[1] = new Zomboid(mouseX, mouseY, 0x00FF00);
					_boids[2] = new Zomboid(mouseX, mouseY, 0x696969, 0.0);
					_boids[3] = new Zomboid(FP.screen.width * 0.5, FP.screen.height * 0.5, 0xFFFF00);
					
					_boids[0].addBehavior(new PursuitBehavior(_boids[1]));
					_boids[0].maxSpeed = 150;
					_boids[0].mass = 10;
					
					_boids[3].addBehavior(new SeekBehavior(_boids[1]));
					_boids[3].maxSpeed = 150;
					_boids[3].mass = 10;
					
					_boids[1].addBehavior(new SeekBehavior(_boids[2]));
					_boids[1].maxSpeed = 180;
					_boids[1].mass = 10;
					
					_info.text = "PURSUIT";
					break;
					
				case STATE_EVADE:
					_boids[0] = new Zomboid(FP.screen.width * 0.5, FP.screen.height * 0.5, 0xFF0000);
					_boids[1] = new Zomboid(mouseX, mouseY, 0x00FF00);
					_boids[2] = new Zomboid(mouseX, mouseY, 0x696969, 0.0);
					_boids[3] = new Zomboid(FP.screen.width * 0.5, FP.screen.height * 0.5, 0xFFFF22);
					
					_boids[0].addBehavior(new EvadeBehavior(_boids[1]));
					_boids[0].maxSpeed = 80;
					_boids[0].mass = 10;
					
					_boids[3].addBehavior(new FleeBehavior(_boids[1]));
					_boids[3].maxSpeed = 80;
					_boids[3].mass = 10;
					
					_boids[1].addBehavior(new SeekBehavior(_boids[2]));
					_boids[1].maxSpeed = 180;
					_boids[1].mass = 10;
					
					_info.text = "EVADE";
					break;
					
				case STATE_WANDER:
					_boids[0] = new Zomboid(FP.randRange(FP.screen.width * 0.25, FP.screen.width * 0.75), FP.randRange(FP.screen.height * 0.25, FP.screen.height * 0.75), 0xFF0000);
					_boids[1] = new Zomboid(FP.randRange(FP.screen.width * 0.25, FP.screen.width * 0.75), FP.randRange(FP.screen.height * 0.25, FP.screen.height * 0.75), 0xFF0000);
					_boids[2] = new Zomboid(FP.randRange(FP.screen.width * 0.25, FP.screen.width * 0.75), FP.randRange(FP.screen.height * 0.25, FP.screen.height * 0.75), 0xFF0000);
					_boids[3] = new Zomboid(FP.randRange(FP.screen.width * 0.25, FP.screen.width * 0.75), FP.randRange(FP.screen.height * 0.25, FP.screen.height * 0.75), 0xFF0000);
					
					_boids[0].addBehavior(new WanderBehavior());
					_boids[0].maxSpeed = 50;
					_boids[0].mass = 10;
					
					_boids[1].addBehavior(new WanderBehavior());
					_boids[1].maxSpeed = 50;
					_boids[1].mass = 10;
					
					_boids[2].addBehavior(new WanderBehavior());
					_boids[2].maxSpeed = 50;
					_boids[2].mass = 10;
					
					_boids[3].addBehavior(new WanderBehavior());
					_boids[3].maxSpeed = 50;
					_boids[3].mass = 10;
					
					_info.text = "WANDER\n-boids randomly wander";
					break;
					
				case STATE_PATH:
					_boids[0] = new Zomboid(FP.screen.width * 0.5, FP.screen.height * 0.5, 0xFF0000);
					
					// holds list of nodes to be added
					var nodes:Vector.<PathNode> = new Vector.<PathNode>();
					// holds list of points for path behavior
					_points = new Vector.<Point>();
					
					// place LEN number of points in a circle around the center of the screen
					var angle:Number = 0, len:int = 10, interval:int = 360 / len;
					for (var i:int = 0; i < len; i++)
					{
						angle += interval;
						
						var p:Point = new Point();
						p.x = FP.screen.width * 0.5 + 100 * Math.cos(angle * FP.RAD);
						p.y = FP.screen.height * 0.5 + 100 * Math.sin(angle * FP.RAD);
						
						_points.push(p);
						nodes.push(new PathNode(p))
					}
					addList(nodes);
					
					_boids[0].addBehavior(new FollowPathBehavior(_points, 20));
					_boids[0].maxSpeed = 150;
					_boids[0].mass = 10;
					
					_info.text = "FOLLOW PATH";
					break;
			}
			
			addList(_boids);
		}
		
		override public function render():void 
		{
			if (_state == STATE_PATH && _points != null)
			{
				if (_points.length > 1)
				{
					// draw lines to nodes for path state
					for (var i:int = 0; i < _points.length-1; i++)
					{
						Draw.line(_points[i].x, _points[i].y, _points[i + 1].x, _points[i + 1].y);
					}
					Draw.line(_points[i].x, _points[i].y, _points[0].x, _points[0].y);
				}
			}
			else if (_state == STATE_ARRIVAL && _boids[0].hasBehavior(ArrivalBehavior))
			{
				Draw.circle(_boids[1].x, _boids[1].y, ArrivalBehavior(_boids[0].getBehavior(ArrivalBehavior)).slowingRadius, 0x00FF00);
			}
			
			super.render();
		}
		
		override public function update():void 
		{
			super.update();
			
			// update based on state
			switch (_state)
			{
				case STATE_SEEK:
					_boids[1].x = mouseX;
					_boids[1].y = mouseY;
					break;
				
				case STATE_FLEE:
					_boids[1].x = mouseX;
					_boids[1].y = mouseY;
					
					_boids[0].x = FP.clamp(_boids[0].x, 0, FP.screen.width);
					_boids[0].y = FP.clamp(_boids[0].y, 0, FP.screen.height);
					break;
					
				case STATE_ARRIVAL:
					
					if (Input.mousePressed)
					{
						_boids[1].x = mouseX;
						_boids[1].y = mouseY;
					}
					
					if (Input.mouseWheel)
					{
						ArrivalBehavior(_boids[0].getBehavior(ArrivalBehavior)).slowingRadius += FP.sign(Input.mouseWheelDelta) * 4 ;
					}
					
					_info.text = "ARRIVAL\n-boid arrives at gray marker\n-click to set marker position\n-mouse wheel to change slowing distance";
					_info.text += "\n-slowing radius: " + ArrivalBehavior(_boids[0].getBehavior(ArrivalBehavior)).slowingRadius;
					break;
					
				case STATE_PURSUIT:
					_boids[2].x = mouseX;
					_boids[2].y = mouseY;
					
					if (Input.mouseWheel)
					{
						PursuitBehavior(_boids[0].getBehavior(PursuitBehavior)).accuracy += FP.sign(Input.mouseWheelDelta) * 0.5;
					}
					
					_info.text = "PURSUIT\n-green boid follows mouse\n-red boid purses green boid\n-for comparison, yellow boid seeks green boid\n-mouse wheel to change accuracy"
					_info.text += "\n-accuracy: " + PursuitBehavior(_boids[0].getBehavior(PursuitBehavior)).accuracy;
					break;
					
				case STATE_EVADE:
					
					_boids[0].x = FP.clamp(_boids[0].x, 0, FP.screen.width);
					_boids[0].y = FP.clamp(_boids[0].y, 0, FP.screen.height);
					
					_boids[3].x = FP.clamp(_boids[3].x, 0, FP.screen.width);
					_boids[3].y = FP.clamp(_boids[3].y, 0, FP.screen.height);
					
					_boids[2].x = mouseX;
					_boids[2].y = mouseY;
					
					if (Input.mouseWheel)
					{
						EvadeBehavior(_boids[0].getBehavior(EvadeBehavior)).accuracy += FP.sign(Input.mouseWheelDelta) * 0.5;
					}
					
					_info.text = "EVADE\ngreen boid follows mouse\n-red boid evades green boid\n-for comparison, yellow boid flees green boid\n-mouse wheel to change accuracy";
					_info.text += "\n-accuracy: " + EvadeBehavior(_boids[0].getBehavior(EvadeBehavior)).accuracy;
					break;
					
				case STATE_WANDER:
					break;
					
				case STATE_PATH:
					_info.text = "FOLLOW PATH\n-boid follows path\n-left click drag nodes to move\n-mouse wheel to change smoothing\n-right click to change direction";
					_info.text += "\n-smoothing: " + FollowPathBehavior(_boids[0].getBehavior(FollowPathBehavior)).radius;
					_info.text += "\n-reversed: " + FollowPathBehavior(_boids[0].getBehavior(FollowPathBehavior)).reverse;
					
					if (Input.mouseWheel)
					{
						FollowPathBehavior(_boids[0].getBehavior(FollowPathBehavior)).radius += FP.sign(Input.mouseWheelDelta);
					}
					
					if (Input.mousePressedRight)
					{
						FollowPathBehavior(_boids[0].getBehavior(FollowPathBehavior)).reverse = !FollowPathBehavior(_boids[0].getBehavior(FollowPathBehavior)).reverse;
					}
					
					break;
			}
			
			// restart current demo
			if (Input.pressed(Key.R))
			{
				FP.world = new GameWorld(_state);
			}
			
			// switch demos
			if (Input.pressed(Key.RIGHT))
			{
				FP.world = new GameWorld(++_state);
			}
			else if (Input.pressed(Key.LEFT))
			{
				FP.world = new GameWorld(--_state);
			}
		}
		
	}

}