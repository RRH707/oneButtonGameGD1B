package  
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundChannel;
	import flash.text.TextField;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Game extends Sprite
	{	
		//adding variables(Classes, objects)to the game. 
		private var _stage:Stage;
		private var _bulletFactory:BulletFactory;
		private var _bullets:Vector.<Bullet>;
		private var _player:Player;
		private var _enemy:Enemy;
		private var _shootTimer:Timer;
		private var _humanoids:Vector.<Humanoid>;
		private var _engine:Engine;
		private var _clock:clockArt;
		private var _clockTimer:Timer;
		private var _shot:Boolean = false;
		private var _endScreen:endArt;
		private var _endTimer:Timer;
		private var _difficulty:int = 100;
		private var _scoreText:TextField;
		private var _score:int = 0;
		private var _playerFire:Boolean = false;
		private var _enemySpawn:Timer;
		private var _background:bgArt;
		private var _winScreen:winArt;
		private var _deathSound:deathSound;
		private var _shootSound:shootSound;
		private var _gameSound:gameSound;
		private var _soundChannel:SoundChannel; 
		public function Game(s:Stage) 
		{	
			//instantiating variables.
			_stage = s;
			
			_bulletFactory = new BulletFactory();
			_bullets = new Vector.<Bullet>;
			_player = new Player();
			_enemy = new Enemy();
			_shootTimer = new Timer(_difficulty, 1);
			_humanoids = new Vector.<Humanoid>;
			_engine = new Engine(_humanoids, _bullets, removeHumanoid);
			_clock = new clockArt();
			_clockTimer = new Timer(500, 10);
			_endScreen = new endArt();
			_endTimer = new Timer(1000, 1);
			_scoreText = new TextField();
			_enemySpawn = new Timer(3000, 1);
			_background = new bgArt();
			_deathSound = new deathSound();
			_shootSound = new shootSound();
			_gameSound = new gameSound();
			_soundChannel = new SoundChannel();
			
			
			_scoreText.text = "Score" + " " + _score;
			
			//positioning Gameobjects.
			_player.x = _stage.stageWidth / 2 - 350;
			_player.y = _stage.stageHeight / 2 + 160;
			_enemy.x = _stage.stageWidth / 2 - -250;
			_enemy.y = _stage.stageHeight / 2 + 160;
			_clock.x = _stage.stageWidth / 2;
			_clock.y = _stage.stageHeight / 2 - 150;
			_endScreen.x = _stage.stageWidth / 2;
			_endScreen.y = _stage.stageHeight / 2;
			_scoreText.x = 0;
			_scoreText.y = 50;
			_background.x = _stage.stageWidth / 2;
			_background.y = _stage.stageHeight / 2;
			
			//pushing humanoid objects into vector.
			_humanoids.push(_player, _enemy);
			
			//adding eventlisteners to timers.
			_shootTimer.addEventListener(TimerEvent.TIMER, shootTimer);
			_clockTimer.addEventListener(TimerEvent.TIMER, clockTimer);
			_endTimer.addEventListener(TimerEvent.TIMER, endGame);
			_enemySpawn.addEventListener(TimerEvent.TIMER, enemyCooldown);
			
			//adding objects to the game.
			addChild(_background);
			addChild(_player);
			addChild(_enemy);
			addChild(_clock);
			addChild(_scoreText);
			
			//Setting the frame for movieclip
			_clock.gotoAndStop(0);
			_player._art.gotoAndStop(0);
			_enemy._art.gotoAndStop(0);
			
			_soundChannel = _gameSound.play();
		}
		
		private function enemyCooldown(e:TimerEvent):void 
		{
			_clock.gotoAndStop(0)
			spawnEnemy();
			_shootTimer = null;
			if (_difficulty > 10) 
			{
				_difficulty -= 10;
			}
			else
			{
				_difficulty = Math.floor(Math.random() * 5)
			}
			_shootTimer = new Timer(_difficulty, 1);
			_shootTimer.addEventListener(TimerEvent.TIMER, shootTimer);
			_score += 100;
			_playerFire = false;
			_enemySpawn.stop();
			_shot = false;
		}
		
		private function endGame(e:TimerEvent):void 
		{	
			//dispatching events when the function endGame gets called.
			dispatchEvent(new Event("addMenu", true));
			dispatchEvent(new Event("removeGame", true));
			_soundChannel.stop();
		}
		
		private function clockTimer(e:TimerEvent):void 
		{	
			//if this function runs the currentframe of the movieclip will be increased with 5.
			_clock.gotoAndStop(_clock.currentFrame + 5);
		}
		
		public function update():void
		{	
			
			//looping trough the bullets array and updating them
			if (_bullets.length != 0)
			{
				for (var i:int = _bullets.length - 1; i >= 0; i--)
				{
					_bullets[i].update();
				}
			}
			//if the engine exists it gets updated
			if (_engine)
			{
				_engine.update();
			}
		
			//if the clock is done ticking the timer for the enemy to shoot starts
			if (_clock.currentFrame >= 45 && _shot == false)
			{
				_shot = true;
			    _shootTimer.start();
			}
		
			//if the enemy exists the clock timer starts running
			if (_enemy)
			{
				_clockTimer.start();
			}
			
			//if there are no objects in the array it means both the player and the enemy are dead. So the game restarts
			if (_humanoids.length == 0)
			{
				_endTimer.start();
			}
			
			
			
			/*in the humanoids vector there are always 2 objects. The enemy and the player. This sorts out what should happen if one or another doesnt
			exist anymore*/
			if (_humanoids.length == 1)
			{	
				// if the player has shot before the clock reached its peak You lose. 
				if (_clock.currentFrame < 45 && _humanoids[0] is Player)
				{
					_endTimer.start();
					addChild(_endScreen);
				}
				
				//if the object in the array left is the player it should spawn a better enemy. It also restarts the shoot timer for the enemy.
				if (_humanoids[0] is Player)
				{
					_enemySpawn.start();
				}
				else 
				{	
					//if the player has died the endtimer starts for the game to end.
					_endTimer.start();
				}
			}
		
			_scoreText.text = "Score" + " " + _score;
		} 
		
		public function onKeyDown(e:KeyboardEvent):void
		{	
			//function to make the player shoot.
			//also checks if the player has shot a bullet.
			if (e.keyCode == 32 && _playerFire == false && _humanoids[0] is Player)
			{	
				//creating a bullet and adding it on the stage
				_bullets.push(_bulletFactory.createBullet(1));
				_bullets[_bullets.length - 1].x = _player.x;
				_bullets[_bullets.length - 1].y = _player.y;
				addChild(_bullets[_bullets.length - 1]);
				_playerFire = true;
				_player._art.gotoAndStop(2);
				_shootSound.play();
			}
			
		}
		
		//what happens if the shoottimer ends
		public function shootTimer(e:TimerEvent):void
		{	
			if (_humanoids.length > 1)
			{
				//creating a bullet and adding it on the stage
				_bullets.push(_bulletFactory.createBullet(-1));
				_bullets[_bullets.length - 1].x = _humanoids[1].x;
				_bullets[_bullets.length - 1].y = _humanoids[1].y;
				addChild(_bullets[_bullets.length - 1]);
				_enemy._art.gotoAndStop(2);
				_shootSound.play();
			}
		}
		
		//function for removing the player or the enemy.
		public function removeHumanoid(h:Humanoid, id:int):void
		{
			removeChild(h);
			_humanoids.splice(id, 1);
			
			//if the enemy gets removed. the shoot timer will stop.
			if (h is Enemy)
			{	
				_deathSound.play();
				if (_shootTimer && _clock.currentFrame > 45)
				{
					_shootTimer.stop();
					_winScreen = new winArt();
					addChild(_winScreen);
					_winScreen.x = _stage.stageWidth / 2;
					_winScreen.y = _stage.stageHeight / 2 ;
					
				}
			}
			
			//if the humanoid left in the array is the player that gets removed the game will end.
			if (h is Player)
			{
				addChild(_endScreen);
				_deathSound.play();
			}
		}
		//function for spawning a new enemy after the old one died
		public function spawnEnemy():void
		{	
			if (_winScreen)
			{
				removeChild(_winScreen);
				_winScreen = null;
			}
			//i create the enemy and push it into the humanoids array so it always consists of 2 objects.
			var enemy:Enemy = new Enemy();
			enemy._art.gotoAndStop(1);
			enemy.x = _enemy.x;
			enemy.y = _enemy.y;
			addChild(enemy);
			_humanoids.push(enemy);
			_player._art.gotoAndStop(1);
			
		}
	}

}