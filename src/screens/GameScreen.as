package screens 
{
	import assets.BallMC;
	import assets.LevelScreen;
	
	import com.core.Controller;
	import com.core.GameObject;
	import com.core.components.*;
	import com.core.global.audio;
	import com.core.global.settings;
	import com.core.items.Weapon;
	import com.core.screens.Screen;
	import com.core.utils.Shaker;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameScreen extends Screen 
	{
		private var _view:LevelScreen;
		private var controller:Controller;
		private var gameObjects:Array;

		private var bullets:Array;
		private var players:Array;
		private var zombies:Array;
		
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
			
			checkCollisions();
			
			// update mouse pos
			controller.set(Controller.MOUSE_X, this.mouseX);
			controller.set(Controller.MOUSE_Y, this.mouseY);
			
			// update game objects
			for each(var go:GameObject in gameObjects)
				go.update(delta);
				
			// check if game ended
			var ended:Boolean = true;
			for (var i:int = 0; i < players.length; i++) 
			{
				if(players[i].isActive)
					ended = false;
			}
			
			if(ended)
				finishGame();
			
			super.update(delta);
		}
		
		private function checkCollisions():void
		{
			var go1:GameObject;
			var go2:GameObject;
			
			// bullets against zombies
			for (var i:int = 0; i < bullets.length; i++) 
			{
				go1 = bullets[i];
				
				// skip if unactive
				if(!go1.isActive)
					continue;
				
				for (var j:int = 0; j < zombies.length; j++) 
				{
					go2 = zombies[j];
					
					// skip if unactive
					if(!go2.isActive)
						continue;
					
					if(go1.hitTestObject(go2))
					{
						go1.deactivate();
						go2.deactivate();
						audio.play('zombie_hit_1');
						spawnZombies(2); // spawn more zombies ! 
						break;
					}
				}
			}
			
			// players against zombies
			for (i = 0; i < players.length; i++) 
			{
				go1 = players[i];
				
				// skip if unactive
				if(!go1.isActive)
					continue;
				
				for (j = 0; j < zombies.length; j++) 
				{
					go2 = zombies[j];
					
					// skip if unactive
					if(!go2.isActive)
						continue;
					
					if(go1.hitTestObject(go2))
					{
						go1.deactivate();
						go2.deactivate();
						break;
					}
				}
			}
			
		}
		
		/**
		 * handle game finish 
		 * 
		 */		
		private function finishGame():void {
			
			// play end audio
			audio.play("success");
			
			for each(var go:GameObject in gameObjects)
				go.dispose();
			
			startNewLevel();
		}
		
		/**
		 * Sets up the game from settings data 
		 * @param data
		 * 
		 */		
		private function setupGame(data:Object):void {
			
			// setup controller
			controller = new Controller();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			// start a new level
			startNewLevel();
		}
		
		private function createZombies(number:int):void
		{
			var zombie:GameObject;
			for(var i:int=0; i<number; ++i)
			{
				zombie = createZombie();
			}
		}
		
		private function createZombie():GameObject
		{
			// view
			var view:ImageComponent = new ImageComponent("zombie").center();
			
			// mover handler
			var mover:ZombieMover = new ZombieMover(players);
			
			// create the zombie go
			var zombie:GameObject = new GameObject([view, mover]);
			
			// add bullet
			this.zombies.push(zombie);
			addGameObject(zombie, false);
			
			return zombie;
		}
		
		private function createBullets(number:int):void
		{
			var bullet:GameObject;
			for(var i:int=0; i<number; ++i)
			{
				bullet = createBullet();
			}
		}
		
		private function createBullet():GameObject
		{
			// view
			var view:ImageComponent = new ImageComponent("bullet").center();
			
			// mover handler
			var mover:BasicMover = new BasicMover();
			
			// time to live handler
			var ttl:TimerToLive = new TimerToLive(30);

			var bullet:GameObject = new GameObject([view, mover, ttl]);
			
			// add bullet
			this.bullets.push(bullet);
			addGameObject(bullet, false);
			
			return bullet;
		}
		
		private function createPlayer():GameObject
		{
			// view
			var view:ImageComponent = new ImageComponent("player").center();
			
			// view
			var weapon:Weapon = new Weapon(bullets);
			var inventory:InventoryComponent = new InventoryComponent();
			inventory.addItem(weapon);
			
			// input handler
			var input:PlayerInputComponent = new PlayerInputComponent(controller, inventory);
			
			// our player
			var player:GameObject = new GameObject([view, input, inventory]);
			
			players.push(player);
			addGameObject(player);
			
			player.x = 250;
			player.y = 300;
			
			return player
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			var key:String = String.fromCharCode(event.keyCode).toUpperCase();
			controller.set(key, Controller.FALSE);
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			var key:String = String.fromCharCode(event.keyCode).toUpperCase();
			controller.set(key, Controller.TRUE);
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			controller.set(Controller.MOUSE_LEFT, Controller.FALSE);
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			controller.set(Controller.MOUSE_LEFT, Controller.TRUE);
		}
		
		/**
		 * Resets and starts a new game 
		 * 
		 */
		private function startNewLevel():void {
			
			// gameObjects
			gameObjects = [];
			
			// groups to manage logic
			bullets = [];
			players = [];
			zombies = [];
			
			createBullets(30);
			createPlayer();
			createZombies(100);
			
			spawnZombies(10);
		}
		
		private function spawnZombies(number:int):void
		{
			var zombie:GameObject;
			for(var i:int = 0; i<number; ++i)
			{
				zombie = getZombie();
				
				if(!zombie)
					break;
				
				var position:Point = new Point(Math.random() - 0.5, Math.random() - 0.5);
				position.normalize(Math.random() * 300 + 800);
				
				zombie.x = position.x;
				zombie.y = position.y;
				
				zombie.activate();
			}
		}
		
		public function getZombie():GameObject 
		{
			for ( var i:int = 0; i < zombies.length; ++i) 
			{
				if ( !zombies[i].isActive ) return zombies[i];
			}
			return null;
		}
		
		private function addGameObject(go:GameObject, active:Boolean=true):void
		{
			!active && go.deactivate();
			gameObjects.push(go);
			addChild(go);
		}		

		
		/**
		 * Exits the Level screen 
		 * @param data
		 * 
		 */		
		override public function exit(data:*):void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			super.exit(data);
		}
		
	}

}