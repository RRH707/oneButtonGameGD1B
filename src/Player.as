package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Player extends Humanoid
	{
		
		public function Player() 
		{
			_art = new playerArt();
			addChild(_art);
		}
		
	}

}