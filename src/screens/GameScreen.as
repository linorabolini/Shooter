package screens 
{
	import assets.BallMC;
	import assets.LevelScreen;
	
	import com.core.screens.Screen;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import com.core.components.*;
	
	import com.core.utils.Shaker;
	import com.core.global.audio;
	import com.core.global.settings;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameScreen extends Screen 
	{
		private var _view:LevelScreen;
		

		private var _currentPaddle:int;
		private var _score:int;
		private var shaker:Shaker;
		
		// game data
		private var _ballStartPosition:Object;
		
		/**
		 * The game screen 
		 * Handles all game logic
		 */		
		public function GameScreen() 
		{
		}
		
		/**
		 * Loads the game and sets up players, net, ball and main loop
		 * @param data
		 * 
		 */		
		override public function enter(data:*):void {			
			// audio loop
			audio.loop("music");
			
			// configure the game
			setupGame(settings.gameData); 
			
			super.enter(data);
		}
		
		/**
		 * Main loop 
		 * @param e
		 * 
		 */		
		override public function update(delta:Number):void {
			
			// update shaker
			shaker.update(delta);

			checkCollisions();
			
			super.update(delta);
		}
		
		/**
		 * handle game finish 
		 * 
		 */		
		private function finishGame():void {
			
			// play end audio
			audio.play("success");
			startNewLevel();
		}
		
		/**
		 *  Collision checking
		 * 
		 */		
		private function checkCollisions():void {

		}
		
		/**
		 * Sets up the game from settings data 
		 * @param data
		 * 
		 */		
		private function setupGame(data:Object):void {
			
			// start a new level
			startNewLevel();

		}
		
		/**
		 * Resets and starts a new game 
		 * 
		 */		
		private function startNewLevel():void {

		}
		
		
		/**
		 * Exits the Level screen 
		 * @param data
		 * 
		 */		
		override public function exit(data:*):void {
			
			super.exit(data);
		}
		
	}

}