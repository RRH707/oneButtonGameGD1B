package 
{
	import flash.automation.StageCaptureEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Main extends Sprite 
	{
		private var _game:Game;
		private var _menu:Menu;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{	
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//adding event listeners for the functions
			addEventListener("addMenu", addMenu);
			addEventListener("addGame", addGame);
			addEventListener("removeMenu", removeMenu);
			addEventListener("removeGame", removeGame);
			stage.addEventListener(Event.ENTER_FRAME, update);	
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			//adding objects
			addMenu(e);
		}
		
		//functions that I run in the main from different classes
		private function onKeyUp(e:KeyboardEvent):void 
		{	
			//running from menu to dispatch events
			if (_menu)
			{
				_menu.onKeyUp(e);
			}
		}
		//creates the game on the button press
		private function onKeyDown(e:KeyboardEvent):void 
		{	
			if (_game)
			{
				_game.onKeyDown(e);
			}
		}
		
		//updates the complete game
		private function update(e:Event):void 
		{
			if (_game)
			{
				_game.update();
			}
		}
		//adds the menu to the stage
		private function addMenu(e:Event):void
		{
			_menu = new Menu(stage);
			addChild(_menu);
		}
		//removes the menu
		private function removeMenu(e:Event):void
		{
			removeChild(_menu);
			_menu = null;
		}
		//adds the game to the stage
		private function addGame(e:Event):void
		{
			_game = new Game(stage);
			addChild(_game);
			
		}
		//removes the game
		private function removeGame(e:Event):void
		{
			removeChild(_game);
			_game = null;
		}
		
		
	}
	
}