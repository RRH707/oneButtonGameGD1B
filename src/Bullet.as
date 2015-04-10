package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Bullet extends Sprite
	{	
		//adding variables
		private var _bullet:bulletArt;
		private var _dir:int;
		private var _speed:int = 200;
		
		public function Bullet(dir:int) 
		{	
			//instantiating variables
			_dir = dir;
			
			_bullet = new bulletArt();
			
			//adding objects
			addChild(_bullet);
		}
		
		public function update():void
		{	
			//updating the direction of the bullet. it only and will always travel on the X.
			this.x += _dir * _speed;
		}
		
	}

}