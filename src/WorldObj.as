package  
{
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class WorldObj extends Sprite 
	{
		private var _tumbleWeed:tumbleArt;
		private var _eagle:eagleArt;
		private var _stage:Stage;
		
		public function WorldObj(s:Stage) 
		{	
			_stage = s;
			
			_tumbleWeed = new tumbleArt;
			_eagle = new eagleArt;
			
			_tumbleWeed.x = _stage.stageWidth / 2 - 500;
			_tumbleWeed.y = _stage.stageHeight / 2 + 160;
			_eagle.x = _stage.stageWidth / 2 - -350;
			_eagle.y = 100;
			
			addChild(_tumbleWeed);
			addChild(_eagle);
			
			_tumbleWeed.gotoAndPlay(0);
			_eagle.gotoAndPlay(0);
		}
		
		public function Update():void
		{
			_eagle.x -= 5;
			_tumbleWeed.x += 3;
			
			if (_tumbleWeed.x > 800)
			{
				_tumbleWeed.x = _stage.stageWidth / 2 - 500
			}
			
			if (_eagle.x < 0)
			{
				_eagle.x = _stage.stageWidth / 2 - -350
			}
		}
		
	}

}