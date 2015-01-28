package screens 
{
	import assets.MenuScreen;
	
	import com.core.screens.Screen;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.core.global.audio;
	import com.core.global.screenManager;
	
	/**
	 * ...
	 * @author 
	 */
	public class Menu extends Screen
	{
		private var _view:MenuScreen;
		
		/**
		 * The menu will handle the different options the user has 
		 * It is the first screen of the game
		 */		
		public function Menu() 
		{
		}
		
		/**
		 * Enters the menu and sets up the screen 
		 * @param data
		 * 
		 */		
		public override function enter(data:*):void {
			//set up view
			_view = new MenuScreen;
			addChild(_view);

			stage.focus = this;

			audio.loop("menu");
			
			_view.playBtn.addEventListener(MouseEvent.CLICK, onClick);
			
			super.enter(data);
		}
		
		private function onClick(e:MouseEvent):void {
			_view.playBtn.removeEventListener(MouseEvent.CLICK, onClick);
			screenManager.dispatchEvent("play");
		}
		
		/**
		 * Exits the menu screen 
		 * @param data
		 * 
		 */		
		public override function exit(data:*):void {
			// dispose view
			removeChild(_view);
			_view = null;
			
			audio.stop("menu");
			
			super.exit(data);
		}
		
	}

}