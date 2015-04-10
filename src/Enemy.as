package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Enemy extends Humanoid
	{	
		public function Enemy() 
		{	
			_art= new enemyArt();
			addChild(_art);
		}
		
	}

}