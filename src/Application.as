package 
{
	import assets.MainFrame;
	
	import com.core.screens.Screen;
	import com.core.screens.ScreenManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import screens.*;
	
	import com.core.utils.Settings;
	import com.core.global.audio;
	import com.core.global.screenManager;
	import com.core.global.settings;
	
	
	[SWF(width='800', height='480', backgroundColor='0xCCCCCC', frameRate='32')]
	
	/**
	 * Game main class 
	 * @author Lino
	 * 
	 */	
	public class Application extends Sprite 
	{
		private var mainFrame:MainFrame;
		private var _afterTime:Number;
		private var _delta:Number;
		
		public function Application():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * Init the game, audio and settings file 
		 * @param e
		 * 
		 */		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.stageFocusRect = false;
			
			loadAudio();
			//settings.onLoad(onSettingsLoaded).loadFile("../resources/settings.json");
			onSettingsLoaded();
		}
		
		/**
		 * loads the audio files 
		 * 
		 */		
		private function loadAudio():void  {
			audio.registerFx("shoot","../resources/sfx/hit.mp3")
				 .registerFx("menu","../resources/sfx/MenuMusic.mp3")
				 .registerFx("success","../resources/sfx/success.mp3")
				 .registerFx("zombie_hit_0","../resources/sfx/uhh.mp3")
				 .registerFx("zombie_hit_1","../resources/sfx/ow.mp3")
				 .registerFx("success","../resources/sfx/success.mp3")
				 .registerFx("music","../resources/sfx/Gym.mp3");
		}
		
		/**
		 * Handle the end of the setting files load 
		 * startup Main Game view and first screen
		 */		
		private function onSettingsLoaded():void {
			this.mainFrame = new MainFrame();
			stage.addChild(this.mainFrame);
			screenManager = setupScreens();
			screenManager.start("menu");
			
			// get the timer
			_afterTime = getTimer();
			
			// update loop listener
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		/**
		 * Update loop 
		 * @param e
		 * 
		 */		
		private function update(e:Event):void {
			// calculate fixed delta time
			_delta = getTimer() - _afterTime;
			_delta = Math.min(_delta,1.5);
			
			// get the timer
			_afterTime = getTimer();
			
			screenManager.update(_delta);
			
			// get the timer
			_afterTime = getTimer();
		}
		
		/**
		 * Sets up the screen manager 
		 * @return 
		 * 
		 */		
		private function setupScreens():ScreenManager 
		{
			var tmp:ScreenManager = new ScreenManager(this.mainFrame.canvas); // add the screens to the canvas empty movieclip
			
			tmp.registerScreen("menu", Menu)
				.onEvent("play").goto("level");
				
			tmp.registerScreen("level", GameScreen)
				.onEvent("back").goto("menu");
				
			return tmp
		}
		
		/**
		 * Dispose the game 
		 * 
		 */		
		private function dispose():void {
			// dispose update loop
			removeEventListener(Event.ENTER_FRAME, update);
			audio.dispose();
			screenManager.dispose();
		}

		
	}
	
}