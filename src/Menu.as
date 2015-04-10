package  
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Menu extends Sprite
	{	
		//adding variables
		private var _menu:menuArt;
		private var _stage:Stage;
		
		public function Menu(s:Stage) 
		{	
			//instantiating variables
			_stage = s;
			_menu = new menuArt();
			
			addChild(_menu);
			
		}
		
		public function onKeyUp(e:KeyboardEvent):void 
		{	
			//if the button is pressed to start the game it will remove the menu on the key up and add the game.
			if (e.keyCode == 32)
			{	
				dispatchEvent(new Event("addGame", true));
				dispatchEvent(new Event("removeMenu", true));
			}
			
		}
		
	}

}