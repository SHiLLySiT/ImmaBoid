ImmaBoid
=============

AI steering behavior library for FlashPunk

* Demo can be found here: http://pixelsquidgames.net/projects/immaboid/immaboid_demo.html
* The demo uses my own branch of FlashPunk: https://github.com/SHiLLySiT/FlashPunk
* NOTE: my demo and version of FlashPunk require Flash 11.2+

Features
=============
* Base boid class - extends FlashPunk's entity class to add mass, velocity, and maxspeed
* Boids support multiple behaviors
* Assortment of behaviors to start from

Usage
=============

Simply extend the Boid class and set two parameters:
```ActionScript
public class Zomboid extends Boid 
{
	public function Zomboid(x:Number = 0, y:Number = 0)
	{
		super(x, y);
		
		maxSpeed = 150;
		mass = 10;
	}
}
```

Then add your some behaviors:
```ActionScript
addBehavior(new FleeBehavior(someScaryBoid);
addBehavior(new FollowPathBehavior(pathToAwsome, 20));
```


Changelog
=============
1/09/2014
- Initial commit
