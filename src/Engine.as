package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Engine 
	{	
		//adding variables
		private var _humanoids:Vector.<Humanoid>;
		private var _bullets:Vector.<Bullet>;
		private var _removeHumanoid:Function;
		
		public function Engine(hums:Vector.<Humanoid>, bulls:Vector.<Bullet>, rmvHums:Function) 
		{	
			//instatiating variables
			_humanoids = hums;
			_bullets = bulls;
			_removeHumanoid = rmvHums;
		}
		 
		public function update():void
		{	
			//looping trough the bullets to see if they collide with the humanoids.
			for (var i:int = 0; i < _bullets.length;  i++)
			{
				for (var j:int = 0; j < _humanoids.length; j++)
				{	
					//if they do collide this if statement will be set in motion.
					if (_bullets[i].hitTestPoint(_humanoids[j].x, _humanoids[j].y, false))
					{
						_removeHumanoid(_humanoids[j], j);
					}
				}
			}
		}
		
	}

}